" Load archlinux commons
runtime! archlinux.vim
" enable syntax highlighting
syntax on
" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark

if &compatible
  set nocompatible               " Be iMproved
endif

set path+=./**

call plug#begin('~/.neovimbundle/')

" Add or remove your plugins here:
" Plug('Shougo/neosnippet.vim')
" Plug('Shougo/neosnippet-snippets')
" Plug("Shougo/deoplete.nvim")
" Plug('racer-rust/vim-racer')
" Plug('neomake/neomake')
" Plug('rust-lang/rust.vim')
" Plug('davidhalter/jedi-vim')
" Plug('junegunn/fzf')
" Plug('junegunn/fzf.vim')
" Plug("zchee/deoplete-go", {'build': 'make'})
" Plug("zchee/deoplete-jedi")
" Plug("chriskempson/base16-vim.git")
" Plug('nightsense/vim-crunchbang')
" Plug('Zabanaa/neuromancer.vim')
" You can specify revision/branch/tag.
" Plug('Shougo/vimshell', { 'rev': '3787e5' })
" Plug('arcticicestudio/nord-vim')
" Plug 'dim13/smyck.vim'
" Plug 'Yggdroot/indentLine'
" Plug 'w0rp/ale'
Plug 'bling/vim-airline'
Plug 'junegunn/goyo.vim'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'justinmk/vim-sneak'
Plug 'mhinz/vim-startify'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-tbone'
Plug 'tpope/vim-abolish'
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'
Plug 'chase/vim-ansible-yaml'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'mbbill/undotree'
Plug 'godlygeek/tabular'
Plug 'jiangmiao/auto-pairs'
Plug 'blindFS/vim-taskwarrior'
Plug 'ayu-theme/ayu-vim'
Plug 'valloric/YouCompleteMe'
Plug 'metalelf0/base16-black-metal-scheme'

call plug#end()

" Required:
filetype plugin indent on

" IndentLine {{
let g:indentLine_char = ''
let g:indentLine_first_char = ''
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_setColors = 0
" }}

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd             " Show (partial) command in status line.
set showmatch           " Show matching brackets.
set incsearch           " Incremental search
set autowrite           " Automatically save before commands like :next and :make
set hidden              " Hide buffers when they are abandoned
set mouse=a             " Enable mouse usage (all modes) in terminals
set number              " show line numbers
set showmode            " Show current mode.
set ruler               " Show the line and column numbers of the cursor.
set number              " Show the line numbers on the left side.
set formatoptions+=o    " Continue comment marker in new lines.
set textwidth=0         " Hard-wrap long lines as you type them.
set expandtab           " Insert spaces when TAB is pressed.
set tabstop=2           " Render TABs using this many spaces.
set shiftwidth=2        " Indentation amount for < and > commands.
set noerrorbells        " No beeps.
set modeline            " Enable modeline.
"set esckeys             " Cursor keys in insert mode.
set linespace=0         " Set line-spacing to minimum.
set nojoinspaces        " Prevents inserting two spaces after punctuation on a join (J)

" More natural splits
set splitbelow          " Horizontal split below current.
set splitright          " Vertical split to right of current.

if !&scrolloff
  set scrolloff=3       " Show next 3 lines while scrolling.
endif

if !&sidescrolloff
  set sidescrolloff=5   " Show next 5 columns while side-scrolling.
endif
set nostartofline       " Do not jump to first character with page commands.

set ignorecase          " Make searching case insensitive
set smartcase           " ... unless the query has capital letters.
set gdefault            " Use 'g' flag by default with :s/foo/bar/.
set magic               " Use 'magic' patterns (extended regular expressions).

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

" define MT (MakeTags) command
command! MT !ctags -R .

" Tell Vim which characters to show for expanded TABs,
" trailing whitespace, and end-of-lines. VERY useful!
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif
set list                " Show problematic characters.

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

" Useless, NeoVim does not understand setting term
"if &term == "xterm-256color"
"  set t_Co=256
"endif
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors

" load custom color scheme
syntax enable
let ayucolor="mirage"
colorscheme ayu

" improve autocomplete menu color
highlight Pmenu ctermbg=black gui=bold
highlight Conceal cterm=bold ctermfg=8 gui=bold guifg=#8F8F8F guibg=#282828

" YouCompleteMe
 let g:ycm_python_binary_path = '/usr/bin/python'
 let g:ycm_server_python_interpreter = '/usr/bin/python'
 let g:ycm_global_ycm_extra_conf = '/home/marco/.config/nvim/.ycm_extra_conf.py'

" AIRLINE CONFIG
let g:airline#extensions#tabline#enabled = 1
let g:airline#extension#hunks#enabled = 1
let g:airline#extension#branch#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
" let g:airline#extensions#tabline#left_sep = ' '
" let g:airline#extensions#tabline#left_alt_sep = '|'
" let g:airline#extensions#tabline#right_sep = ' '
" let g:airline#extensions#tabline#right_alt_sep = '|'
" let g:airline_left_sep = ' '
" let g:airline_left_alt_sep = '|'
" let g:airline_right_sep = ' '
" let g:airline_right_alt_sep = '|'
let g:airline_theme='base16_eighties'
let g:airline_powerline_fonts = 1

let g:racer_cmd = "/usr/bin/racer"
let $RUST_SRC_PATH="/usr/src/rust/src/"

" let g:deoplete#enable_at_startup = 1
" let g:deoplete#sources#go#gocode_binary = '/home/marco/Work/go/bin/gocode'
" let g:deoplete#sources#go#pointer = 1
" let g:deoplete#sources#go#use_cache = 1

" go language
let s:tlist_def_go_settings = 'go;g:enum;s:struct;u:union;t:type;' .
                           \ 'v:variable;f:function'

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Auto Commands Configuration
autocmd! BufWritePost *.py retab! 4
"autocmd! BufWritePost *.py Neomake
autocmd VimEnter * GitGutterLineHighlightsDisable
" autocmd VimEnter * TagbarToggle
autocmd InsertEnter * set number
autocmd InsertLeave * set relativenumber
autocmd FileType python set tabstop=4|set shiftwidth=4|set expandtab
autocmd BufEnter *.py set ai sw=4 ts=4 sta et fo=croql
autocmd BufNewFile *.py 0r ~/Work/dotfiles/templates/python.spec
autocmd BufNewFile *.c 0r ~/Work/dotfiles/templates/c.spec
autocmd BufNewFile *.ksprofile 0r ~/Work/dotfiles/templates/ksprofile.spec

" font setting
if has('gui_running')
  " set guifont=PragmataTT:h9
  set guifont=Iosevka Term:h10
endif

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

if (has("termguicolors"))
 set termguicolors
endif

" Remapping of some custom commands
map <C-t> :TagbarToggle<CR>
map <C-R> :call NumberToggle()<CR>

map <C-^> :lopen<CR>
map <C-?> :copen<CR>

"map <C-m> :Neomake<CR>

map <C-G> :GitGutterToggle<CR>
set updatetime=500

map <C-u> :PlugUpdate()<CR>

map <F5> :UndotreeToggle<CR>
let g:undotree_WindowLayout=2
let g:undotree_SetFocusWhenToggle=1
if has("persistent_undo")
    set undodir=~/.undodir/
    set undofile
endif

" convenience maps
" Wipe all empty lines
noremap <Leader>1 :g/^\s*$/d_<CR>
noremap <Leader>w :w<CR>
noremap <Leader>q :wq<CR>
noremap <Leader>Q :q!<CR>
noremap <Leader>t :TW<CR>
noremap <Leader>a :bp<CR>
noremap <Leader>s :bn<CR>
noremap <Leader>c :bd<CR>
noremap <F3> :NERDTreeToggle<CR>
noremap <Leader>p :CtrlPMixed<CR>
nnoremap <F4> :MT<CR>

" Function calls at the end of vim load phase
call NumberToggle()

