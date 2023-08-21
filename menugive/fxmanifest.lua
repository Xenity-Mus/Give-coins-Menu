fx_version 'cerulean'
games { 'rdr3', 'gta5' }

shared_scripts {
    'config.lua'
}

client_scripts {
    "internal/RageUI/RMenu.lua",
    "internal/RageUI/menu/RageUI.lua",
    "internal/RageUI/menu/Menu.lua",
    "internal/RageUI/menu/MenuController.lua",
    "internal/RageUI/components/*.lua",
    "internal/RageUI/menu/elements/*.lua",
    "internal/RageUI/menu/items/*.lua",
    "internal/RageUI/menu/panels/*.lua",
    "internal/RageUI/menu/windows/*.lua",
    'client/*.lua',
    'menus/*.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server/*.lua',
    'internal/LiteMySQL.lua'
}