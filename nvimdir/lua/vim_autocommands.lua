-- autocommand definition
local utils = require('utils.utils')

-- configure compound autocommands
utils.nvim_cmd('autocmd FileType dashboard set showtabline=0 | autocmd WinLeave <buffer> set showtabline=2')

local autocommand_definitions = {
  {'VimEnter', '*', 'GitGutterLineHighlightsDisable'},
  {'BufEnter', 'jenkinsfile*', 'set', 'filetype=groovy'},
  {'BufNewFile', '*.py', '0r', '~/Work/dotfiles/templates/python.spec'},
  {'BufNewFile', '*.c', '0r', '~/Work/dotfiles/templates/c.spec'},
  {'FileType', 'python', 'set', 'ai', 'sw=4', 'ts=4', 'sta', 'et', 'fo=croql'},
  {'BufWritePost', '*.py', 'retab! 4'},
}

-- declare autogroups
utils.autogroup('basesettings', autocommand_definitions)

