-- configure lualine status line for NeoVim
local ll = require('lualine')

-- lualine options
local lualine_options = {
  theme = 'ayu_mirage'
}
local lualine_extensions = {
  'quickfix',
  'fugitive',
  'fzf',
  'nerdtree'
}

-- setup statusline
ll.setup({ options = lualine_options, extensions = lualine_extensions })
