-- configure dashboard options

local home = os.getenv('HOME')
local db = require('dashboard')

db.preview_command = 'bat -pp'
db.preview_file_path = home .. '/.config/nvim/logo.cat'
db.preview_file_height = 20
db.preview_file_width = 100

db.custom_center = {
    {icon = '  ',
    desc = 'Recently latest session                 ',
    shortcut = 'Leader s l',
    action ='SessionLoad'},
    {icon = '  ',
    desc = 'Recently opened files                   ',
    action =  'DashboardFindHistory',
    shortcut = 'Leader f h'},
    {icon = '  ',
    desc = 'Find  File                              ',
    action = 'Telescope find_files find_command=rg,--hidden,--files',
    shortcut = 'Leader f f'},
    {icon = '  ',
    desc ='File Browser                            ',
    action =  'Telescope file_browser',
    shortcut = 'Leader f b'},
    {icon = '  ',
    desc = 'Find  word                              ',
    action = 'Telescope live_grep',
    shortcut = 'Leader f w'},
    {icon = '  ',
    desc = 'Open Personal dotfiles                  ',
    action = 'Telescope dotfiles path=' .. home ..'/.dotfiles',
    shortcut = 'Leader f d'},
  }

