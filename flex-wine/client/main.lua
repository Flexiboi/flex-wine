local QBCore = exports['qb-core']:GetCoreObject()
local pluckZones = {}
local barrelZones, currentZone = {}, nil
local barrelList = {}
local bucket = nil
local bucketZone = nil

exports['qb-target']:AddTargetModel(Config.BarrelModel, {
    options = {
        {
            label = Lang:t("target.barrel"),
            icon = 'fa fa-plus',
            action = function(entity)
                local pos = GetEntityCoords(entity)
                if Config.Debug then
                    print(math.floor(tonumber(pos.x)))
                    print(math.floor(tonumber(pos.y)))
                    print(math.floor(tonumber(pos.z)))
                end
                local coords = vec3(math.floor(tonumber(pos.x)), math.floor(tonumber(pos.y)), math.floor(tonumber(pos.z)))
                TriggerEvent('flex-wine:client:BarrelMenu', coords, nil)
            end,
        }
    },
    distance = 1.5
})

for k, v in pairs(Config.PluckZones) do
    pluckZones[k] = exports['qb-target']:AddBoxZone("pluckzone"..k, v.loc, v.box.w, v.box.d, {
        name = "pluckzone"..k,
        heading = v.box.h,
        debugPoly = Config.Debug,
        minZ = v.loc.z-v.box.min,
        maxZ = v.loc.z+v.box.max,
    }, {
        options = {
            {
                label = Lang:t('target.pluck'),
                icon = 'fa fa-hand-rock-o',
                type = "client",
                action = function()
                    TriggerEvent("flex-wine:client:Pluck", k, v.loc)
                end,
                canInteract = function()
                    return not v.isbussy
                end
            },
        },
        distance = 1.5
    })
end

for k, v in pairs(Config.BarrelZones) do
    barrelZones[k] = PolyZone:Create(v.zone, {name = v.name, debugPoly = Config.Debug})
    barrelZones[k]:onPlayerInOut(function(isPointInside, point, zone)
        if isPointInside then
            currentZone = v.name
            QBCore.Functions.TriggerCallback('flex-wine:server:GetZoneBarrels', function(barrels)
                if barrels then
                    for k, v in pairs(barrels) do
                        local vec3pos = json.decode(v.coords)
                        local pos = vec3(vec3pos.x, vec3pos.y, vec3pos.z)
                        barrelList[v.barrelid] = CreateObject(Config.BarrelModel, pos, true)
                        SetModelAsNoLongerNeeded(barrelList[v.barrelid])
                        PlaceObjectOnGroundProperly(barrelList[v.barrelid])
                        FreezeEntityPosition(barrelList[v.barrelid], true)
                    end
                end
            end, v.name)
        else
            currentZone = nil
            for k, v in pairs(barrelList) do
                if DoesEntityExist(v) then
                    DeleteEntity(v)
                end
            end
        end
    end)
end

function tablefind(tab,el)
    for index, value in pairs(tab) do
        if value == el then
            return index
        end
    end
end

function Round(num, dp)
    local mult = 10^(dp or 0)
    return math.floor(num * mult + 0.5)/mult
end

RegisterNetEvent('flex-wine:client:PlaceBucket', function(id)
    if bucket == nil then
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local rot = GetEntityRotation(ped)
        bucket = CreateObject(Config.BucketModel, pos, true)
        PlaceObjectOnGroundProperly(bucket)
        SetEntityRotation(bucket, 0.0, 0.0, rot, false, false)
        FreezeEntityPosition(bucket, true)
        bucketZone = exports['qb-target']:AddTargetModel(Config.BucketModel, {
            options = {
                {
                    label = Lang:t('target.squeeze', {value = tostring(Config.NeededItems.Stage1[1].amount)}),
                    icon = 'fa fa-hand-rock-o',
                    type = "client",
                    action = function(entity)
                        TriggerEvent('flex-wine:client:Squeeze', GetEntityCoords(entity))
                    end,
                },
                {
                    label = Lang:t('target.pickupbucket'),
                    icon = 'fa fa-hand-rock-o',
                    type = "client",
                    action = function()
                        QBCore.Functions.PlayAnim('mp_take_money_mg', 'put_cash_into_bag_loop', 1, 1500)
                        exports['qb-target']:RemoveTargetModel(Config.BucketModel)
                        DeleteEntity(bucket)
                        bucket = nil
                        TriggerServerEvent('flex-wine:server:AddItem', Config.BucketItem.empty, 1)
                    end,
                },
            },
            distance = 1.5
        })
    else
        QBCore.Functions.Notify(Lang:t("error.alreadybucket"), "error") 
    end
end)

RegisterNetEvent('flex-wine:client:PlaceBarrel', function(id)
    if currentZone ~= nil then
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local coords = vec3(math.floor(tonumber(pos.x)), math.floor(tonumber(pos.y)), math.floor(tonumber(pos.z)))
        barrelList[id] = CreateObject(Config.BarrelModel, coords, true)
        PlaceObjectOnGroundProperly(barrelList[id])
        local bpos = GetEntityCoords(barrelList[id])
        local bcoords = vec3(math.floor(tonumber(bpos.x)), math.floor(tonumber(bpos.y)), math.floor(tonumber(bpos.z)))
        TriggerServerEvent('flex-wine:server:RegisterBarrel', id, bcoords, currentZone)
        TriggerServerEvent('flex-wine:server:RemoveItem', Config.BarrelItem, 1)
    else
        QBCore.Functions.Notify(Lang:t("error.cantplacehere"), "error") 
    end
end)

RegisterNetEvent('flex-wine:client:DeleteBarrel', function(id, coords)
    local barrel = GetClosestObjectOfType(coords, 1, GetHashKey(Config.BarrelModel), 0, 0, 0)
    table.remove(barrelList, tablefind(barrelList, id))
end)

RegisterNetEvent('flex-wine:client:BarrelMenu', function(coords, data)
    local barrelpos = coords
    if data then
        barrelpos = data.entcoords
    end
    QBCore.Functions.TriggerCallback('flex-wine:server:BarrelAge', function(barrelage)
        if barrelage then
            local BM = {
                {
                    header = Lang:t("menu.header", {value = tostring(barrelage)}),
                    icon = "fa-solid fa-circle-info",
                    isMenuHeader = true,
                },
                {
                    header = Lang:t("menu.checkfillh"),
                    txt = Lang:t("menu.checkfill"),
                    icon = "fa-solid fa-list",
                    params = {
                        event = "flex-wine:client:CheckFillLevel",
                        args = {
                            entcoords = barrelpos,
                        }
                    }
                },
                {
                    header = Lang:t("menu.fillbottle"),
                    icon = "fa-solid fa-list",
                    params = {
                        event = "flex-wine:client:FillBottle",
                        args = {
                            entcoords = barrelpos,
                        }
                    }
                },
                {
                    header = "Sluit",
                    icon = "fa-solid fa-angle-left",
                    params = {
                        event = "qb-menu:closeMenu",
                    }
                },
            }
            exports['qb-menu']:openMenu(BM)
        else
            QBCore.Functions.Notify(Lang:t("error.barrelnotexist"), "error") 
        end
    end, barrelpos)
end)

RegisterNetEvent('flex-wine:client:CheckFillLevel', function(data)
    QBCore.Functions.TriggerCallback('flex-wine:server:CheckLevel', function(filllvl)
        local FL = {}
        if filllvl then 
            FL[#FL+1] = {
                header = Lang:t("menu.fillheader", {value = tostring(filllvl)}),
                icon = "fa-solid fa-circle-info",
                isMenuHeader = true,
            }
            FL[#FL+1] = {
                header = Lang:t("menu.fillbarrel"),
                icon = "fa-solid fa-list",
                params = {
                    event = "flex-wine:client:FillBarrel",
                    args = {
                        filllevel = filllvl,
                        entcoords = data.entcoords,
                    }
                }
            }
            FL[#FL+1] = {
                header = "",
                icon = "fa-solid fa-angle-left",
                params = {
                    event = "flex-wine:client:BarrelMenu",
                    args = {
                        filllevel = filllvl,
                        entcoords = data.entcoords,
                    }
                }
            }
        end
        exports['qb-menu']:openMenu(FL)
    end, data.entcoords)

end)

RegisterNetEvent('flex-wine:client:Squeeze', function(coords)
    QBCore.Functions.TriggerCallback("flex-wine:server:HasItems", function(output)
        if output then
            local ped = PlayerPedId()
            local animdic = "amb@world_human_jog_standing@male@idle_a"
            QBCore.Functions.GetPlayerData(function(PlayerData)
                if PlayerData.charinfo.gender == 1 then
                    animdic = "amb@world_human_jog_standing@female@idle_a" 
                end
            end)
            SetEntityCoords(ped, coords.x,coords.y,coords.z)
            QBCore.Functions.Progressbar("Squeezing", Lang:t("info.squeezing") , 1000 * Config.SqueezeTime, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = true,
                disableCombat = true,
            }, {
                animDict = animdic,
                anim = "idle_a",
                flags = 0,
                task = nil,
            }, {}, {},function() -- Done
                ClearPedTasks(ped)
                QBCore.Functions.PlayAnim('mp_take_money_mg', 'put_cash_into_bag_loop', 1, 1500)
                exports['qb-target']:RemoveZone(bucketZone)
                DeleteEntity(bucket)
                bucket = nil
                TriggerServerEvent('flex-wine:server:AddItem', Config.BucketItem.full, 1)
                TriggerServerEvent('flex-wine:server:RemoveItems', Config.NeededItems.Stage1)
            end, function() -- Cancel
                ClearPedTasks(ped)
                QBCore.Functions.Notify(Lang:t("error.stoppedsqueeze"), 'error', 5000)
            end)
        end
    end, Config.NeededItems.Stage1)
end)

RegisterNetEvent('flex-wine:client:FillBarrel', function(data)
    if data.filllevel >= 100 then 
        return QBCore.Functions.Notify(Lang:t("error.barrelfull"), "error") 
    else
        QBCore.Functions.TriggerCallback("flex-wine:server:HasItems", function(output)
            local pos = data.entcoords
            if output then
                local ped = PlayerPedId()
                local pedpos = GetEntityCoords(ped)
                local handbucket = CreateObject(joaat(Config.BucketModel), pedpos.x, pedpos.y, pedpos.z + 0.2, true, true, true)
                SetEntityCollision(handbucket, false, false)
                AttachEntityToEntity(handbucket, ped, GetPedBoneIndex(ped, 36029), 0.23, -0.19, -0.13, 45.0, 1.3, 180.0, 1, 1, 0, true, 2, 1)
                QBCore.Functions.FaceToPos(pos.x, pos.y, pos.z)
                QBCore.Functions.Progressbar("FillingBarrel", Lang:t("info.filling") , 1000 * Config.FillTime, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = "timetable@gardener@filling_can",
                    anim = "gar_ig_5_filling_can",
                    flags = 0,
                    task = nil,
                }, {}, {},function() -- Done
                    ClearPedTasks(ped)
                    TriggerServerEvent('flex-wine:server:FillBarrel', pos)
                    TriggerServerEvent('flex-wine:server:AddItem', Config.BucketItem.empty, 1)
                    TriggerServerEvent('flex-wine:server:RemoveItems', Config.NeededItems.Stage2)
                    DeleteObject(handbucket)
                end, function() -- Cancel
                    ClearPedTasks(ped)
                    QBCore.Functions.Notify(Lang:t("error.stoppedfilling"), 'error', 5000)
                    DeleteObject(handbucket)
                end)
            end
        end, Config.NeededItems.Stage2)
    end
end)

RegisterNetEvent('flex-wine:client:FillBottle', function(data)
    local pos = vec3(math.floor(tonumber(data.entcoords.x)), math.floor(tonumber(data.entcoords.y)), math.floor(tonumber(data.entcoords.z)))
    QBCore.Functions.TriggerCallback('flex-wine:server:BarrelAge', function(age)
        if age then
            for k, v in pairs(Config.BarrelZones) do
                if age < k then
                    return QBCore.Functions.Notify(Lang:t("error.toyoungbarrel"), 'error', 5000)
                end
            end
            QBCore.Functions.TriggerCallback('flex-wine:server:CheckLevel', function(filllvl)
                if filllvl then
                    if filllvl <= 0 then 
                        return QBCore.Functions.Notify(Lang:t("error.barrelempty"), "error") 
                    else
                        QBCore.Functions.TriggerCallback("flex-wine:server:IsOwner", function(owner)
                            if owner or not Config.BarrelOwnerCheck then
                                QBCore.Functions.TriggerCallback("flex-wine:server:HasItems", function(output)
                                    if output then
                                        local ped = PlayerPedId()
                                        local pedpos = GetEntityCoords(ped)
                                        local bottle = CreateObject(joaat('prop_wine_bot_01'), pedpos.x, pedpos.y, pedpos.z + 0.2, true, true, true)
                                        SetEntityCollision(bottle, false, false)
                                        AttachEntityToEntity(bottle, ped, GetPedBoneIndex(ped, 36029), 0.1, -0.1, 0.05, -90.0, 0.0, 0.0, 1, 1, 0, true, 2, 1)
                                        QBCore.Functions.FaceToPos(pos.x, pos.y, pos.z)
                                        QBCore.Functions.Progressbar("Plucking", Lang:t("info.filling") , 1000 * Config.FillTime, false, true, {
                                            disableMovement = true,
                                            disableCarMovement = true,
                                            disableMouse = false,
                                            disableCombat = true,
                                        }, {
                                            animDict = "anim@amb@business@weed@weed_inspecting_lo_med_hi@",
                                            anim = "weed_crouch_checkingleaves_idle_01_inspector",
                                            flags = 0,
                                            task = nil,
                                        }, {}, {},function() -- Done
                                            ClearPedTasks(ped)
                                            TriggerServerEvent('flex-wine:server:FillBottle', pos)
                                            TriggerServerEvent('flex-wine:server:RemoveItems', Config.NeededItems.Stage3)
                                            DeleteObject(bottle)
                                        end, function() -- Cancel
                                            ClearPedTasks(ped)
                                            QBCore.Functions.Notify(Lang:t("error.stoppedfilling"), 'error', 5000)
                                            DeleteObject(bottle)
                                        end)
                                    end
                                end, Config.NeededItems.Stage3)
                            else
                                QBCore.Functions.Notify(Lang:t("error.notowner"), 'error', 5000)
                            end
                        end, pos)
                    end
                end
            end, pos)
        else
            QBCore.Functions.Notify(Lang:t("error.toyoungbarrel"), 'error', 5000)
        end
    end, pos)
end)

RegisterNetEvent('flex-wine:client:Pluck', function(id, coords)
    local ped = PlayerPedId()
    TriggerServerEvent('flex-wine:server:PluckState', id, true)
    QBCore.Functions.FaceToPos(coords.x, coords.y, coords.z)
    SetTimeout(Config.PluckReset * 60 * 1000, function()
        TriggerServerEvent('flex-wine:server:Pluck', id, true)
    end)
    QBCore.Functions.Progressbar("Plucking", Lang:t("info.plucking") , 1000 * Config.PluckTime, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = true,
        disableCombat = true,
    }, {
        animDict = "anim@amb@business@weed@weed_inspecting_lo_med_hi@",
        anim = "weed_crouch_checkingleaves_idle_01_inspector",
        flags = 0,
        task = nil,
    }, {}, {},function() -- Done
        ClearPedTasks(ped)
        TriggerServerEvent('flex-wine:server:AddItem', Config.BerryItem, Config.GrabAmount)
    end, function() -- Cancel
        ClearPedTasks(ped)
        QBCore.Functions.Notify(Lang:t("error.stoppedpluck"), 'error', 5000)
    end)
end)

RegisterNetEvent('flex-wine:client:PluckState', function(id, state)
    Config.PluckZones[id].isbussy = state
end)

AddEventHandler('onResourceStop', function(resource) if resource ~= GetCurrentResourceName() then return end
    for k,v in pairs(barrelZones) do
        exports['qb-target']:RemoveZone(barrelZones[k])
    end
    for k,v in pairs(pluckZones) do
        exports['qb-target']:RemoveZone(pluckZones[k])
    end
    for k, v in pairs(barrelList) do
        if DoesEntityExist(v) then
            DeleteEntity(v)
        end
    end
end)