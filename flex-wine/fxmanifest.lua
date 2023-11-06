fx_version "bodacious"
game "gta5"
lua54 "yes"

author "flexiboi"
description "Flex-wine"
version "1.0.0"

shared_scripts {
    'config.lua',
    '@qb-core/shared/locale.lua',
    'locales/en.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
    'server/*.lua',
}

client_scripts {
	'@PolyZone/client.lua',
	'@PolyZone/BoxZone.lua',
	'@PolyZone/ComboZone.lua',
	'client/*.lua',
}

dependencies {
	'qb-core'
}