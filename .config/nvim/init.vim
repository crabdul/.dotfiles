" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" Language starter pack
Plug 'sheerun/vim-polyglot'

" Git status along file
Plug 'mhinz/vim-signify'

" Comment out stuff
Plug 'tpope/vim-commentary'

" Extend % for matching for HTML
Plug 'vim-scripts/matchit.zip'

" FZF
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
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

Plug 'itchyny/lightline.vim'

Plug 'bkad/CamelCaseMotion'

" Edit quickfix list
Plug 'stefandtw/quickfix-reflector.vim'

Plug 'Raimondi/delimitMate'

Plug 'mattn/emmet-vim'

Plug 'lambdalisue/gina.vim'

Plug 'christoomey/vim-tmux-navigator'

Plug 'benmills/vimux'

Plug 'crabdul/vim-horizon'

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
set foldlevel=1
set foldnestmax=2
set foldlevelstart=1                    " Starting fold level for a new buffer
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

nnoremap <leader>n :bd<cr>
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
command! Sauce :source $HOME/.dotfiles/.config/nvim/init.vim

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
cnoremap <expr> $$ getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Expand $$ to the path of the current buffer
cnoremap <expr> %% getcmdtype() == ':' ? expand("%") : '$$'

tnoremap <Esc> <C-\><C-n>

" }}}

" Python: {{{
" =======

" Shortcut to insert pdb
abbrev pd import ipdb; ipdb.set_trace()

function! PythonModulePath()
    let filepath = expand('%:p:h')
    let @* = join(split(split(filepath, "src")[1], "/"), ".")
endfunction

nmap md :call PythonModulePath()<cr>

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

" HTML: {{{

iabbrev </ </<C-X><C-O>

" }}}

" Plugin Vim Signify: {{{
" ===================

" Default updatetime 4000ms is not good for async update
set updatetime=100

" Always show signcolumns
set signcolumn=yes

nmap gd :SignifyHunkDiff<CR>
nmap U :SignifyHunkUndo<CR>

nmap <leader>gj <plug>(signify-next-hunk)
nmap <leader>gk <plug>(signify-prev-hunk)

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

" Plugin StatusLine: {{{
" ==================

let g:lightline = {
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'readonly', 'relativepath', 'modified' ] ],
            \   'right': [ ['percent'], [ 'ctags' ] ]
            \ },
            \ 'inactive': {
            \   'left': [ [ 'mode' ],
            \             [ 'relativepath'] ],
            \ },
            \ 'colorscheme': 'horizon'
            \ }

" Don't show --INSERT--
set noshowmode

set showtabline=1

" }}}

" Plugin CamelCaseMotion: {{{
" =======================

map <silent> W <Plug>CamelCaseMotion_w
map <silent> B <Plug>CamelCaseMotion_b
map <silent> E <Plug>CamelCaseMotion_e
map <silent> gE <Plug>CamelCaseMotion_ge


" }}}

" Plugin GitMessenger: {{{
" ====================

nmap Z :GitMessenger<CR>

let g:git_messenger_include_diff = "current"

" }}}

" Plugin Gina: {{{
" ============

:abbrev G Gina
nmap <leader>gs :Gina status -s<cr>
nmap <leader>gc :Gina compare<cr>
nmap <leader>gd :Gina diff<cr>
nmap <leader>gl :Gina log<cr>

" }}}

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

" Kraken

function! UnitTestModuleFilepath(filepath)
    " Return the filepath of the corresponding unit test module to current
    " file.
    let path_segments = split(a:filepath, "/")
    let filename = path_segments[-1]
    " Ignore the underscore in "private" modules
    if filename =~ "^_"
        let filename = filename[1:]
    endif
    return "tests/unit/common/" . join(path_segments[1:-2], "/") . "/test_" . filename
endfunction

function! ApplicationModuleFilepath(filepath)
    " Return the filepath of the corresponding unit test module to current
    " file.
    let path_segments = split(a:filepath, "/")
    let index = index(path_segments, "tests")
    let filename = substitute(path_segments[-1], "test_", "", "")
    return "octoenergy/" . join(path_segments[index + 2:-2], "/") . "/" . filename
endfunction

function! ComplementaryFilepath(filepath)
    " Return the filepath of the corresponding unit-test or application module
    if match(a:filepath, "tests/") != -1
        return ApplicationModuleFilepath(a:filepath)
    else
        return UnitTestModuleFilepath(a:filepath)
    end
endfunction

function! PyTestOptions(filepath)
    " Return the options to run PyTest with

    " Unit tests
    if match(a:filepath, 'tests/unit/territories/jpn/plugins/territories/jpn') != -1
        return " --ds=tests.settings --dc=OEJPInterfaceAgnostic "
    endif
    if match(a:filepath, 'tests/unit/clients/oejp') != -1
        return " --ds=tests.settings --dc=OEJPInterfaceAgnostic "
    endif

    " Integration tests
    if match(a:filepath, 'tests/integration/territories/jpn') != -1
        return " --ds=tests.settings --dc=OEJPInterfaceAgnostic "
    endif
    if match(a:filepath, 'tests/integration/clients/oejp') != -1
        return " --ds=tests.settings --dc=OEJPInterfaceAgnostic "
    endif

    " Functional tests
    if match(a:filepath, 'tests/functional/commands/territories/jpn') != -1
        return " --ds=tests.settings --dc=OEJPManagementCommand "
    endif
    if match(a:filepath, 'tests/functional/commands/clients/oejp') != -1
        return " --ds=tests.settings --dc=OEJPManagementCommand "
    endif
    if match(a:filepath, 'tests/functional/tasks/territories/jpn') != -1
        return " --ds=tests.settings --dc=OEJPWorker "
    endif
    if match(a:filepath, 'tests/functional/apisite/territories/jpn') != -1
        return " --ds=tests.settings --dc=OEJPAPISite "
    endif
    if match(a:filepath, 'tests/functional/supportsite/territories/jpn') != -1
        return " --ds=tests.settings --dc=OEJPSupportSite "
    endif
    if match(a:filepath, 'tests/functional/webhooksite/territories/jpn') != -1
        return " --ds=tests.settings --dc=OEJPWebhookSite "
    endif

    " For common tests, just use OE conf
    if match(a:filepath, 'tests/functional/supportsite/common') != -1
        return " --ds=tests.settings --dc=OctoEnergySupportSite "
    endif
    return ""
endfunction
function! RunMostRecentTest()
    " Run the most recent test function
    " Write all files
    if expand("%") != ""
        :wall
    end
    " Check if we're editing a test module. If so, store the path in a var
    let in_test_file = match(expand("%"), 'test_.*\.py$') != -1
    if in_test_file
        " Grab the filepath module name
        let t:test_path = expand("%")
        let t:test_module = @%
        " Use a mark to return cursor to original position
        exe "normal mz"
        " Now walk back from cursor to last test function name. Note we need
        " to escape the <CR> to avoid vim thinking it's part of the search
        " query.
        normal $
        exec "normal! ?def test_?e\<cr>"
        let t:test_function = expand("<cword>")
        " If in test file, return cursor to original position
        exe "normal `z"
    end
    if !exists("t:test_module")
        echo "Don't know which test module to run!"
    elseif !exists("t:test_function")
        echo "Don't know which test function to run!"
    else
        let t:test_options = PyTestOptions(t:test_path)
        exec "silent :!clear"
        exec "silent :!echo -e \"Running \033[0;35m" . t:test_function . "\033[0m from \033[0;34m" . t:test_module . "\033[0m ...\""
        let cmd = "py.test -s " . t:test_options . t:test_module . " -k " . t:test_function . " -v -ss"
        exec "!tmux send -l -t 2 " . "\"" . cmd . "\""
    end
endfunction
function! RunMostRecentTestModule()
    " Run tests for the most *recent* test module.
    "
    " By "recent", I mean either:
    "
    " - The test module that is currently being edited;
    " - The corresponding unit test module for the application module being
    "   edited.
    " Write all files before running any tests
    if expand("%") != ""
        :wall
    end
    " Check if we're editing a test module. If so, store the path in a
    " tab-scoped variable.
    if match(expand("%:t"), 'test_.*\.py$') != -1
        let t:test_module=@%
    else
        " If we're not editing a test module, look for the corresponding unit test
        " module for the production module we're in
        let test_module_filepath = UnitTestModuleFilepath(expand("%"))
        if filereadable(test_module_filepath)
            let t:test_module=test_module_filepath
        end
    end
    if !exists("t:test_module")
        echo "Don't know which test module to run!"
    else
        let t:test_options = PyTestOptions(t:test_module)
        exec "silent :!clear"
        exec "silent :!echo -e \"Running tests from \033[0;34m" . t:test_module . "\033[0m ...\""
        let cmd = "py.test\s" . t:test_options . t:test_module
        exec "!tmux send -t 2 " . "\"" . cmd . "\""
    end
endfunction
" Mappings
" --------
" Run most recent test
nmap <leader>u  :call RunMostRecentTest()<cr>

" Run most recent test module
nmap <leader>U :call RunMostRecentTestModule()<cr>

" Jump to the corresponding unit-test or application module
nmap <leader>e :exec ":vsplit " . ComplementaryFilepath(expand("%"))<cr>

abbrev iamodels from octoenergy.data.accounts import models as accounts_models
abbrev imsmodels from octoenergy.data.market_supply import models as ms_models


" default ''.
" n for Normal mode
" v for Visual mode
" i for Insert mode
" c for Command line editing, for 'incsearch'

" vim:foldmethod=marker:foldlevel=0
