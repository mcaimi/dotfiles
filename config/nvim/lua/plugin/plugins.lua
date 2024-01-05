-- load packer
local packerLib = require('packer')

-- load plugins
local function loadPlugins()
  -- packer itself first
  use {
    opt = false,
    'wbthomason/packer.nvim'
  }

  -- syntax highlight and completion plugin
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use {
    'hrsh7th/nvim-cmp',
    opt = false,
    requires = {{'hrsh7th/cmp-nvim-lsp', opt = false},
                { 'hrsh7th/cmp-buffer', opt = false},
                { 'hrsh7th/cmp-path', opt = false},
                { 'hrsh7th/cmp-cmdline', opt = false},
                { 'neovim/nvim-lspconfig', opt = false},
              }
  }
  use {
    'hrsh7th/vim-vsnip',
    opt=false,
    requires = {{'hrsh7th/cmp-vsnip', opt = false }}
  }
  use {
    'williamboman/mason.nvim',
    opt = false,
    requires = {{ 'mfussenegger/nvim-dap', opt=false }, {'jose-elias-alvarez/null-ls.nvim', opt=false } , { 'williamboman/mason-lspconfig.nvim', opt=false }, { 'neovim/nvim-lspconfig', opt = false }},
  }

  -- features plugins
  use {
    'Xuyuanp/nerdtree-git-plugin',
    opt = true,
    requires = {{'scrooloose/nerdtree', opt = true, cmd = { 'NERDTreeToggle' }}}
  }
  use {
    'majutsushi/tagbar',
    opt = true,
    cmd = { 'TagbarToggle' }
  }
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }
  use {
    'glepnir/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('plugin_config.dashboard_config').init_dash()
    end,
    requires = { 'nvim-telescope/telescope.nvim' }
  }
  use 'mbbill/undotree'
  use 'godlygeek/tabular'
  use 'gennaro-tedesco/nvim-peekup'
  use {
    'junegunn/goyo.vim',
    opt = true,
    cmd = { 'Goyo' }
  }
  use {
    'folke/noice.nvim',
    opt=true
  }

  -- statusline & tabline
  use {
    'akinsho/bufferline.nvim',
    requires = 'nvim-tree/nvim-web-devicons',
    opt = false
  }
  use {
    'glepnir/galaxyline.nvim',
    branch = 'main',
    config = function()
      require('plugin_config.gline_config')
    end,
    -- some optional icons
    requires = { 'nvim-tree/nvim-web-devicons', opt = true },
  }

  -- vim imported plugins
  use 'justinmk/vim-sneak'
  use 'ryanoasis/vim-devicons'
  use 'tpope/vim-fugitive'
  use 'airblade/vim-gitgutter'
  use 'npxbr/glow.nvim'

  -- themes and colors
  use {
    "kyazdani42/blue-moon",
    config = function()
      vim.opt.termguicolors = true
      vim.cmd "colorscheme blue-moon"
    end
  }
end

-- run packer
packerLib.startup(loadPlugins)
