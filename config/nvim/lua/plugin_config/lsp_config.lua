-- configuration for LSPs
local mason = require('mason')
local mason_lsp = require('mason-lspconfig')
local utils = require('utils.tables')
local M = {}

-- custom settings
mason.setup( {
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})
mason_lsp.setup( {
  ensure_installed = utils.supported_languages
})

return M
