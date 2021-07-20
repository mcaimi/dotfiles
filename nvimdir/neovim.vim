" Load archlinux commons
runtime! archlinux.vim

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

" load vimrc settings from lua script
lua require('settings')

" bootstrap packer
lua require('plugin.bootstrap_packer')
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

" load custom color scheme
let ayucolor="mirage"
colorscheme ayu
if (has("termguicolors"))
 set termguicolors
endif
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
" dashboard menu settings
let g:dashboard_custom_shortcut={
\ 'last_session'       : '<Leader> s l',
\ 'find_history'       : '<Leader> f h',
\ 'find_file'          : '<Leader> f f',
\ 'new_file'           : '<Leader> c n',
\ 'change_colorscheme' : '<Leader> t c',
\ 'find_word'          : '<Leader> f a',
\ 'book_marks'         : '<Leader> f b',
\ }
" peekup
let g:peekup_open = '<Leader>]'

" Required for ftplugins
filetype plugin indent on

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

" Tell Vim which characters to show for expanded TABs,
" trailing whitespace, and end-of-lines. VERY useful!
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

" Also highlight all tabs and trailing whitespace characters.
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$\|\t/

" relative/normal line numbering choice function
" Relative numbering
function! NumberToggle()
  if(&relativenumber == 1)
    set nornu
    set number
  else
    set rnu
  endif
endfunc

" improve autocomplete menu color
highlight Pmenu ctermbg=black gui=bold
highlight Conceal cterm=bold ctermfg=8 gui=bold guifg=#8F8F8F guibg=#282828
highlight Comment cterm=italic

" Auto Commands Configuration
autocmd! BufWritePost *.py retab! 4
autocmd VimEnter * GitGutterLineHighlightsDisable
autocmd InsertEnter * set number
autocmd InsertLeave * set relativenumber
autocmd FileType python set tabstop=4|set shiftwidth=4|set expandtab
autocmd BufEnter *.py set ai sw=4 ts=4 sta et fo=croql
autocmd BufNewFile *.py 0r ~/Work/dotfiles/templates/python.spec
autocmd BufNewFile *.c 0r ~/Work/dotfiles/templates/c.spec
autocmd BufNewFile *.ksprofile 0r ~/Work/dotfiles/templates/ksprofile.spec
autocmd BufEnter jenkinsfile* set filetype=groovy
autocmd FileType dashboard set showtabline=0 | autocmd WinLeave <buffer> set showtabline=2

" Remapping of some custom commands
map <C-t> :TagbarToggle<CR>
map <C-^> :lopen<CR>
map <C-?> :copen<CR>
map <C-G> :GitGutterToggle<CR>
map <C-u> :PackerSync<CR>
map <F5> :UndotreeToggle<CR>

" convenience maps
noremap <Leader>1 :g/^\s*$/d_<CR>
noremap <Leader>w :w<CR>
noremap <Leader>q :wq<CR>
noremap <Leader>a :bp<CR>
noremap <Leader>s :bn<CR>
noremap <Leader>c :bd<CR>
noremap <F3> :NERDTreeToggle<CR>

" dashboard remaps
nnoremap <silent> <Leader>fh :DashboardFindHistory<CR>
nnoremap <silent> <Leader>ff :DashboardFindFile<CR>
nnoremap <silent> <Leader>tc :DashboardChangeColorscheme<CR>
nnoremap <silent> <Leader>fa :DashboardFindWord<CR>
nnoremap <silent> <Leader>fb :DashboardJumpMark<CR>
nnoremap <silent> <Leader>cn :DashboardNewFile<CR>

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Function calls at the end of vim load phase
call NumberToggle()

