" Theme
" ---

syntax on
colorscheme Tomorrow-Night 


" Leader shortcuts
" ---

let mapleader = ","     " display using :echo mapleader
inoremap jk <esc>       " js is escape


" Tabs and spaces
" ---

set tabstop=4
set softtabstop=4       " number of spaces in tab when editing
set expandtab 		    " tabs are spaces


" UI Config
" ---

set number		        " show line numbers
set showcmd             " show command in bottom bar
set cursorline          " highlight current line
filetype indent on      " load filetype-specific indent files
set wildmenu            " visual autocomplete for command menu
set lazyredraw          " redraw only when we need to
set showmatch           " highlight matching [{()}]


" Searching 
" ---

set incsearch           " search as characters are entered
set hlsearch            " highlight matches
nnoremap <leader><space> :nohlsearch<CR>    " turn off search highlight 


" Folding 
" ---

set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max
nnoremap <space> za     " space open/closes folds
set foldmethod=indent   " fold based on indent level


" Movement 
" ---
" source: https://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/

nnoremap <expr> j v:count ? 'j' : 'gj'      " move down by visual line
nnoremap <expr> k v:count ? 'k' : 'gk'      " move up by visual line
"nnoremap B ^            " move to beginning of line
"nnoremap E $            " move to end of line
nnoremap gV `[v`]        " highlight last inserted text


" Deoplete
" ---

" Use deoplete
let g:deoplete#enable_at_startup = 1

" Path to the Python 3 interpreter
let g:python3_host_prog = $HOME.'/.pyenv/versions/neovim3/bin/python'

" Disable Python 2 support
let g:python_host_prog = $HOME.'/.pyenv/versions/neovim2/bin/python'

" Disable Ruby support
let g:loaded_ruby_provider = 1


" Plugins
" ---

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

Plug 'airblade/vim-gitgutter'           " Git status in gutter
Plug 'scrooloose/nerdtree'              " Tree explorer
Plug 'tpope/vim-fugitive'               " Git wrapper
Plug 'tpope/vim-surround'               " Quoting / paranthesizing
Plug 'vim-airline/vim-airline'          " Status bar 
" Deoplete
" Requirements: 
" - https://github.com/zchee/deoplete-jedi/wiki/Setting-up-Python-for-Neovim 
" - https://github.com/pyenv/pyenv/wiki
if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif

" Initialize plugin system
call plug#end()
