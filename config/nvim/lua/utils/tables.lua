-- constant and global arrays

M = {}

-- nvim_lsp and cmp backends
local lang_list = {
  'clangd',
--  'dockerls',
  'jdtls',
--  'bashls',
--  'yamlls',
  'gopls',
  'pylsp',
  'texlab',
  'rust_analyzer',
  'lua_ls',
}

M.supported_languages = lang_list

-- return module
return M
