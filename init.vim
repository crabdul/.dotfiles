" Theme
" ---
	
colorscheme Tomorrow-Night 


" General
" ---

syntax on
set history=500				" sets how many lines of history VIM has to remember
let mapleader = ","              " display using :echo mapleader


" Leader shortcuts
" ---

imap <leader>jk <esc>                   " escape
imap <leader>kj <esc>                   " escape
nmap <leader>ev :sp $MYVIMRC<cr>        " edit vimrc
nmap <leader>sv :source $MYVIMRC<cr>    " source vimrc

" Tabs and spaces
" ---

set tabstop=4
set shiftwidth=4
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
"nnoremap <space> za     " space open/closes folds
set foldmethod=indent   " fold based on indent level


" Movement 
" ---
" source: https://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/

nnoremap <expr> j v:count ? 'j' : 'gj'      " move down by visual line
nnoremap <expr> k v:count ? 'k' : 'gk'      " move up by visual line
"nnoremap B ^           " move to beginning of line
"nnoremap E $           " move to end of line
nnoremap gV `[v`]       " highlight last inserted text


" Pasting
" ---

nnoremap p "0p
nnoremap P "0P


" Command
" ---

command! Q q            " Quit


" Plugins
" ---

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

Plug 'airblade/vim-gitgutter'           " Git status in gutter
Plug 'scrooloose/nerdtree'              " Tree explorer
Plug 'tpope/vim-commentary'             " Comment out stuff
Plug 'tpope/vim-fugitive'               " Git wrapper
Plug 'tpope/vim-surround'               " Quoting / paranthesizing
Plug 'tpope/vim-repeat'                 " repeat last command
Plug 'vim-airline/vim-airline'          " Status bar 

" Better JS function parameter completion
" Plug 'othree/jspc.vim', { 'for': ['javascript', 'javascript.jsx'] }

" Super-Tab
Plug 'ervandew/supertab'

" Fuzzy-search
Plug 'ctrlpvim/ctrlp.vim'

" Silver searcher
Plug 'mileszs/ack.vim'


" Initialize plugin system
call plug#end()


" airblade/vim-gitgutter
" ---

nmap <Leader>ha <Plug>GitGutterStageHunk                " Stage hunk when cursor inside
nmap <Leader>hr <Plug>GitGutterUndoHunk                 " Undo staged hunk when cursor inside


" Tab complete
autocmd FileType javascript nnoremap <silent> <buffer> gb :TernDef<CR>


" ctrlp
" ---

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'


" Silver-searcher
" ---

" Make CtrlP use ag for listing the files. Way faster and no useless files.
let g:ctrlp_user_command = 'ag %s -l --hidden --nocolor -g ""'
let g:ctrlp_use_caching = 0


" Saved for later
" ---

" Loop over files
" for f in split(glob('~/.config/nvim/config/*.vim'), '\n')
"     exe 'source' f
" endfor
