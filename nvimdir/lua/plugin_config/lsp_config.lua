-- configuration for LSPs
local lspcfg = require('lspconfig')
local lspinst = require('lspinstall')
local utils = require('utils.utils')
local M = {}

-- declare which servers need to be installed/updated on load
local lang_list = {
  'cpp',
  'dockerfile',
  'bash',
  'yaml',
  'lua',
  'go',
}

-- setup lspinstall plugin
lspinst.setup()

-- install or upgrade servers
local function install_lsp_servers()
  local is = lspinst.installed_servers()
  for _, language in pairs(lang_list) do
    if not utils.contains(is, language) then
      lspinst.install_server(language)
    end
  end
end

-- call lspconfig for each LSP installed
local function setup_lsp_servers()
  for _, server in pairs(lspinst.installed_servers()) do
      lspcfg[server].setup{}
  end
end

-- install and configure lsp servers
setup_lsp_servers()

-- setup post-install hook: setup servers on every update
lspcfg.post_install_hook = function () setup_lsp_servers() end

-- return public functions
M.install_lsp_servers = install_lsp_servers
return M
