" NeoVIM main config file
"
" enable syntax highlighting
syntax enable

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark

" Do not be compatible with plain vi
if &compatible
  set nocompatible               " Be iMproved
endif
set path+=./**

" bootstrap packer
lua require('plugin.bootstrap_packer')
" load vimrc settings from lua script
lua require('vim_settings')
" load plugins
lua require('plugin.plugins')
" configure lualine
lua require('plugin_config.lualine_config')
" configure bufferline
lua require('plugin_config.bufferline_config')
" configure dashboard
lua require('plugin_config.dashboard_config')
" configure treesitter
lua require('plugin_config.treesitter_config')
" configure language server installer
lua require('plugin_config.lsp_config')
" configure autocomplete
lua require('plugin_config.nvim_cmp_config')
" load vim keybindings
lua require('vim_keybindings')
" load vim autocommands
lua require('vim_autocommands')

" load custom color scheme
colorscheme ayu

" GUI font setting
if has('gui_running')
  set guifont=Iosevka:h10
endif

" Post-load plugin setup
let g:undotree_WindowLayout=2
let g:undotree_SetFocusWhenToggle=1
if has("persistent_undo")
    set undodir=~/.undodir/
    set undofile
endif

" peekup
let g:peekup_open = '<Leader>2'

" Required for ftplugins
filetype plugin on

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

" Tell Vim which characters to show for expanded TABs,
" trailing whitespace, and end-of-lines. VERY useful!
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

" improve autocomplete menu color
" Also highlight all tabs and trailing whitespace characters.
" highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
" match ExtraWhitespace /\s\+$\|\t/
"
highlight Pmenu ctermbg=black gui=bold
highlight Conceal cterm=bold ctermfg=8 gui=bold guifg=#8F8F8F guibg=#282828
highlight Comment cterm=italic

" EOF
