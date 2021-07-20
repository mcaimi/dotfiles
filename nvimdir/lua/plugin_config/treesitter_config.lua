-- configuration for treesitter plugin
local ts_config = require('nvim-treesitter.configs')

-- configure treesitter modules
ts_config.setup{
  ensure_installed = {'c', 'lua', 'python', 'bash', 'latex', 'rust', 'go', 'dockerfile', 'java', 'html', 'rst', 'yaml'},
  highlight = {
    enable = true,
  }
}
