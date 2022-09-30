fx_version 'cerulean'
game 'gta5'


description 'Turns Any Vehicle To A Drift Machien With A Chip'
version '1.0.0'

shared_scripts {
    '@qb-core/shared/locale.lua',
    'locales/en.lua',
    'config.lua',
}

author 'CookieOCore'

description 'Cooke-DriftChip'

version '1.0'

client_script {
    'client/main.lua'
}

server_script {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua'
}