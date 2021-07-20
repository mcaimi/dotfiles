-- configure dashboard options

-- vars
local fuzzyfinder_plugin = 'telescope'
local logo_file_path = '~/.config/nvim/logo.cat'
local logo_w = 100
local logo_h = 20

-- logo pipeline configuration
vim.g.dashboard_preview_command = 'bat -pp'
vim.g.dashboard_preview_pipeline = 'bat -pp'

-- setup configuration options
vim.g.dashboard_default_executive = fuzzyfinder_plugin
vim.g.dashboard_preview_file = logo_file_path
vim.g.dashboard_preview_file_height = logo_h
vim.g.dashboard_preview_file_width = logo_w

