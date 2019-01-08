" General {{{

syntax on
set history=500				" sets how many lines of history VIM has to remember
let mapleader = ","              " display using :echo mapleader

nnoremap ; :

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
noremap <leader>v :r !pbpaste<CR><CR>

" esc for terminal 
tnoremap <Esc> <C-\><C-n>

" save session
nnoremap <leader>s :mksession<cr>

" declare lines from end of file just for vim
set modelines=1

" }}}
" UI {{{

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

" show current line number
set number

" show lines number relative to current
set relativenumber

" show command in bottom bar
set showcmd 

" highlight current line
set cursorline

" }}}
" Tabs and spaces {{{

set tabstop=4
set shiftwidth=4

" number of spaces in tab when editing
set softtabstop=4

" tabs are spaces
set expandtab

" highlight extra white spaces
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.

" }}}
" Searching {{{

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

" }}}
" Folding {{{

set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max
set foldmethod=indent   " fold based on indent level

" toggle fold
nnoremap <leader>d za    

" }}}
" Movement {{{
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

" Close the current buffer without closing the window
map <leader>bd :BD<cr>

" Close all the buffers
map <leader>ba :bufdo bd<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>td :tabclose<cr>
map <leader>tm :tabmove<space>

" hold shift to scroll left and right continuously
nnoremap H gT
nnoremap L gt

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

" }}}
" Pasting {{{

" paste from unnamed register
nnoremap <leader>p "0p
nnoremap <leader>P "0P

" disable smart autoindent stuff when pasting large bits of text
set pastetoggle=<F2>

" }}}
" Editing {{{

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

" }}}
" Spell checking {{{

" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Move to spelling-mistake
" Next
map <leader>sn ]s
" Previous 
map <leader>sp [s

" Add definition
map <leader>sa zg

" }}}
" INSERT MODE {{{

" escape
imap <leader>jk <esc>
imap <leader>kj <esc>

" bracket completion
inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap {{     {
inoremap {}     {}

" skip over the closing character
inoremap        (  ()<Left>
inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"

" skip over the closing single quote
inoremap <expr> ' strpart(getline('.'), col('.')-1, 1) == "\'" ? "\<Right>" : "\'\'\<Left>"

" skip over the closing double quote
inoremap <expr> " strpart(getline('.'), col('.')-1, 1) == "\"" ? "\<Right>" : "\"\"\<Left>"


" }}}
" Custom functions {{{

" toggle between number and relativenumber
function! ToggleNumber()
    if(&relativenumber == 0)
        set relativenumber
    else
        set norelativenumber
        set number
    endif
endfunc

" }}}
" Tab completion {{{

" open tab completion
imap <Tab> <C-P>

" pull keywords from the current file, other buffers, and from
" the current tags file
set complete=.,b,u,]

" how vim should replace text
set wildmode=longest,list:longest

" }}}
" Helper functions {{{

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

" }}}
" Python filetypes {{{

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

" }}}
" JavaScript filetypes {{{

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

" }}}
" Plugins {{{

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Palenight theme
Plug 'drewtempelmeyer/palenight.vim'

Plug 'airblade/vim-gitgutter'           " Git status in gutter
Plug 'ervandew/supertab'                " super tab
Plug 'itchyny/lightline.vim'            " status bar
Plug 'junegunn/goyo.vim'                " distraction-free writing
Plug 'mattn/emmet-vim'                  " emmet
Plug 'mileszs/ack.vim'                  " ack
Plug 'scrooloose/nerdtree'              " Tree explorer
Plug 'qpkorr/vim-bufkill'               " close buffer and keep window open 
Plug 'tpope/vim-commentary'             " Comment out stuff
Plug 'tpope/vim-fugitive'               " Git wrapper
Plug 'tpope/vim-surround'               " Quoting / paranthesizing
Plug 'tpope/vim-repeat'                 " repeat last command
Plug 'vim-scripts/indentLine.vim'       " indent guides
Plug 'tpope/vim-unimpaired'             " bracket mappings
Plug 'w0rp/ale' 						" asynchronous linting

" fzf
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" Initialize plugin system
call plug#end()

" }}}
" Theme {{{

set background=dark
colorscheme palenight

" enable true colours
if (has("termguicolors"))
  set termguicolors
endif

" Italics for my favorite color scheme
let g:palenight_terminal_italics=1

" }}}
" Plugin > ale {{{

" check files with linters
let b:ale_linters = {
    \ 'python': ['flake8', 'pylint']
    \ }

" Fix files with ESLint then Prettier
let b:ale_fixers = {
    \ 'javascript': ['eslint', 'prettier_eslint']
    \ }

" Set this variable to 1 to fix files when you save them
let g:ale_fix_on_save = 1

" don't lint while writing
let g:ale_lint_on_text_changed = 0

" Do not lint or fix minified files.
let g:ale_pattern_options = {
    \ '\.min\.js$': {'ale_linters': [], 'ale_fixers': []},
    \ '\.min\.css$': {'ale_linters': [], 'ale_fixers': []},
    \ }

" signs
let g:ale_sign_error = '♦️'
let g:ale_sign_warning = '🔸'

autocmd User ALELint unsilent echom 'ALE run!'

" }}}
" Plugin > airblade/vim-gitgutter {{{

" Stage hunk when cursor inside
nmap <Leader>ha <Plug>GitGutterStageHunk                

" Undo staged hunk when cursor inside
nmap <Leader>hr <Plug>GitGutterUndoHunk                

" }}}
" Plugin > Omni complete functions {{{

autocmd FileType css set omnifunc=csscomplete#CompleteCSS

" }}}
" Plugin > lightline {{{

let g:lightline = {
    \ 'colorscheme': 'seoul256',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'filename', 'gitbranch', 'modified' ] ],
    \   'right': [['lineinfo'], ['percent'], ['readonly', 'linter_warnings', 'linter_errors', 'linter_ok']]
    \ },
    \ 'component_function': {
    \   'gitbranch': 'fugitive#Head',
    \ },
    \ 'component_expand': {
    \   'linter_warnings': 'LightlineLinterWarnings',
    \   'linter_errors': 'LightlineLinterErrors',
    \   'linter_ok': 'LightlineLinterOK'
    \ },
    \ 'component_type': {
    \   'readonly': 'error',
    \   'linter_warnings': 'warning',
    \   'linter_errors': 'error'
    \ }
    \ }

" TODO: get warning and error message working
function! LightlineLinterWarnings() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    return l:counts.total == 0 ? '' : printf('%d ◆', all_non_errors)
endfunction

function! LightlineLinterErrors() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    return l:counts.total == 0 ? '' : printf('%d ✗', all_errors)
endfunction

function! LightlineLinterOK() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    return l:counts.total == 0 ? '✓ ' : ''
endfunction

autocmd User ALELint call s:MaybeUpdateLightline()

" Update and show lightline but only if it's visible (e.g., not in Goyo)
function! s:MaybeUpdateLightline()
    if exists('#lightline')
        call lightline#update()
    end
endfunction

" }}}
" Plugin > fzf {{{

" Open Ag and put the cursor in the right position
map <leader>a :Ag 

" file finder in extended search mode
nmap <leader>f :GFiles<cr>
nmap <leader>F :Files<cr>

" buffer finder
nmap <leader>b :Buffers<CR>
nmap <Leader>h :History<CR>

" line finder
nmap <Leader>l :BLines<CR>
nmap <Leader>L :Lines<CR>
nmap <Leader>' :Marks<CR>

" tag finder
nmap <leader>r :Tags<cr>

" tags directory
set tags=./tags;

" help
nmap <leader>h :Helptags!<cr>

" command
nmap <leader>C :Commands<cr>

" fuzzy search through /search history
nmap <Leader>/ :History/<CR>

" search through mappings
nmap <Leader>M :Maps<CR>

" search filetype syntaxes
"nmap <Leader>ft :Filetypes<CR>

" open files in new tabs or split window
let g:fzf_action = {
	\ 'return': 'tab split', 
	\ 'ctrl-j': 'split',
	\ 'ctrl-k': 'vsplit' }

" }}}
" Plugin > Ack {{{

" Use the the_silver_searcher if possible (much faster than Ack)
if executable('ag')
  let g:ackprg = 'ag --vimgrep --smart-case'
endif

" find selected text
vnoremap <silent> gv :call VisualSelection('gv', '')<CR>

" Open Ack and put the cursor in the right position
map <leader>g :Ack!<space>

" find currently selected word
nmap <leader>cw :Ack! "\b<cword>\b" <CR>

" find and replace text
vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>

" display results in cope
map <leader>cc :botright cope<cr>

" open search result in new tab
map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg

" close QuickFix window
map <leader>x :cclose<cr>

" }}}
" Plugin > Nerd Tree {{{

let NERDTreeShowHidden=0
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
let g:NERDTreeWinSize=35

map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark<Space>
map <leader>nf :NERDTreeFind<cr>

" }}}
" Plugin > Emmet {{{

" Use tab for autocompletion
let g:user_emmet_expandabbr_key='<Tab>'
map <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")

" }}}
" Saved for later {{{

" Loop over files
" for f in split(glob('~/.config/nvim/config/*.vim'), '\n')
"     exe 'source' f
" endfor

" }}}
" vim: foldmethod=marker:foldlevel=0
