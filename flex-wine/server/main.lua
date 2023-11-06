local QBCore = exports['qb-core']:GetCoreObject()

local stageamount = 0
CreateThread(function()
    while true do
        Wait((60 * 1000) * Config.BarrelRefreshTime)
        local barrels = MySQL.query.await('SELECT * FROM wine_barrels', {})
        for k, v in pairs(barrels) do
            local stage = 0
            for l, q in pairs(Config.WineStages) do
                if Config.WineStages[l].name == barrels[k].stage then
                    if Config.WineStages[l].name ~= Config.WineStages[#Config.WineStages].name then
                        stage = Config.WineStages[l+1].stage
                    end
                end
            end
            if barrels[k].progress >= (Config.WineStages[#Config.WineStages].stage + Config.YearsTillExpired) then
                TriggerClientEvent('flex-wine:client:DeleteBarrel', -1, barrels[k].id, barrels[k].coords)
                MySQL.query('DELETE FROM wine_barrels WHERE owner = ?',{barrels[k].owner})
                local player = QBCore.Functions.GetPlayerByCitizenId(barrels[k].owner)
                break TriggerClientEvent('QBCore:Notify', player.PlayerData.source, Lang:t("error.barrelgotbad"), "error")
            elseif barrels[k].progress == stage then
                for s, w in pairs(Config.WineStages) do
                    stageamount = stageamount + 1
                    if Config.WineStages[s].stage  == barrels[k].progress then
                        MySQL.update('UPDATE wine_barrels SET stage = ?, progress = ? WHERE owner = ?', { Config.WineStages[s].name , barrels[k].progress + 1, barrels[k].owner })
                    end
                end
            else
                MySQL.update('UPDATE wine_barrels SET progress = ? WHERE owner = ?', { barrels[k].progress + 1, barrels[k].owner })
            end
        end
    end
end)

QBCore.Functions.CreateUseableItem(Config.BucketItem.empty, function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.RemoveItem(item.name, 1) then
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item.name], "remove")
        TriggerClientEvent('flex-wine:client:PlaceBucket', src)
    end
end)

local function CheckBerrelAmount(cid)
    local barrels = MySQL.query.await('SELECT * FROM wine_barrels', {})
    local amount = 0
    for k, _ in pairs(barrels) do
        if barrels[k].owner == cid then
            amount = amount + 1
        end
    end
    return amount
end

local function GenerateBarrelId(cid)
    local barrelid = QBCore.Shared.RandomInt(3) .. QBCore.Shared.RandomStr(2) .. QBCore.Shared.RandomInt(4) .. QBCore.Shared.RandomStr(5)
    local result = MySQL.scalar.await('SELECT barrelid FROM wine_barrels WHERE barrelid = ?', {barrelid})
    if result then
        return GenerateBarrelId(cid)
    else
        return barrelid:upper()
    end
end

QBCore.Functions.CreateUseableItem(Config.BarrelItem, function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local cid = Player.PlayerData.citizenid
    local BarrelAmount = CheckBerrelAmount(cid)
    local BarrelId = GenerateBarrelId(cid)
    if BarrelAmount < Config.MaxBarrels then
        TriggerClientEvent('flex-wine:client:PlaceBarrel', src, BarrelId)
    else
        TriggerClientEvent('QBCore:Notify', src, Lang:t("error.tomanybarrels"), "error")
    end
end)

QBCore.Functions.CreateCallback("flex-wine:server:GetZoneBarrels", function(source, cb, zone)
    MySQL.query('SELECT * FROM wine_barrels WHERE zone = ?',{zone}, function(result)
        if result[1] then
            cb(result)
        else
            cb(false)
        end
    end)
end)

QBCore.Functions.CreateCallback("flex-wine:server:HasItems", function(source, cb, items)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local total = 0
    for k,v in pairs(items) do
        local item = Player.Functions.GetItemByName(v.item)
        if item and v.amount >= v.amount then
            total = total + 1
        else
            TriggerClientEvent('QBCore:Notify', src, Lang:t("error.missingitem", {value = tostring(v.amount), value2 = tostring(QBCore.Shared.Items[v.item].label)}), "error")
        end
    end
    if total >= #items then
        cb(true)
    else
        cb(false)
    end
end)

RegisterNetEvent('flex-wine:server:PluckState', function(id, state)
    TriggerClientEvent('flex-wine:client:PluckState', -1, id, state)
end)

RegisterNetEvent('flex-wine:server:RegisterBarrel', function(id, coords, zone)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local cid = Player.PlayerData.citizenid
    MySQL.insert('INSERT INTO wine_barrels (owner, barrelid, coords, zone, fill, progress, stage) VALUES (?, ?, ?, ?, ?, ?, ?)',
    {cid, id, json.encode(coords), zone, 0, 0, 'zinfandel'})
end)

QBCore.Functions.CreateCallback("flex-wine:server:BarrelAge", function(source, cb, coords)
    MySQL.query('SELECT * FROM wine_barrels WHERE coords = ?',{json.encode(coords)}, function(result)
        if result[1] then
            cb(result[1].progress)
        else
            cb(false)
        end
    end)
end)

QBCore.Functions.CreateCallback("flex-wine:server:CheckLevel", function(source, cb, coords)
    MySQL.query('SELECT * FROM wine_barrels WHERE coords = ?',{json.encode(coords)}, function(result)
        if result[1] then
            cb(result[1].fill)
        else
            cb(0)
        end
    end)
end)

QBCore.Functions.CreateCallback("flex-wine:server:IsOwner", function(source, cb, coords)
    MySQL.query('SELECT * FROM wine_barrels WHERE coords = ?',{json.encode(coords)}, function(result)
        if result[1] then
            local src = source
            local Player = QBCore.Functions.GetPlayer(src)
            local cid = Player.PlayerData.citizenid
            if result[1].owner == cid then
                cb(true)
            else
                cb(false)
            end
        else
            cb(false)
        end
    end)
end)

RegisterNetEvent('flex-wine:server:FillBarrel', function(coords)
    local src = source
    local barrels = MySQL.query.await('SELECT * FROM wine_barrels WHERE coords = ?', { json.encode(coords)})
    local fillamount = 100 / Config.MaxFills
    local fill = tonumber(barrels[1].fill) + fillamount
    if barrels[1] then
        TriggerClientEvent('QBCore:Notify', src, Lang:t("success.filledbarrel", {value = tostring(fill)}), 'info')
        MySQL.update('UPDATE wine_barrels SET fill = ? WHERE coords = ?', { json.encode(fill), json.encode(coords) })
    end
end)

RegisterNetEvent('flex-wine:server:FillBottle', function(coords)
    local src = source
    local barrels = MySQL.query.await('SELECT * FROM wine_barrels WHERE coords = ?', { json.encode(coords)})
    if barrels[1] then
        local fillamount = 100 / Config.MaxFills
        local fill = tonumber(barrels[1].fill) - fillamount
        TriggerClientEvent('QBCore:Notify', src, Lang:t("success.filledbottle", {value = tostring(fill)}), 'info')
        if fill <= 0 then
            local o = 0
            for k, v in pairs(Config.WineStages) do
                o = o + 1
                if o == 1 then
                    MySQL.update('UPDATE wine_barrels SET fill = ?, progress = ?, stage = ? WHERE coords = ?', { json.encode(fill), 0, tostring(k), json.encode(coords) })
                    break
                end
            end
        else
            MySQL.update('UPDATE wine_barrels SET fill = ? WHERE coords = ?', { json.encode(fill), json.encode(coords) })
            if fill <= 0 then
                MySQL.update('UPDATE wine_barrels SET fill = ? WHERE coords = ?', { json.encode(fill), json.encode(coords) })
            end
        end
        local Player = QBCore.Functions.GetPlayer(src)
        if Player.Functions.AddItem(barrels[1].stage, 1) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[barrels[1].stage], 'add')
        end
    end
end)

RegisterNetEvent('flex-wine:server:RemoveItem', function(item, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.RemoveItem(item, amount) then
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "remove", amount)
    end
end)

RegisterNetEvent('flex-wine:server:RemoveItems', function(items)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    for k,v in pairs(items) do
        if Player.Functions.RemoveItem(v.item, v.amount) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[v.item], "remove", v.amount)
        end
    end
end)

RegisterNetEvent('flex-wine:server:AddItem', function(item, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.AddItem(item, amount) then
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'add', amount)
    end
end)

RegisterNetEvent('flex-wine:server:AddItems', function(items)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    for k,v in pairs(items) do
        if Player.Functions.AddItem(v.item, v.amount) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[v.item], 'add', v.amount)
        end
    end
end)