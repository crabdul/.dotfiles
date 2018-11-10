" Theme

syntax on
colorscheme Tomorrow-Night 

" Leader shortcuts

let mapleader = ","     " display using :echo mapleader
inoremap jk <esc>       " js is escape

" Tabs and spaces

set tabstop=4
set softtabstop=4       " number of spaces in tab when editing
set expandtab 		    " tabs are spaces

" UI Config

set number		        " show line numbers
set showcmd             " show command in bottom bar
set cursorline          " highlight current line
filetype indent on      " load filetype-specific indent files
set wildmenu            " visual autocomplete for command menu
set lazyredraw          " redraw only when we need to
set showmatch           " highlight matching [{()}]

" Searching 

set incsearch           " search as characters are entered
set hlsearch            " highlight matches
nnoremap <leader><space> :nohlsearch<CR>    " turn off search highlight 

" Folding 

set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max
nnoremap <space> za     " space open/closes folds
set foldmethod=indent   " fold based on indent level

" Movement 
" source: https://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/

nnoremap <expr> j v:count ? 'j' : 'gj'      " move down by visual line
nnoremap <expr> k v:count ? 'k' : 'gk'      " move up by visual line
"nnoremap B ^            " move to beginning of line
"nnoremap E $            " move to end of line
nnoremap gV `[v`]        " highlight last inserted text
 

