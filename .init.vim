" General {{{

syntax on
set history=500				" sets how many lines of history VIM has to remember
let mapleader = ","              " display using :echo mapleader

" Can quit with capital Q
command! Q q

" edit vimrc
nmap <leader>ve :tabe $MYVIMRC<cr>

" source vimrc
nmap <leader>vs :source $MYVIMRC<cr>

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" Disable automatic comment insertion
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Fast saving
nmap <leader>w :w!<cr>

" Fast quiting
nmap <leader>q :q!<cr>

" No swap file
set noswapfile

" esc for terminal 
tnoremap <Esc> <C-\><C-n>

set mouse=a                     " enable use of mouse in all modes
set mousehide                   " hide mouse when typing

" declare lines from end of file just for vim
set modelines=1


" }}}
" UI {{{

set lazyredraw                   " Don't redraw while executing macros 
set magic                        " For regular expressions turn magic on 
set showmatch                    " Show matching brackets when text indicator is over them 
set mat=2                        " How many tenths of a second to blink when matching brackets 

set number                       " show current line number 
set relativenumber               " show lines number relative to current 
set showcmd                      " show command in bottom bar 

set equalalways                 " keep windows equally sized
set title                       " Set window title to filename

set noerrorbells                 " No annoying sounds on errors 
set novisualbell
set t_vb=
set tm=500


" }}}
" Tabs and spaces {{{

set tabstop=4
set shiftwidth=4
set softtabstop=4                " number of spaces in tab when editing 
set expandtab                    " tabs are spaces 

set list                         " highlight extra white spaces 
set listchars=tab:>.,trail:.,extends:#,nbsp:.

" }}}
" Searching and highlighting {{{

set hlsearch                     " higlight matches 
set ignorecase                   " Ignore case when searching 
set smartcase                    " When searching try to be smart about cases 
set incsearch                    " search as characters are entered 

set cursorline                   " highlight current line 

" highlight conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" turn off search highlight
nnoremap <bs> :nohlsearch<CR>

" keep working directory as the one from where vim was opened in Insert mode
autocmd InsertEnter * let save_cwd = getcwd() | set autochdir
autocmd InsertLeave * set noautochdir | execute 'cd' fnameescape(save_cwd)

" pull <cword> onto search/command line
nnoremap <leader>sc /<C-R><C-W>

" }}}
" Folding {{{

set foldenable                   " enable folding
set foldlevelstart=10            " open most folds by default
set foldnestmax=10               " 10 nested fold max
set foldmethod=indent            " fold based on indent level

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
nnoremap <space> /

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

" Specify the behavior when switching between buffers 
try
      set switchbuf=useopen,usetab,newtab
      set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" }}}
" Copy and pasting {{{

" Use system clipboard as default clipboard
set clipboard=unnamed

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
" Exploring {{{

" change to directory of current file
nnoremap <leader>sd :lchdir %:p:h<CR>:pwd<CR>

" change to global directory
nnoremap <leader>ds :execute 'cd' getcwd(-1)<CR>

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

" autocomplete quotation marks
inoremap " ""<left>

" move lines up/down
inoremap <A-k> <Esc>:m .-2<CR>==gi
inoremap <A-j> <Esc>:m .+1<CR>==gi


" }}}
" NORMAL MODE {{{

" Jump to definition of word under cursor
nnoremap gd <c-]>
nnoremap gD <c-w>v<c-w>l<c-]> 

" Make yank consistent with other commands
nnoremap Y y$

" Put result in centre of window when jumping between search results
nnoremap n nzz
nnoremap N Nzz

" move line up/down
nnoremap <A-k> :m--<CR>==
nnoremap <A-j> :m+<CR>==

" revert buffer to state when file was opened
nnoremap gu :u1\|u<CR>

" }}}
" VISUAL MODE {{{

" leave cursor at the end of the yanked block
vnoremap y y']

" move visual block
vnoremap K :move '<-2<CR>gv=gv
vnoremap J :move '>+1<CR>gv=gv

" move line up/down
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv


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

" smart mapping for tab completion
" http://vim.wikia.com/wiki/Smart_mapping_for_tab_completion
function! Smart_TabComplete()
    let line = getline('.')                         " current line

    let substr = strpart(line, -1, col('.')+1)      " from the start of the current
    " line to one character right
    " of the cursor
    let substr = matchstr(substr, "[^ \t]*$")       " word till cursor
    if (strlen(substr)==0)                          " nothing to match on empty string
        return "\<tab>"
    endif
    let has_period = match(substr, '\.') != -1      " position of period, if any
    let has_slash = match(substr, '\/') != -1       " position of slash, if any
    if (!has_period && !has_slash)
        return "\<C-X>\<C-P>"                         " existing text matching
    elseif ( has_slash )
        return "\<C-X>\<C-F>"                         " file matching
    else
        return "\<C-X>\<C-O>"                         " plugin matching
    endif
endfunction

inoremap <tab> <c-r>=Smart_TabComplete()<CR>

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
" HTML filetypes {{{

" Wrap <tag></tag> around VISUALLY selected Text
vmap sp "zdi<p><C-R>z</p><ESC>
vmap sd "zdi<div><C-R>z</div><ESC>
vmap ss "zdi<span><C-R>z</span><ESC>


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

" au FileType javascript imap <c-t> $log();<esc>hi
au FileType javascript imap <c-a> alert();<esc>hi

au FileType javascript inoremap <buffer> $r return 
au FileType javascript inoremap <buffer> $f // --- PH<esc>FP2xi

function! JavaScriptFold() 
    setl foldmethod=syntax
    setl foldlevelstart=5
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

Plug 'chrisbra/vim-diff-enhanced'
Plug 'itchyny/lightline.vim'            " status bar
Plug 'junegunn/goyo.vim'                " distraction-free writing
Plug 'mattn/emmet-vim'                  " emmet
Plug 'mileszs/ack.vim'                  " ack
Plug 'mhinz/vim-signify'                " git status along file
Plug 'scrooloose/nerdtree'              " Tree explorer
Plug 'sheerun/vim-polyglot'             " Language starter pack
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

" Use 'i' as a text obj for an indented block
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-user'  " requirement of vim-textobj-indent

" Use 'f' for function, 'c' for class
Plug 'bps/vim-textobj-python'

" Provides lots of textobjects
" Eg 'separator text objects' - delimited by one of , . ; : + - = ~ _ * # /
Plug 'wellle/targets.vim'


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

" use global version of eslint
let g:ale_javascript_eslint_executable = $HOME."/.nvm/versions/node/v10.15.0/bin/eslint"

" check files with linters
let g:ale_linters = {
    \ 'javascript': ['eslint', 'prettier_eslint'],
    \ 'python': ['flake8', 'pylint']
    \ }

" Fix files with ESLint then Prettier
let g:ale_fixers = {
    \ 'javascript': ['eslint', 'prettier_eslint'],
    \ 'python': ['black'],
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
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'

" don't run on file enter
let g:ale_lint_on_enter = 0

" only run when file saved
let g:ale_lint_on_text_changed = 'never'

autocmd User ALELint unsilent echom 'ALE run!'

" }}}
" Plugin > vim-signify/signify {{{
" docs: :h signify-modus-operandi

" hunk text object
omap ic <plug>(signify-motion-inner-pending)
xmap ic <plug>(signify-motion-inner-visual)
omap ac <plug>(signify-motion-outer-pending)
xmap ac <plug>(signify-motion-outer-visual)

" colours
highlight DiffAdd guifg=#00d75f guibg=#fff 
highlight DiffChange guifg=#00afff guibg=#fff 
highlight DiffDelete gui=bold guifg=#d70000 guibg=#fff 

" view diff
nnoremap <leader>hv :SignifyDiff<cr>

" refresh
nnoremap <leader>gr :SignifyRefresh<CR>

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
nmap <leader>f :Files<cr>

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

" search through mappings
nmap <Leader>M :Maps<CR>

" search filetype syntaxes
"nmap <Leader>ft :Filetypes<CR>

" This is the default extra key bindings
let g:fzf_action = {
    \ 'space': 'tab split',
    \ 'ctrl-x': 'split',
    \ 'ctrl-v': 'vsplit' }

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1"

" Customize fzf colors to match your color scheme
let g:fzf_colors =
    \ { 'fg':      ['fg', 'Normal'],
    \ 'bg':      ['bg', 'Normal'],
    \ 'hl':      ['fg', 'Comment'],
    \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
    \ 'hl+':     ['fg', 'Statement'],
    \ 'info':    ['fg', 'PreProc'],
    \ 'border':  ['fg', 'Ignore'],
    \ 'prompt':  ['fg', 'Conditional'],
    \ 'pointer': ['fg', 'Exception'],
    \ 'marker':  ['fg', 'Keyword'],
    \ 'spinner': ['fg', 'Label'],
    \ 'header':  ['fg', 'Comment'] }


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
nmap <leader>gc :Ack! "\b<cword>\b" <CR>

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
let g:user_emmet_leader_key=','

" Enable only for html, css, jsx
let g:user_emmet_install_global = 0
let g:user_emmet_settings = {'javascript.jsx': {'extends': 'jsx'}}
autocmd FileType html,css,javascript.jsx,scss EmmetInstall

" only use in INSERT mode
let g:user_emmet_mode = 'i'

" auto-indent when expanded
let g:user_emmet_settings = {
\  'html' : {
\    'indent_blockelement': 1,
\  },
\}


" }}}
" Saved for later {{{

" Loop over files
" for f in split(glob('~/.config/nvim/config/*.vim'), '\n')
"     exe 'source' f
" endfor

" }}}

" vim:foldmethod=marker:foldlevel=0
