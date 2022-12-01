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
    'hrsh7th/cmp-nvim-lsp',
    opt = false,
    requires = {{'hrsh7th/nvim-cmp', opt = false}, { 'neovim/nvim-lspconfig', opt = false}}
  }
  use {
    'williamboman/nvim-lsp-installer',
    opt = false,
    requires = { 'neovim/nvim-lspconfig', opt = false },
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

  -- statusline & tabline
  use {
    'akinsho/bufferline.nvim',
    requires = 'nvim-tree/nvim-web-devicons',
    opt = false
  }
  use {
    'hoob3rt/lualine.nvim',
    requires = {'nvim-tree/nvim-web-devicons', opt = false},
    opt = false
  }

  -- vim imported plugins
  use 'justinmk/vim-sneak'
  use 'ryanoasis/vim-devicons'
  use 'tpope/vim-fugitive'
  use 'airblade/vim-gitgutter'
  use 'npxbr/glow.nvim'

  -- themes and colors
  use 'ayu-theme/ayu-vim'
end

-- run packer
packerLib.startup(loadPlugins)
