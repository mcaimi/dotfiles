-- lua keybindings
local utils = require('utils.utils')

-- mapping options
local options = { noremap = true }

-- mappings
-- <mode> <lhand_map> <rhand_map> <options>
local plugin_command_mapping = {
  {'n', '<C-t>', ':TagbarToggle<CR>', options},
  {'n', '<C-G>', ':GitGutterToggle<CR>', options},
  {'n', '<C-u>', ':PackerSync<CR>', options},
  {'n', '<F3>', ':NERDTreeToggle<CR>', options},
  {'n', '<F5>', ':UndotreeToggle<CR>', options},
}
local command_mapping = {
  {'n', '<C-^>', ':lopen<CR>', options},
  {'n', '<C-?>', ':copen<CR>', options},
  {'n', '<Leader>w', ':w<CR>', options},
  {'n', '<Leader>f', ':FZF<CR>', options},
  {'n', '<Leader>q', ':wq<CR>', options},
  {'n', '<Leader>a', ':bp<CR>', options},
  {'n', '<Leader>s', ':bn<CR>', options},
  {'n', '<Leader>c', ':bd<CR>', options},
  {'n', '<Leader>+', ':lua require(\'plugin_config.lsp_config\').install_lsp_servers()<CR>', options},
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

