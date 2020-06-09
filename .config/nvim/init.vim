" Plug Install: {{{
" ========
"
autocmd VimEnter *
      \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
      \|   PlugInstall --sync | q
      \| endif

" }}}

" Environment: {{{
" ========

" Python source
" Run: pip3 install neovim black autopep8
" Figure out the system Python for Neovim.
if exists("$VIRTUAL_ENV")
    let g:python3_host_prog=substitute(system("which -a python3 | head -n2 | tail -n1"), "\n", '', 'g')
else
    let g:python3_host_prog=substitute(system("which python3"), "\n", '', 'g')
endif

" TODO: Use a shim
let g:coc_node_path = $HOME."/.nvm/versions/node/v12.16.2/bin/node"

if exists('$TMUX')
    " Colors in tmux
    let &t_8f = "<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "<Esc>[48;2;%lu;%lu;%lum"
endif

set termguicolors
set background=dark

" colorscheme base16-flat

" }}}

" Plugins: {{{
" ========

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" Palenight theme
Plug 'drewtempelmeyer/palenight.vim'

" Language starter pack
Plug 'sheerun/vim-polyglot'

" Git status along file
Plug 'mhinz/vim-signify'

" Comment out stuff
Plug 'tpope/vim-commentary'

" Extend % for matching for HTML
Plug 'vim-scripts/matchit.zip'

" FZF
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" Provides lots of textobjects
" Eg 'separator text objects' - delimited by one of , . ; : + - = ~ _ * # /
Plug 'wellle/targets.vim'

" Use 'i' as a text obj for an indented block
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-user'  " requirement of vim-textobj-indent

" Use 'f' for function, 'c' for class
Plug 'bps/vim-textobj-python'

Plug 'machakann/vim-highlightedyank'

Plug 'machakann/vim-sandwich'

Plug 'rhysd/git-messenger.vim'

Plug 'dense-analysis/ale'

Plug 'itchyny/lightline.vim'

" Run:
" - :CocInstall coc-python tsserver coc-prettier coc-eslint coc-json
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'bkad/CamelCaseMotion'

" See inside registers
" TODO: not working currently
Plug 'junegunn/vim-peekaboo'

" Edit quickfix list
Plug 'stefandtw/quickfix-reflector.vim'

Plug 'Raimondi/delimitMate'

Plug 'mattn/emmet-vim'

Plug 'lambdalisue/gina.vim'

Plug 'christoomey/vim-tmux-navigator'

Plug 'benmills/vimux'

Plug 'ntk148v/vim-horizon'

Plug 'lambdalisue/fern.vim'

Plug 'rizzatti/dash.vim'

" Initialize plugin system
call plug#end()

" }}}

" Theme: {{{
" ======

" colorscheme palenight
" let g:palenight_terminal_italics=1

set background=dark
colorscheme horizon

" Enable true colours
if (has("termguicolors"))
    set termguicolors
endif

" Override highlight set by horizon theme
" :TODO: Do this more nicely
autocmd BufReadPre * :highlight Pmenu ctermbg=250 guibg=#111111

" }}}

" Core: {{{
" =====

" Switch syntax highlighting on when the terminal has colors
if &t_Co > 2 || has("syntax")
    syntax on
endif

filetype indent plugin on       " Turn on filetype detection
set clipboard=unnamed           " Use system clipboard as default clipboard

" Make swapfiles be kept in a central location to avoid polluting file system
set directory=$HOME/.vim/swapfiles//

" Declare lines from end of file just for vim
" This allows the folding setting to be read
set modelines=1

set wildignore+=**/node_modules/**,**/__pycache__/**

" Leader Keys:
" ============
let mapleader = ","
let maplocalleader = ","
let g:mapleader = ","

" Errors:
" =======
set errorbells
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Mouse:
" ======
set mouse=a                     " Enable use of mouse in all modes
set mousehide                   " Hide mouse when typing

" UI:
" ===
set number                      " Show current line number
set relativenumber              " Show lines number relative to current
set showcmd                     " Show command in bottom bar
set equalalways                 " Keep windows equally sized
set title                       " Set window title to filename
set colorcolumn=80              " Set column width
set lazyredraw                  " Don't redraw while executing macros
set magic                       " For regular expressions turn magic on

" Let terminal resize scale the internal windows
autocmd VimResized * :wincmd =

augroup NumberToggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Editing Behaviour:
" ==================
set tabstop=4                   " Length of tab in spaces
set softtabstop=4               " Number of spaces to add when you hit <tab>
set expandtab                   " Expand tabs into spaces
set shiftwidth=4
set shiftround                  " Round indent to multiple of 'shiftwidth'
set autoindent                  " CR returns to indent of previous line
set backspace=indent,eol,start  " Allows backspacing over everything in insert mode
set scrolloff=10                " Distance from top/bottom to begin scrolling
set noeol                       " Prevent a carriage return at end of last line
set nojoinspaces                " Don't insert two spaces after sentence joins

" Highlighting And Searching:
" ===========================
set hlsearch                    " Highlight search matches
set ignorecase                  " Ignore case when searching
set smartcase                   " When searching try to be smart about cases
set incsearch                   " Search as characters are entered
set cursorline                  " Highlight current line
set inccommand=nosplit          " Show replacement in action
set listchars=tab:>·,trail:.,extends:>,precedes:<
set list                        " Show whitespace as characters
set showmatch                   " Show closing punctuation
set matchtime=1                 " Speed up jump to matching bracket

" Files Buffers:
" ==============
set hidden                      " Don't abandon unloaded buffers, hide them instead
set fileformats=unix            " File format
set autowrite                   " Auto-write file if modified on exit
set autoread                    " Auto-load file if it changes elsewhere
set nobackup                    " Don't keep a back-up file, they're annoying
set noswapfile

" Highlight conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" Center search
cnoremap <expr> <CR> getcmdtype() == '/' ? '<CR>zz' : '<CR>'

" Splits:
" =======
set splitright
set splitbelow

" History:
" ========
" Keep undo history between sessions
if has('persistent_undo')
    set undofile
    set undodir=~/.vim_undo
    set undolevels=2000
endif

" Abbreviations:
" ==============


" Yanking:
" ========

" reyank previously yanked text
nnoremap gb `[v`]y<C-O>


" }}}

" Folding: {{{
" ========

set foldenable
set foldmethod=syntax
set foldlevel=0
set foldnestmax=2
set foldlevelstart=0                    " Starting fold level for a new buffer
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo

" }}}

" Tabs: {{{
" =====

map <leader>tn :tabnew<cr>
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove<space>

" Create directory if :tabedit references one that doesn't exist
au BufNewFile * :exe ': !mkdir -p ' . escape(fnamemodify(bufname('%'),':p:h'),'#% \\')

" Left/right tab
nnoremap H gT
nnoremap L gt

" }}}

" Buffers: {{{
" ========

" If a buffer is already open :sb filename will jump to it
" rather than opening it in the current buffer
try
    set switchbuf=useopen,usetab,newtab
    set stal=2
catch
endtry

" return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" nnoremap bdo :%bd|e#

nnoremap M :bd<cr>
nnoremap <leader>m :bp\|bd #<cr>

set winheight=6
set winminheight=6
autocmd WinEnter * wincmd _

noremap <C-t> <C-^>


" }}}

" Mappings: {{{
" =========

" QuickFix List:
" ==============
" Display results in cope
map <leader>zz :botright cope<cr>

" Close QuickFix window
map <leader>z :cclose<cr>

" Window Navigation:
" ==================
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" NORMAL MODE:
" ============
" Rename the current file
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction

nmap R :call RenameFile()<cr>

" Make yank consistent with other commands
nnoremap Y y$

" Put result in centre of window when jumping between search results
nnoremap n nzz
nnoremap N Nzz

nmap <enter> o<ESC>

" nmap <c-enter> O<ESC>

" Centre when scrolling
nnoremap <c-f> <c-f>zz
nnoremap <c-b> <c-b>zz

nmap <leader>r :e %<CR>

" Edit vimrc
command! Vimrc :tabe $MYVIMRC<cr>

" Source vimrc
command! Sauce :source $HOME/.dotfiles/.vimrc

" Fast saving
nmap <leader>w :w!<cr>

" Fast quiting
nmap <leader>q :q!<cr>

" Move up/down by visual line
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

" Turn off search highlight
nnoremap <bs> :nohlsearch<CR>

" Copy current path of file
nmap <leader>p :let @*=expand("%:.")<CR>

" Revert buffer to state when file was opened
nnoremap gu :u1\|u<CR>

" Format file
" nnoremap F gg=G

" Move line up/down
nnoremap ˚ :m--<CR>==
nnoremap ∆ :m+<CR>==

nnoremap <space> zA

" Open folds after jumping
nnoremap n nzzzO
nnoremap N NzzzO

" Jump to last file
" nnoremap  <leader>y

" Jump between search matches (from the error list) when using :grep and open
" the folds obscuring the matching line.
" Open folds and center
nnoremap <silent> <RIGHT> :cnext<CR>zrzz
nnoremap <silent> <LEFT> :cprev<CR>zrzz

" Search codebase for word under cursor (v useful)
nnoremap gw :Rg <C-R><C-W><CR>

" Pull <cword> onto search/command line
nnoremap gs /<C-R><C-W>

nmap B :bd<CR>

" From http://www.vimregex.com
noremap <leader>/ :%s:<c-r>=expand("<cword>")<cr>::g<Left><Left>
noremap <leader>; :%s:<c-r>=expand("<cword>")<cr>:
            \<c-r>=expand("<cword>")<cr>:g<Left><Left>

noremap <leader>v :botright vsplit<enter>
noremap <leader>x :botright split<enter>

" INSERT MODE:
" ============
" Change working dir to current file dir when in INSERT mode
autocmd InsertEnter * let save_cwd = getcwd() | set autochdir
autocmd InsertLeave * set noautochdir | execute 'cd' fnameescape(save_cwd)

" VISUAL MODE:
" ============
" Move selected up/down
vnoremap ∆ :m '>+1<CR>gv=gv
vnoremap ˚ :m '<-2<CR>gv=gv

" Stay in visual mode when indenting
vnoremap < <gv
vnoremap > >gv

vnoremap <space> zf

" COMMAND MODE:
" =============
" Expand %% to the current diretory
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Expand $$ to the path of the current buffer
cnoremap <expr> $$ getcmdtype() == ':' ? expand('%:p') : '$$'

tnoremap <Esc> <C-\><C-n>

" }}}

" Sessions: {{{
" =========

let g:session_dir = '~/.vim-sessions'

" Shortcuts to execute session saves and restores
exec 'nnoremap <Leader>ts :mksession! ' . g:session_dir . '/*.vim<C-D><BS><BS><BS><BS><BS>'
exec 'nnoremap <Leader>tr :so ' . g:session_dir. '/*.vim<C-D><BS><BS><BS><BS><BS>'

" }}}

" Python: {{{
" =======
au FileType python set foldmethod=indent
au FileType python inoremap <buffer> rjj return<space>
au FileType python inoremap <buffer> ijj import<space>
au FileType python inoremap <buffer> pjj print()<left>
au FileType python inoremap <buffer> fjj # --- <esc>a
au FileType python map <buffer> 1 /class<CR>
au FileType python map <buffer> 2 /def<CR>

" Shortcut to insert pdb
abbrev pdb import ipdb; ipdb.set_trace()
abbrev kw **kwargs
abbrev args *args

" Django:
" =======
autocmd FileType html set filetype=htmldjango
autocmd FileType htmldjango inoremap {{ {{  }}<left><left><left>
autocmd FileType htmldjango inoremap {% {%  %}<left><left><left>
autocmd FileType htmldjango inoremap {# {#  #}<left><left><left>

function! GetOrCreateTest()
    let file_path = expand('%')
    let file_name = split(file_path, '/')[-1]
    let test_file_path = substitute(substitute(file_path, file_name, "test_" . file_name, ""), "src", "src/tests/unit", "")
    exec ':vsplit ' . test_file_path
endfunction

nmap T :call GetOrCreateTest()<cr>

" }}}

" JavaScript: {{{
" =======

au BufRead,BufNewFile *.jsx set filetype=javascript.jsx
au FileType javascript,javascript.jsx setlocal foldlevelstart=20 foldlevel=2

abbrev apos &apos;

" }}}

" HTML: {{{

iabbrev </ </<C-X><C-O>

" }}}

" Markdown: {{{
"
au BufWritePre *.md :normal gqG

" }}}

" Plugin Vim Signify: {{{
" ===================

" Default updatetime 4000ms is not good for async update
set updatetime=100

" Always show signcolumns
set signcolumn=yes

nmap <leader>n :SignifyHunkDiff<CR>
nmap U :SignifyHunkUndo<CR>

" Colours
" Also used by vim-sandwich
highlight DiffAdd guifg=#00d75f guibg=#fff
highlight DiffChange guifg=#00afff guibg=#fff
highlight DiffDelete gui=bold guifg=#d70000 guibg=#fff

" }}}

" Plugin FZF: {{{
" ===========
" Tab or shift-tab can be used to toggle individual selected items
" Enter to populate quickfix list with selected items
map <leader>a :Rg<space>
nmap <leader>f :Files<cr>
nmap <leader>b :Buffers<CR>
nmap <Leader>h :History<CR>
nmap <Leader>l :BLines<CR>
nmap <leader>s :Tags<cr>
" nmap <leader>s :tag<space>
nmap <Leader>d :Files <C-R>=expand('%:p:h') . '/'<CR><Cr>

command! Fzfc call fzf#run(fzf#wrap(
            \ {'source': 'git ls-files --exclude-standard --others --modified'}))

noremap <Leader>c :Fzfc<cr>

function! s:list_buffers()
    redir => list
    silent ls
    redir END
    return split(list, "\n")
endfunction

function! s:delete_buffers(lines)
    execute 'bwipeout' join(map(a:lines, {_, line -> split(line)[0]}))
endfunction

command! BD call fzf#run(fzf#wrap({
            \ 'source': s:list_buffers(),
            \ 'sink*': { lines -> s:delete_buffers(lines) },
            \ 'options': '--multi --reverse --bind ctrl-a:select-all+accept'
            \ }))

" This is the default extra key bindings
let g:fzf_action = {
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-x': 'split',
            \ 'ctrl-v': 'vsplit' }

" Jump to already opened buffer
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

" Show preview
command! -bang -nargs=? -complete=dir Files
            \ call fzf#vim#files(<q-args>,
            \ fzf#vim#with_preview('right:30%', 'ctrl-p'), <bang>0)

" }}}

" Plugin ALE: {{{
" ===========

let g:ale_linters = {
            \ 'python': ['flake8'],
            \ }

let g:ale_fixers = {
            \ '*': ['remove_trailing_lines', 'trim_whitespace'],
            \ 'python': ['black', 'isort'],
            \ }

let g:ale_fix_on_save = 1

" Do not lint or fix minified files.
let g:ale_pattern_options = {
            \ '\.min\.js$': {'ale_linters': [], 'ale_fixers': []},
            \ '\.min\.css$': {'ale_linters': [], 'ale_fixers': []},
            \ }

" Don't use the sign column/gutter for ALE
" let g:ale_set_signs = 0

" Lint always in Normal Mode
let g:ale_lint_on_text_changed = 'normal'

" Lint when leaving Insert Mode but don't lint when in Insert Mode
let g:ale_lint_on_insert_leave = 1

let g:ale_lint_delay = 200

" Don't run on file enter
let g:ale_lint_on_enter = 0

" Only run explicitly stated linters
let g:ale_linters_explicit = 1
"
" Disable auto-detection of virtualenvironments
" let g:ale_virtualenv_dir_names = []

let g:ale_python_isort_use_global = 1
let g:ale_python_black_auto_pipenv = 1
" let g:ale_python_autopep8_use_global = 1
" let g:ale_python_flake8_use_global = 1

" }}}

" Plugin StatusLine: {{{
" ==================

function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    return l:counts.total == 0 ? '' : printf(
                \ '▲:%d ✖︎:%d',
                \ l:all_non_errors,
                \ l:all_errors
                \)
endfunction

let g:lightline = {
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'readonly', 'relativepath', 'modified' ] ],
            \   'right': [ ['percent'], [ 'linterStatus', 'coc', 'ctags' ] ]
            \ },
            \ 'inactive': {
            \   'left': [ [ 'mode' ],
            \             [ 'relativepath'] ],
            \ },
            \ 'component_function': {
            \   'linterStatus': 'LinterStatus',
            \   'coc': 'coc#status',
            \ },
            \ 'colorscheme': 'horizon'
            \ }

" Don't show --INSERT--
set noshowmode

set showtabline=1

" }}}

" Plugin CocVim: {{{
" ==============
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gy <Plug>(coc-implementation)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

nnoremap <silent> <leader>ed  :<C-u>CocList diagnostics<cr>
nnoremap <silent> <leader>ea  :<C-u>CocList actions<cr>


" This isn't working I think
highlight CocErrorSign ctermfg=15 ctermbg=196
highlight CocWarningSign ctermfg=0 ctermbg=172

if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
    let g:coc_global_extensions += ['coc-prettier']
endif

if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
    let g:coc_global_extensions += ['coc-eslint']
endif

" Use <C-l> for trigger snippet expand.
imap jk <Plug>(coc-snippets-expand)

" }}}

" Plugin CamelCaseMotion: {{{
" =======================

map <silent> W <Plug>CamelCaseMotion_w
map <silent> B <Plug>CamelCaseMotion_b
map <silent> E <Plug>CamelCaseMotion_e
map <silent> gE <Plug>CamelCaseMotion_ge
sunmap W
sunmap B
sunmap E
sunmap gE

omap <silent> iW <Plug>CamelCaseMotion_iw
xmap <silent> iW <Plug>CamelCaseMotion_iw
omap <silent> iB <Plug>CamelCaseMotion_ib
xmap <silent> iB <Plug>CamelCaseMotion_ib
omap <silent> iE <Plug>CamelCaseMotion_ie
xmap <silent> iE <Plug>CamelCaseMotion_ie


" }}}

" Plugin GitMessenger: {{{
" ====================

nmap Z :GitMessenger<CR>

let g:git_messenger_include_diff = "current"

" }}}

" Plugin Emmet: {{{
" =============

" Use tab for autocompletion
let g:user_emmet_leader_key=','

" Enable only for html, css, jsx
let g:user_emmet_install_global = 0
let g:user_emmet_settings = {'javascript.jsx': {'extends': 'jsx'}}
autocmd FileType html,css,javascript,javascript.jsx,scss EmmetInstall

" only use in INSERT mode
let g:user_emmet_mode = 'i'

function! Expander()

    let line   = getline(".")
    let col    = col(".")
    let first  = line[col-2]
    let second = line[col-1]
    let third  = line[col]

    if first ==# ">" && second ==# "<" && third ==# "/"
        return "\<CR>\<C-o>==\<C-o>O"
    elseif pumvisible()
        return "\<C-Y>"
        " Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
        " Coc only does snippet and additional edit on confirm.
    else
        return "\<Plug>delimitMateCR"
    endif

endfunction

imap <expr> <CR> Expander()

" }}}

" Plugin Gina: {{{
" ============

:abbrev G Gina
nmap <leader>gs :Gina status -s<cr>
nmap <leader>gc :Gina compare<cr>
nmap <leader>gd :Gina diff<cr>
nmap <leader>gl :Gina log<cr>

" }}}

" Plugin Fern: {{{
" ============

nmap gl :Fern . -reveal=% -drawer -toggle<CR>


" }}}

" Prompt for a command to run
nmap vp :VimuxPromptCommand<CR>


" Misc {{{
" ----

function! GitHubCommitSearch()
    let s:currentWord = expand("<cword>")
    if s:currentWord != ""
        let s:uri = "https://github.com/search?q=++".s:currentWord."&type=Commits"
        echo s:uri
        silent exec "!open '".s:uri."'"
    else
        echo "Hmmm no word found"
    endif
endfunction

map <leader>gh :call GitHubCommitSearch()<cr>

" }}}

" default ''.
" n for Normal mode
" v for Visual mode
" i for Insert mode
" c for Command line editing, for 'incsearch'

" vim:foldmethod=marker:foldlevel=0
