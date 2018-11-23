" Symlink with command below
" ln -s ~/.dotfiles/init.vim ~/.config/nvim/init.vim

" Theme
" ---
        
syntax on
colorscheme Tomorrow-Night 


" Leader
" ---

let mapleader = "\<Space>"              " display using :echo mapleader


" Escape
" ---

imap <leader>jk <esc>                   " escape
imap <leader>kj <esc>                   " escape


" Vimrc
" ---

nnoremap ; :
nmap <silent> <leader>ev :sp $MYVIMRC<cr>        " edit vimrc
nmap <silent> <leader>sv :source $MYVIMRC<cr>    " source vimrc
set nobackup
set noswapfile

" Tabs and spaces
" ---

set tabstop=4       " width of TAB
set shiftwidth=4    " indents will have a width of 4
set softtabstop=4   " sets the number of columns for a TAB
set expandtab       " expand TABs to spaces


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
nnoremap <leader>sh :nohlsearch<CR>    " turn off search highlight 


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

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Command
" ---

command! Q q            " Quit

" Sudo
" ---

cmap w!! w !sudo tee % >/dev/null           " Grant root privileges on opened file with w!!


" Plugins
" ---

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

Plug 'airblade/vim-gitgutter'           " Git status in gutter
Plug 'tpope/vim-commentary'             " Comment out stuff
Plug 'tpope/vim-fugitive'               " Git wrapper
Plug 'tpope/vim-surround'               " Quoting / paranthesizing
Plug 'tpope/vim-repeat'                 " repeat last command
Plug 'scrooloose/nerdtree'                " file explorer
Plug 'vim-airline/vim-airline'          " Status bar 

"" JS autocompletion
"Plug 'ternjs/tern_for_vim', { 'do': 'npm install',
"    \ 'for': ['javascript', 'javascript.jsx']
"\}

" A collection of language packs
Plug 'sheerun/vim-polyglot'

" Autocomplete
Plug 'ajh17/VimCompletesMe'

" Better JS function parameter completion
Plug 'othree/jspc.vim', { 'for': ['javascript', 'javascript.jsx'] }

" Super-Tab
Plug 'ervandew/supertab'

" Fuzzy-search
Plug 'ctrlpvim/ctrlp.vim'

" Silver searcher
Plug 'mileszs/ack.vim'

" Initialize plugin system
call plug#end()


" omnifuncs
" ---
" https://gregjs.com/vim/2016/configuring-the-deoplete-asynchronous-keyword-completion-plugin-with-tern-for-vim/
"augroup omnifuncs
"    autocmd!
"    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
"    autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags
"    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
"    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
"augroup end
"
"
"" tern
"" ---
"
if exists('g:plugs["tern_for_vim"]')
    " show argument hints
    let g:tern_show_argument_hints='on_hold'
    " enable keyboard shortcuts
    let g:tern_map_kets=1
"    let g:tern_show_signature_in_pum = 1
    autocmd FileType javascript setlocal omnifunc=tern#Complete
"    let g:tern#command = ["tern"]
"
"    " Tab complete
"    autocmd FileType javascript nnoremap <silent> <buffer> gb :TernDef<CR>
"
"    let g:tern#arguments = ["--persistent"]
endif


" ctrlp
" ---

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'


" Silver-searcher
" ---

" Make CtrlP use ag for listing the files. Way faster and no useless files.
let g:ctrlp_user_command = 'ag %s -l --hidden --nocolor -g ""'
let g:ctrlp_use_caching = 0

" NERDTree
" ---

nmap <leader>no :NERDTree<cr>           " open NERDTree
nmap <leader>nc :NERDTreeClose<cr>      " close NERDTree


" Saved for later
" ---

" Loop over files
" for f in split(glob('~/.config/nvim/config/*.vim'), '\n')
"     exe 'source' f
" endfor
