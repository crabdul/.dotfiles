" ----------------------------------------------------------------
" General
" ----------------------------------------------------------------

syntax on
set history=500				" sets how many lines of history VIM has to remember
let mapleader = ","              " display using :echo mapleader

" Can quit with capital Q
command! Q q

" edit vimrc
nmap <leader>ev :sp $MYVIMRC<cr>

" source vimrc
nmap <leader>sv :source $MYVIMRC<cr>

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" Disable automatic comment insertion
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Fast saving
nmap <leader>w :w!<cr>

" No swap file
set noswapfile

" copy to clipboard
vnoremap <C-c> :w !pbcopy<CR><CR>
noremap <C-v> :r !pbpaste<CR><CR>

" esc for terminal 
tnoremap <Esc> <C-\><C-n>


" ----------------------------------------------------------------
" UI
" ----------------------------------------------------------------

" Don't redraw while executing macros
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sounds on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Add a bit extra margin to the left
set foldcolumn=1

" show line numbers
set number		        

" show command in bottom bar
set showcmd 

" highlight current line
set cursorline         


" ----------------------------------------------------------------
" Tabs and spaces
" ----------------------------------------------------------------

set tabstop=4
set shiftwidth=4

" number of spaces in tab when editing
set softtabstop=4

" tabs are spaces
set expandtab

" highlight extra white spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/


" ----------------------------------------------------------------
" Searching
" ----------------------------------------------------------------

" higlight matches
set hlsearch 

" turn off search highlight
nnoremap <leader>sh :nohlsearch<CR>

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" search as characters are entered
set incsearch


" ----------------------------------------------------------------
" Folding
" ----------------------------------------------------------------

set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max
set foldmethod=indent   " fold based on indent level

" toggle fold
nnoremap <leader>f za    


" ----------------------------------------------------------------
" Movement
" ----------------------------------------------------------------
" source: https://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/

" move down by visual line
nnoremap <expr> j v:count ? 'j' : 'gj'

" move up by visual line
nnoremap <expr> k v:count ? 'k' : 'gk' 

" move to beginning of line
nnoremap B ^

" move to end of line
nnoremap E $

" highlight last inserted text
nnoremap gV `[v`]

" Map <Space> to / (search)
map <space> /

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" TODO: :Bclose editor command not found 
" Close the current buffer without closing the window
map <leader>bd :Bclose<cr>:tabclose<cr>gT

" Close all the buffers
map <leader>ba :bufdo bd<cr>

" Move to next / prev buffer
map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove<space>
map <leader>t<leader> :tabnext<cr>

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers 
try
      set switchbuf=useopen,usetab,newtab
      set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


" ----------------------------------------------------------------
" Pasting
" ----------------------------------------------------------------

" paste from unnamed register
nnoremap <leader>p "0p
nnoremap <leader>P "0P


" ----------------------------------------------------------------
" Editing
" ----------------------------------------------------------------

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh :call CleanExtraSpaces()
endif


" ----------------------------------------------------------------
" Spell checking 
" ----------------------------------------------------------------

" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Move to spelling-mistake
" Next
map <leader>sn ]s
" Previous 
map <leader>sp [s

" Add definition
map <leader>sa zg


" ----------------------------------------------------------------
" INSERT MODE
" ----------------------------------------------------------------

" escape
imap <leader>jk <esc>
imap <leader>kj <esc>


" ----------------------------------------------------------------
" Tab completion
" ----------------------------------------------------------------

" open tab completion
imap <Tab> <C-P>

" pull keywords from the current file, other buffers, and from
" the current tags file
set complete=.,b,u,]

" how vim should replace text
set wildmode=longest,list:longest


" ----------------------------------------------------------------
" Helper functions
" ----------------------------------------------------------------

function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction 

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction<Paste>


" ----------------------------------------------------------------
" Python filetypes
" ----------------------------------------------------------------

let python_highlight_all = 1
au FileType python syn keyword pythonDecorator True None False self

au BufNewFile,BufRead *.jinja set syntax=htmljinja

" configure expanding of tabs for various file types
au BufRead,BufNewFile *.py set expandtab

au FileType python map <buffer> F :set foldmethod=indent<cr>

au FileType python inoremap <buffer> $r return 
au FileType python inoremap <buffer> $i import 
au FileType python inoremap <buffer> $p print 
au FileType python inoremap <buffer> $f # --- <esc>a
au FileType python map <buffer> <leader>1 /class 
au FileType python map <buffer> <leader>2 /def 
au FileType python map <buffer> <leader>C ?class 
au FileType python map <buffer> <leader>D ?def 
au FileType python set cindent
au FileType python set cinkeys-=0#
au FileType python set indentkeys-=0#


" ----------------------------------------------------------------
" JavaScript filetypes
" ----------------------------------------------------------------

au FileType javascript call JavaScriptFold()
au FileType javascript setl fen
au FileType javascript setl nocindent

au FileType javascript imap <c-t> $log();<esc>hi
au FileType javascript imap <c-a> alert();<esc>hi

au FileType javascript inoremap <buffer> $r return 
au FileType javascript inoremap <buffer> $f // --- PH<esc>FP2xi

function! JavaScriptFold() 
    setl foldmethod=syntax
    setl foldlevelstart=1
    syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

    function! FoldText()
        return substitute(getline(v:foldstart), '{.*', '{...}', '')
    endfunction
    setl foldtext=FoldText()
endfunction


" ----------------------------------------------------------------
" Plugins
" ----------------------------------------------------------------

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Palenight theme
Plug 'drewtempelmeyer/palenight.vim'

Plug 'airblade/vim-gitgutter'           " Git status in gutter
Plug 'scrooloose/nerdtree'              " Tree explorer
Plug 'tpope/vim-commentary'             " Comment out stuff
Plug 'tpope/vim-fugitive'               " Git wrapper
Plug 'tpope/vim-surround'               " Quoting / paranthesizing
Plug 'tpope/vim-repeat'                 " repeat last command
Plug 'vim-airline/vim-airline'          " Status bar 

" Super-Tab
Plug 'ervandew/supertab'

" Fuzzy-search
Plug 'ctrlpvim/ctrlp.vim'

" Silver searcher
Plug 'mileszs/ack.vim'

" Emmet
Plug 'mattn/emmet-vim'

" Initialize plugin system
call plug#end()


" ----------------------------------------------------------------
" Theme
" ----------------------------------------------------------------

set background=dark
colorscheme palenight

" enable true colours
if (has("termguicolors"))
  set termguicolors
endif

" Italics for my favorite color scheme
let g:palenight_terminal_italics=1


" ----------------------------------------------------------------
" Plugin > airblade/vim-gitgutter
" ----------------------------------------------------------------

" Stage hunk when cursor inside
nmap <Leader>ha <Plug>GitGutterStageHunk                

" Undo staged hunk when cursor inside
nmap <Leader>hr <Plug>GitGutterUndoHunk                


" ----------------------------------------------------------------
" Plugin > Omni complete functions
" ----------------------------------------------------------------

autocmd FileType css set omnifunc=csscomplete#CompleteCSS


" ----------------------------------------------------------------
" Plugin > Ack searching and cope displaying 
" ----------------------------------------------------------------

" Use the the_silver_searcher if possible (much faster than Ack)
if executable('ag')
  let g:ackprg = 'ag --vimgrep --smart-case'
endif

" When you press gv you Ack after the selected text
vnoremap <silent> gv :call VisualSelection('gv', '')<CR>

" Open Ack and put the cursor in the right position
map <leader>g :Ack 

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>

" Do :help cope if you are unsure what cope is. It's super useful!
"
" When you search with Ack, display your results in cope by doing:
"   <leader>cc
"
" To go to the next search result do:
"   <leader>n
"
" To go to the previous search results do:
"   <leader>p
"
map <leader>cc :botright cope<cr>
map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
map <leader>n :cn<cr>
"map <leader>p :cp<cr>


" ----------------------------------------------------------------
" Plugin > ctrlp
" ----------------------------------------------------------------

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 0

map <leader>j :CtrlP<cr>
map <c-b> :CtrlPBuffer<cr>

let g:ctrlp_max_height = 20
let g:ctrlp_custom_ignore = 'node_modules\|^\.DS_Store\|^\.git'

" Open files in a new tab on <CR>
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<2-LeftMouse>'],
    \ 'AcceptSelection("t")': ['<cr>'],
    \ }


" ----------------------------------------------------------------
" Plugin > Silver-searcher
" ----------------------------------------------------------------

" Make CtrlP use ag for listing the files. Way faster and no useless files.
let g:ctrlp_user_command = 'ag %s -l --hidden --nocolor -g ""'
let g:ctrlp_use_caching = 0


" ----------------------------------------------------------------
" Plugin > Nerd Tree
" ----------------------------------------------------------------

let NERDTreeShowHidden=0
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
let g:NERDTreeWinSize=35

map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark<Space>
map <leader>nf :NERDTreeFind<cr>


" ----------------------------------------------------------------
" Plugin > Emmet
" ----------------------------------------------------------------

" Use tab for autocompletion
let g:user_emmet_expandabbr_key='<Tab>'
map <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")


" Saved for later
" ---

" Loop over files
" for f in split(glob('~/.config/nvim/config/*.vim'), '\n')
"     exe 'source' f
" endfor
