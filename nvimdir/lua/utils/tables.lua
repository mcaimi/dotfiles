-- constant and global arrays

M = {}

-- nvim_lsp and cmp backends
local lang_list = {
  'clangd',
  'dockerls',
  'jdtls',
  'bashls',
  'yamlls',
  'sumneko_lua',
  'gopls',
  'pylsp',
  'texlab',
}

M.supported_languages = lang_list

-- return module
return M
