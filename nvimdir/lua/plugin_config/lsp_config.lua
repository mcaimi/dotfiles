-- configuration for LSPs
local lspinst = require('nvim-lsp-installer')
local lspservers = require('nvim-lsp-installer.servers')
local utils = require('utils.tables')
local M = {}

-- custom settings
lspinst.settings {
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
}

-- declare which servers need to be installed/updated on load
local lang_list = utils.supported_languages

-- install or upgrade servers
local function install_lsp_servers()
  for _, language in pairs(lang_list) do
    local ok, server = lspservers.get_server(language)
    if ok then
      if not server:is_installed() then
        server:install()
      end
    end
  end
end

-- setup lsp plugin
lspinst.on_server_ready(function(server)
  local opts = {}

  server:setup(opts)
  vim.cmd [[ do User LspAttachBuffers ]]
end)

-- exported symbols
M.required_language_servers = lang_list
M.install_lsp_servers = install_lsp_servers

return M
