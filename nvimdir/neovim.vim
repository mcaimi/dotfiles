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

" Required:
set runtimepath+=~/.neovimbundle/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin('~/.neovimbundle/')

" Let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')

" Add or remove your plugins here:
" call dein#add('Shougo/neosnippet.vim')
" call dein#add('Shougo/neosnippet-snippets')
" call dein#add("Shougo/deoplete.nvim")
" call dein#add('racer-rust/vim-racer')
call dein#add('bling/vim-airline')
call dein#add('vim-airline/vim-airline-themes')
call dein#add('scrooloose/nerdtree')
call dein#add('neomake/neomake')
call dein#add('majutsushi/tagbar')
"call dein#add('rust-lang/rust.vim')
call dein#add('justinmk/vim-sneak')
call dein#add('mhinz/vim-startify')
"call dein#add('davidhalter/jedi-vim')
call dein#add('ctrlpvim/ctrlp.vim')
call dein#add('tpope/vim-fugitive')
call dein#add('tpope/vim-tbone')
call dein#add('tpope/vim-abolish')
call dein#add('ryanoasis/vim-devicons')
call dein#add("airblade/vim-gitgutter")
"call dein#add("zchee/deoplete-go", {'build': 'make'})
"call dein#add("zchee/deoplete-jedi")
call dein#add("chase/vim-ansible-yaml")
call dein#add("Xuyuanp/nerdtree-git-plugin")
call dein#add("mbbill/undotree")
call dein#add("godlygeek/tabular")
" call dein#add("chriskempson/base16-vim.git")
call dein#add("jiangmiao/auto-pairs.git")
call dein#add('blindFS/vim-taskwarrior')
call dein#add('ryanss/vim-hackernews')
 call dein#add('ayu-theme/ayu-vim')
 call dein#add('dim13/smyck.vim')
" call dein#add('nightsense/vim-crunchbang')
" call dein#add('Zabanaa/neuromancer.vim')
call dein#add('Yggdroot/indentLine')

" call dein#add('arcticicestudio/nord-vim')
call dein#add('valloric/YouCompleteMe')

" You can specify revision/branch/tag.
"call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

" Required:
call dein#end()

" Required:
filetype plugin indent on

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

" IndentLine {{
let g:indentLine_char = ''
let g:indentLine_first_char = ''
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_setColors = 0
" }}

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd     " Show (partial) command in status line.
set showmatch   " Show matching brackets.
set smartcase   " Do smart case matching
set incsearch   " Incremental search
set autowrite   " Automatically save before commands like :next and :make
set hidden              " Hide buffers when they are abandoned
set mouse=a   " Enable mouse usage (all modes) in terminals
set number    " show line numbers
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

" load custom color scheme
syntax enable
set termguicolors
let ayucolor="mirage"
colorscheme smyck

"improve autocomplete menu color
highlight Pmenu ctermbg=black gui=bold
highlight Conceal cterm=bold ctermfg=8 gui=bold guifg=#8F8F8F guibg=#282828

" YouCompleteMe
 let g:ycm_python_binary_path = '/usr/bin/python'
 let g:ycm_server_python_interpreter = '/usr/bin/python'

" AIRLINE CONFIG
let g:airline#extensions#tabline#enabled = 1
let g:airline#extension#hunks#enabled = 1
let g:airline#extension#branch#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
"let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#left_alt_sep = '|'
"let g:airline#extensions#tabline#right_sep = ' '
"let g:airline#extensions#tabline#right_alt_sep = '|'
"let g:airline_left_sep = ' '
"let g:airline_left_alt_sep = '|'
"let g:airline_right_sep = ' '
"let g:airline_right_alt_sep = '|'
let g:airline_theme='deus'
let g:airline_powerline_fonts = 1

let g:racer_cmd = "/usr/bin/racer"
let $RUST_SRC_PATH="/usr/src/rust/src/"

let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#go#gocode_binary = '/home/marco/Work/go/bin/gocode'
let g:deoplete#sources#go#pointer = 1
let g:deoplete#sources#go#use_cache = 1

" go language
let s:tlist_def_go_settings = 'go;g:enum;s:struct;u:union;t:type;' .
                           \ 'v:variable;f:function'

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Auto Commands Configuration
autocmd! BufWritePost *.py retab! 4
autocmd! BufWritePost *.py Neomake
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
  set guifont=mPlus:h10
endif

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

if (has("termguicolors"))
 set termguicolors
endif

if &term == "xterm-256color"
  set t_Co=256
endif

" Remapping of some custom commands
map <C-t> :TagbarToggle<CR>
map <C-R> :call NumberToggle()<CR>

map <C-^> :lopen<CR>
map <C-?> :copen<CR>

map <C-m> :Neomake<CR>

map <C-G> :GitGutterToggle<CR>
set updatetime=500

map <C-u> :call dein#check_update()<CR>

map <F5> :UndotreeToggle<CR>
let g:undotree_WindowLayout=2
let g:undotree_SetFocusWhenToggle=1
if has("persistent_undo")
    set undodir=~/.undodir/
    set undofile
endif

" convenience maps
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

