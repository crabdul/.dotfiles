" Theme
" ---

syntax on
colorscheme Tomorrow-Night 


" Leader shortcuts
" ---

let mapleader = "\<Space>"              " display using :echo mapleader
imap <leader>jk <esc>                   " escape
imap <leader>kj <esc>                   " escape
nmap <leader>vr :sp $MYVIMRC<cr>        " edit vimrc
nmap <leader>so :source $MYVIMRC<cr>    " source vimrc

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
"nnoremap <space> za     " space open/closes folds
set foldmethod=indent   " fold based on indent level


" Movement 
" ---
" source: https://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/

nnoremap <expr> j v:count ? 'j' : 'gj'      " move down by visual line
nnoremap <expr> k v:count ? 'k' : 'gk'      " move up by visual line
"nnoremap B ^            " move to beginning of line
"nnoremap E $            " move to end of line
nnoremap gV `[v`]        " highlight last inserted text


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

" Python autocompletion
Plug 'zchee/deoplete-jedi', { 'do': ':UpdateRemotePlugins' }

" JS autocompletion
Plug 'ternjs/tern_for_vim', { 'do': 'npm install',
    \ 'for': ['javascript', 'javascript.jsx']
\}

" JS autocompletion
Plug 'carlitux/deoplete-ternjs', { 
    \ 'for': ['javascript', 'javascript.jsx']
\}

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


" Deoplete
" ---
" https://www.gregjs.com/vim/2016/neovim-deoplete-jspc-ultisnips-and-tern-a-config-for-kickass-autocompletion/

" Use deoplete
let g:deoplete#enable_at_startup = 1

if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif

" Turn automatic autocomplete off
" let g:deoplete#disable_auto_complete = 1

" Automatically closw the scratch window at the top of the vim window 
" on finishing a complete or leaving insert
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" Path to the Python 3 interpreter
let g:python3_host_prog = $HOME.'/.pyenv/versions/neovim3/bin/python'

" Disable Python 2 support
let g:python_host_prog = $HOME.'/.pyenv/versions/neovim2/bin/python'

" Disable Ruby support
let g:loaded_ruby_provider = 1

" Tab-complete
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" Set language sources
" call deoplete#custom#option('sources', {
"     \ 'python': ['LanguageClient'],
"     \ 'javascript': ['LanguageClient'],
" \})

" Disable the candidates in Comment/String syntaxes.
call deoplete#custom#source('_',
    \ 'disabled_syntaxes', ['Comment', 'String'])


" omnifuncs
" ---
" https://gregjs.com/vim/2016/configuring-the-deoplete-asynchronous-keyword-completion-plugin-with-tern-for-vim/
augroup omnifuncs
    autocmd!
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup end


" tern
" ---
if exists('g:plugs["tern_for_vim"]')
    let g:tern_show_argument_hints = 'on_hold'
    let g:tern_show_signature_in_pum = 1
    autocmd FileType javascript setlocal omnifunc=tern#Complete
endif

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
