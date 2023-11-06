Config = {}
Config.Debug = false

Config.BarrelRefreshTime = 10 --minutes (10min = 1 year)
Config.PluckTime = 3 --seconds
Config.FillTime = 3 --seconds
Config.SqueezeTime = 10 --seconds

Config.PluckReset = 1 --Minutes
Config.BerryItem = 'berry' --Item from grabbing berry
Config.GrabAmount = math.random(3,5)
Config.PluckZones = {
    [1] = {
        isbussy = false,
        loc = vector3(-1875.39, 2099.34, 139.12),
        box = {
            h = 0,
            min = 1,
            max = 1,
            w = 1,
            d = 3,
        }
    },
    [2] = {
        isbussy = false,
        loc = vector3(-1879.6, 2099.3, 139.12),
        box = {
            h = 0,
            min = 1,
            max = 1,
            w = 1,
            d = 3,
        }
    },
    [3] = {
        isbussy = false,
        loc = vector3(-1884.52, 2099.63, 139.12),
        box = {
            h = 0,
            min = 1,
            max = 1,
            w = 1,
            d = 3,
        }
    },
    [4] = {
        isbussy = false,
        loc = vector3(-1891.34, 2100.49, 138.26),
        box = {
            h = 0,
            min = 1,
            max = 1,
            w = 1,
            d = 3,
        }
    },
    [5] = {
        isbussy = false,
        loc = vector3(-1901.35, 2101.38, 135.97),
        box = {
            h = 0,
            min = 1,
            max = 1,
            w = 1,
            d = 3,
        }
    },
    [6] = {
        isbussy = false,
        loc = vector3(-1909.91, 2102.36, 132.85),
        box = {
            h = 0,
            min = 1,
            max = 1,
            w = 1,
            d = 3,
        }
    },
    [7] = {
        isbussy = false,
        loc = vector3(-1873.73, 2103.72, 137.63),
        box = {
            h = 0,
            min = 1,
            max = 1,
            w = 1,
            d = 3,
        }
    },
    [8] = {
        isbussy = false,
        loc = vector3(-1881.94, 2104.26, 137.8),
        box = {
            h = 0,
            min = 1,
            max = 1,
            w = 1,
            d = 3,
        }
    },
    [9] = {
        isbussy = false,
        loc = vector3(-1889.85, 2105.07, 136.51),
        box = {
            h = 0,
            min = 1,
            max = 1,
            w = 1,
            d = 3,
        }
    },
    [10] = {
        isbussy = false,
        loc = vector3(-1896.67, 2105.56, 135.52),
        box = {
            h = 0,
            min = 1,
            max = 1,
            w = 1,
            d = 3,
        }
    },
    [11] = {
        isbussy = false,
        loc = vector3(-1903.37, 2106.01, 133.24),
        box = {
            h = 0,
            min = 1,
            max = 1,
            w = 1,
            d = 3,
        }
    },
    [12] = {
        isbussy = false,
        loc = vector3(-1909.69, 2106.78, 131.25),
        box = {
            h = 0,
            min = 1,
            max = 1,
            w = 1,
            d = 3,
        }
    },
    [13] = {
        isbussy = false,
        loc = vector3(-1860.02, 2098.31, 138.03),
        box = {
            h = 0,
            min = 1,
            max = 1,
            w = 1,
            d = 3,
        }
    },
    [14] = {
        isbussy = false,
        loc = vector3(-1851.57, 2102.05, 137.71),
        box = {
            h = 0,
            min = 1,
            max = 1,
            w = 1,
            d = 3,
        }
    },
    [15] = {
        isbussy = false,
        loc = vector3(-1845.5, 2104.99, 137.6),
        box = {
            h = 0,
            min = 1,
            max = 1,
            w = 1,
            d = 3,
        }
    },
    [16] = {
        isbussy = false,
        loc = vector3(-1834.41, 2110.18, 136.31),
        box = {
            h = 0,
            min = 1,
            max = 1,
            w = 1,
            d = 3,
        }
    },
    [17] = {
        isbussy = false,
        loc = vector3(-1826.99, 2113.77, 134.46),
        box = {
            h = 0,
            min = 1,
            max = 1,
            w = 1,
            d = 3,
        }
    },
    [18] = {
        isbussy = false,
        loc = vector3(-1820.87, 2116.58, 133.2),
        box = {
            h = 0,
            min = 1,
            max = 1,
            w = 1,
            d = 3,
        }
    },
    [19] = {
        isbussy = false,
        loc = vector3(-1811.95, 2120.51, 131.43),
        box = {
            h = 0,
            min = 1,
            max = 1,
            w = 1,
            d = 3,
        }
    },
    [20] = {
        isbussy = false,
        loc = vector3(-1853.15, 2106.55, 135.57),
        box = {
            h = 0,
            min = 1,
            max = 1,
            w = 1,
            d = 3,
        }
    },
    [21] = {
        isbussy = false,
        loc = vector3(-1843.67, 2110.99, 134.68),
        box = {
            h = 0,
            min = 1,
            max = 1,
            w = 1,
            d = 3,
        }
    },
    [22] = {
        isbussy = false,
        loc = vector3(-1836.09, 2114.26, 133.64),
        box = {
            h = 0,
            min = 1,
            max = 1,
            w = 1,
            d = 3,
        }
    },
    [23] = {
        isbussy = false,
        loc = vector3(-1828.48, 2117.94, 132.19),
        box = {
            h = 0,
            min = 1,
            max = 1,
            w = 1,
            d = 3,
        }
    },
    [24] = {
        isbussy = false,
        loc = vector3(-1820.11, 2121.84, 130.47),
        box = {
            h = 0,
            min = 1,
            max = 1,
            w = 1,
            d = 3,
        }
    },
    [25] = {
        isbussy = false,
        loc = vector3(-1811.95, 2125.63, 129.04),
        box = {
            h = 0,
            min = 1,
            max = 1,
            w = 1,
            d = 3,
        }
    },
    [26] = {
        isbussy = false,
        loc = vector3(-1802.04, 2130.38, 127.45),
        box = {
            h = 0,
            min = 1,
            max = 1,
            w = 1,
            d = 3,
        }
    },
    [27] = {
        isbussy = false,
        loc = vector3(-1792.51, 2134.77, 126.87),
        box = {
            h = 0,
            min = 1,
            max = 1,
            w = 1,
            d = 3,
        }
    },
    [28] = {
        isbussy = false,
        loc = vector3(-1850.22, 2089.91, 139.34),
        box = {
            h = 0,
            min = 1,
            max = 1,
            w = 1,
            d = 3,
        }
    },
    [29] = {
        isbussy = false,
        loc = vector3(-1843.2, 2094.21, 138.74),
        box = {
            h = 0,
            min = 1,
            max = 1,
            w = 1,
            d = 3,
        }
    },
    [30] = {
        isbussy = false,
        loc = vector3(-1833.54, 2099.47, 137.66),
        box = {
            h = 0,
            min = 1,
            max = 1,
            w = 1,
            d = 3,
        }
    }
}

Config.BarrelZones = {
    [1] = {
        name = 'zone1',
        zone = {
            vector2(1599.26, 2128.6),
            vector2(1599.36, 2274.84),
            vector2(1483.43, 2276.87),
            vector2(1462.26, 2280.32),
            vector2(1423.68, 2354.05),
            vector2(1446.76, 2351.58),
            vector2(1449.97, 2336.11),
            vector2(1455.73, 2326.34),
            vector2(1470.15, 2317.57),
            vector2(1488.94, 2312.44),
            vector2(1510.53, 2330.17),
            vector2(1531.93, 2343.73),
            vector2(1546.58, 2343.8),
            vector2(1653.33, 2322.84),
            vector2(1680.92, 2334.82),
            vector2(1691.99, 2311.3),
            vector2(1724.39, 2316.51),
            vector2(1751.31, 2315.16),
            vector2(1757.48, 2305.16),
            vector2(1754.34, 2290.77),
            vector2(1757.37, 2278.05),
            vector2(1757.26, 2259.58),
            vector2(1748.93, 2250.37),
            vector2(1748.95, 2214.52),
            vector2(1731.68, 2151.69),
            vector2(1706.73, 2124.7),
            vector2(1626.94, 2011.46),
            vector2(1599.92, 1957.58),
            vector2(1509.12, 2119.49),
            vector2(1551.8, 2124.5)
        },
    },
    [2] = {
        name = 'zone2',
        zone = {
            vector2(227.29, 2445.92),
            vector2(226.24, 2460.72),
            vector2(230.23, 2485.34),
            vector2(236.55, 2505.4),
            vector2(253.84, 2530.82),
            vector2(267.23, 2545.0),
            vector2(287.98, 2558.8),
            vector2(302.92, 2564.46),
            vector2(311.26, 2561.88),
            vector2(324.06, 2546.62),
            vector2(342.56, 2522.75),
            vector2(356.9, 2507.61),
            vector2(374.92, 2487.08),
            vector2(360.57, 2477.65),
            vector2(331.61, 2478.81),
            vector2(307.47, 2479.18),
            vector2(297.88, 2478.44),
            vector2(279.13, 2478.77),
            vector2(260.37, 2474.84),
            vector2(247.17, 2464.15),
            vector2(235.74, 2451.39)
        },
    }
}

Config.BarrelOwnerCheck = true --If it needs to check for owner or not before filling a bottle
Config.BarrelItem = 'wine_barrel'
Config.MaxBarrels = 5
Config.MaxFills = 4 --How many bottles can you fill
Config.BarrelModel = 'vw_prop_vw_barrel_01a'
Config.BucketModel = 'prop_bucket_02a'

Config.BucketItem = {
    empty = 'wine_emptybucket', --Itemname of the bucket you need to squeeze the berrys
    full = 'wine_fullbucket', --Itemname of the fullbucket
}

Config.WineStages = {
    [1] = {
        name = 'zinfandel',
        stage = 2
    },
    [2] = {
        name = 'malbec',
        stage = 5
    },
    [3] = {
        name = 'tempranillo',
        stage = 7
    },
    [4] = {
        name = 'sangiovese',
        stage = 10
    },
    [5] = {
        name = 'nebbiolo',
        stage = 15
    },
}

Config.YearsTillExpired = 5 --Last WineStage years + this = expired / bad

Config.NeededItems = {
    Stage1 = {
        [1] = {
            item = 'berry',
            amount = 10,
        },
    },
    Stage2 = {
        [1] = {
            item = 'wine_fullbucket',
            amount = 1,
        },
        [2] = {
            item = 'wine_yeast',
            amount = 5,
        },
        [3] = {
            item = 'farm_regador_cheio',
            amount = 1,
        }
    },
    Stage3 = {
        [1] = {
            item = 'wine_emptybottle',
            amount = 1,
        }
    }
}

Config.RewardItems = {
    Stage1 = {
        [1] = {
            item = 'wine_fullbucket',
            amount = 1,
        },
    },
    Stage2 = {
        [1] = {
            item = 'wine_emptybucket',
            amount = 1,
        },
    },
}