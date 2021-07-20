-- autocommand definition
local utils = require('utils.utils')

-- configure compound autocommands
utils.nvim_cmd('autocmd FileType dashboard set showtabline=0 | autocmd WinLeave <buffer> set showtabline=2')
