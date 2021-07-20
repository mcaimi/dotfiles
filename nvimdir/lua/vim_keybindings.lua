-- lua keybindings
local utils = require('utils.utils')

-- mapping options
local options = { noremap = true }

-- mappings
-- <mode> <lhand_map> <rhand_map> <options>
local plugin_command_mapping = {
  {'n', '<C-t>', ':TagBarToggle<CR>', options},
  {'n', '<C-G>', ':GitGutterToggle<CR>', options},
  {'n', '<C-u>', ':PackerSync<CR>', options},
  {'n', '<F3>', ':NERDTreeToggle<CR>', options},
  {'n', '<F5>', ':UndoTreeToggle<CR>', options},
  {'n', '<Leader>fh', ':DashboardFindHistory<CR>', { noremap = true, silent = true }},
  {'n', '<Leader>ff', ':DashboardFindFile<CR>', { noremap = true, silent = true }},
  {'n', '<Leader>tc', ':DashboardChangeColorscheme<CR>', { noremap = true, silent = true }},
  {'n', '<Leader>fa', ':DashboardFindWord<CR>', { noremap = true, silent = true }},
  {'n', '<Leader>fb', ':DashboardJumpMark<CR>', { noremap = true, silent = true }},
  {'n', '<Leader>cn', ':DashboardNewFile<CR>', { noremap = true, silent = true }},
}
local command_mapping = {
  {'n', '<C-^>', ':lopen<CR>', options},
  {'n', '<C-?>', ':copen<CR>', options},
  {'n', '<Leader>w', ':w<CR>', options},
  {'n', '<Leader>q', ':wq<CR>', options},
  {'n', '<Leader>a', ':bp<CR>', options},
  {'n', '<Leader>s', ':bn<CR>', options},
  {'n', '<Leader>c', ':bd<CR>', options},
}
local convenience_mapping = {
  {'n', '<Leader>1', ':g/^\\s*$/d_<CR>', options},
  {'i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', { noremap = true, expr = true }},
  {'i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"', { noremap = true, expr = true }},
}

-- Custom Commands
utils.create_mapping(command_mapping)

-- Convenience Mappings
utils.create_mapping(convenience_mapping)

-- Plugin Command Mappings
utils.create_mapping(plugin_command_mapping)

