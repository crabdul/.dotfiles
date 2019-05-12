" General {{{

" Python source
let g:python_host_prog = $HOME."/neovim2/bin/python"
let g:python3_host_prog = $HOME."/neovim3/bin/python"

syntax on
set history=500				" sets how many lines of history VIM has to remember
let mapleader = ","              " display using :echo mapleader

" Can quit with capital Q
command! Q q

" edit vimrc
nmap <leader>se :tabe $MYVIMRC<cr>

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

" make swapfiles be kept in a central location to avoid polluting file system
set directory=$HOME/.vim/swapfiles//


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
set colorcolumn=80              " set column width

set noerrorbells                 " No annoying sounds on errors
set novisualbell
set t_vb=
set tm=500

" Open new split panes to right and bottom
set splitbelow
set splitright

" let terminal resize scale the internal windows
autocmd VimResized * :wincmd =

augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" }}}
" Tabs and spaces {{{

set tabstop=4
set shiftwidth=4
set softtabstop=4                " number of spaces in tab when editing
set expandtab                    " tabs are spaces

set list                         " highlight extra white spaces
set listchars=tab:>.,trail:.,extends:#,nbsp:.

autocmd FileType ruby setlocal expandtab shiftwidth=4 tabstop=4

" tabline
set guitablabel=%N\ %f

" Dynamically set window size
" source https://forum.upcase.com/t/vimrc-winminwidth-e36-not-enough-room-error/4334
set winheight=6
set winminheight=6
let &winheight = &lines - 5
set winwidth=40
set winminwidth=40
let &winwidth = &columns - 40


" }}}
" Searching and highlighting {{{

set hlsearch                     " higlight matches
set ignorecase                   " Ignore case when searching
set smartcase                    " When searching try to be smart about cases
set incsearch                    " search as characters are entered

set cursorline                   " highlight current line

set inccommand=nosplit           " replace in realtime

" highlight conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" turn off search highlight
nnoremap <bs> :nohlsearch<CR>

" keep working directory as the one from where vim was opened in Insert mode
autocmd InsertEnter * let save_cwd = getcwd() | set autochdir
autocmd InsertLeave * set noautochdir | execute 'cd' fnameescape(save_cwd)

" pull <cword> onto search/command line
nnoremap gs /<C-R><C-W>

" }}}
" Folding {{{

set foldenable                   " enable folding
set foldlevel=0
set foldlevelstart=1
set foldnestmax=2
set foldmethod=indent            " fold based on indent level
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo

" toggle fold
nnoremap <leader>d zA
nnoremap <leader>e za


" }}}
" Movement {{{
" source: https://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/

" move down by visual line
nnoremap <expr> j v:count ? 'j' : 'gj'

" move up by visual line
nnoremap <expr> k v:count ? 'k' : 'gk'

" highlight last inserted text
nnoremap gV `[v`]

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
map <leader>tc :tabclose<cr>
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

au BufNewFile * :exe ': !mkdir -p ' . escape(fnamemodify(bufname('%'),':p:h'),'#% \\')


" }}}
" Spell checking {{{

" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Add definition
map <leader>sa zg

" }}}
" Exploring {{{

nnoremap <Leader>v :Files <C-R>=expand('%:p:h') . '/'<CR><Cr>

" Open file under cursor in new tab
nmap <silent> gF <c-w>v<c-w>lgf


" }}}
" INSERT MODE {{{

" move lines up/down
inoremap ˚ <Esc>:m .-2<CR>==gi
inoremap ∆ <Esc>:m .+1<CR>==gi

" }}}
" NORMAL MODE {{{

" Make yank consistent with other commands
nnoremap Y y$

" Put result in centre of window when jumping between search results
nnoremap n nzz
nnoremap N Nzz

" Centre when scrolling
nnoremap <c-f> <c-f>zz
nnoremap <c-b> <c-b>zz

" move line up/down
nnoremap ˚ :m--<CR>==
nnoremap ∆ :m+<CR>==

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
vnoremap ∆ :m '>+1<CR>gv=gv
vnoremap ˚ :m '<-2<CR>gv=gv


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
" SCSS, CSS filetypes {{{


" }}}
" Markdown filetypes {{{

" wrap text
au BufRead,BufNewFile *.md setlocal textwidth=80

autocmd FileType markdown set conceallevel=0


" }}}
" Rails {{{

autocmd BufNewFile,BufRead *.html.erb set filetype=html
autocmd BufNewFile,BufRead *.html.erb set filetype=html.eruby

" }}}
" Plugins {{{

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

Plug 'mhinz/vim-startify'

" Palenight theme
Plug 'drewtempelmeyer/palenight.vim'

Plug 'chrisbra/vim-diff-enhanced'
Plug 'easymotion/vim-easymotion'
Plug 'ludovicchabant/vim-gutentags'     " manager for tag files
Plug 'mattn/emmet-vim'                  " emmet
Plug 'mileszs/ack.vim'                  " ack
Plug 'mhinz/vim-signify'                " git status along file
Plug 'scrooloose/nerdtree'              " Tree explorer
Plug 'sheerun/vim-polyglot'             " Language starter pack
Plug 'qpkorr/vim-bufkill'               " close buffer and keep window open
Plug 'tpope/vim-commentary'             " Comment out stuff
Plug 'tpope/vim-repeat'                 " repeat last command
Plug 'vim-scripts/indentLine.vim'       " indent guides
Plug 'vim-scripts/matchit.zip'          " extend % for matching for HTML
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

Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-python', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-highlight', {'do': 'yarn install --frozen-lockfile'}

Plug 'SirVer/ultisnips'

Plug 'machakann/vim-highlightedyank'

Plug 'tpope/vim-rails'

Plug 'lambdalisue/gina.vim'

Plug 'Raimondi/delimitMate'

Plug 'machakann/vim-sandwich'

Plug 'bkad/CamelCaseMotion'

Plug 'junegunn/vim-peekaboo'

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
let g:ale_linters = {
    \ 'javascript': ['eslint', 'prettier'],
    \ 'python': ['black']
    \ }

" Fix files with ESLint then Prettier
let g:ale_fixers = {
    \ '*': ['remove_trailing_lines', 'trim_whitespace'],
    \ 'javascript': ['eslint', 'prettier'],
    \ 'python': ['black'],
    \ }

" Set this variable to 1 to fix files when you save them
let g:ale_fix_on_save = 1

" Do not lint or fix minified files.
let g:ale_pattern_options = {
    \ '\.min\.js$': {'ale_linters': [], 'ale_fixers': []},
    \ '\.min\.css$': {'ale_linters': [], 'ale_fixers': []},
    \ }

" Don't use the sign column/gutter for ALE
let g:ale_set_signs = 0

" Lint always in Normal Mode
let g:ale_lint_on_text_changed = 'normal'

" Lint when leaving Insert Mode but don't lint when in Insert Mode
let g:ale_lint_on_insert_leave = 1

" Set ALE's 200ms delay to zero
let g:ale_lint_delay = 0

" Set gorgeous colors for marked lines to sane, readable combinations
" working with any colorscheme
au VimEnter,BufEnter,ColorScheme *
  \ exec "hi! ALEInfoLine
    \ guifg=".(&background=='light'?'#808000':'#ffff00')."
    \ guibg=".(&background=='light'?'#ffff00':'#555500') |
  \ exec "hi! ALEWarningLine
    \ guifg=".(&background=='light'?'#808000':'#ffff00')."
    \ guibg=".(&background=='light'?'#ffff00':'#555500') |
  \ exec "hi! ALEErrorLine
    \ guifg=".(&background=='light'?'#ff0000':'#ff0000')."
    \ guibg=".(&background=='light'?'#ffcccc':'#550000')

" don't run on file enter
let g:ale_lint_on_enter = 0


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


" }}}
" Plugin > Omni complete functions {{{

autocmd FileType css set omnifunc=csscomplete#CompleteCSS

" }}}
" StatusLine: {{{

let g:currentmode={
            \ 'n'      : 'NORMAL',
            \ 'no'     : 'N·Operator Pending',
            \ 'v'      : 'VISUAL',
            \ 'V'      : 'V·LINE',
            \ '\<C-V>' : 'V·BLOCK',
            \ 's'      : 'Select',
            \ 'S'      : 'S·Line',
            \ '\<C-S>' : 'S·Block',
            \ 'i'      : 'INSERT',
            \ 'R'      : 'R',
            \ 'Rv'     : 'V·Replace',
            \ 'c'      : 'Command',
            \ 'cv'     : 'Vim Ex',
            \ 'ce'     : 'Ex',
            \ 'r'      : 'Prompt',
            \ 'rm'     : 'More',
            \ 'r?'     : 'Confirm',
            \ '!'      : 'Shell',
            \ 't'      : 'TERMINAL '
            \}


" Automatically change the statusline color depending on mode
function! ChangeStatuslineColor()
    if (mode() =~# '\v(n|no)')
        exe 'hi! StatusLine guifg=#ffffff guibg=#5b7fbb'
    elseif (mode() =~# '\v(v|V)' || g:currentmode[mode()] ==# 'V·Block' || get(g:currentmode, mode(), '') ==# 't')
        exe 'hi! StatusLine guifg=#ffffff guibg=#dd6188'
    elseif (mode() ==# 'i')
        exe 'hi! StatusLine guifg=#051d00 guibg=#88ae88'
    else
        exe 'hi! StatusLine guifg=#ffffff guibg=#d6afb0'
    endif

    return ''
endfunction

" Function: display errors from Ale in statusline
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

set laststatus=2
set statusline=
set statusline+=%{ChangeStatuslineColor()}               " Changing the statusline color
set statusline+=%0*\ %{toupper(g:currentmode[mode()])}   " Current mode
set statusline+=\ %*
set statusline+=%3*\ %F
set statusline+=%1*\ %m                 " Modified flag
set statusline+=%1*\ %r                 " Read only flag
set statusline+=%=
set statusline+=%3{coc#status()}
set statusline+=%3*\ %{LinterStatus()}
set statusline+=%3*\ %*
set statusline+=%3*\ %3p%%\                 " total (%)
set statusline+=%3*\ %*

hi User1 guifg=#ffffff  guibg=#222222
hi User2 guifg=#ffffff guibg=#111111
hi User3 guifg=#ffffff guibg=#222222

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
nmap <leader>t :Tags<cr>

" command
nmap <leader>C :Commands<cr>

" search through mappings
nmap <Leader>M :Maps<CR>

command! Fzfc call fzf#run(fzf#wrap(
  \ {'source': 'git ls-files --exclude-standard --others --modified'}))

noremap <Leader>c :Fzfc<cr>

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

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview('right:50%', 'ctrl-p'), <bang>0)

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
nmap gw :Ack! "\b<cword>\b" <CR>

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
" Plugin > vim-gutentags {{{

let g:gutentags_project_root = ['.git']

let g:gutentags_generate_on_new = 1

let g:gutentags_generate_on_write = 1


" }}}
" Plugin > coc.nvim {{{


set updatetime=300
" if hidden not set, TextEdit might fail.
set hidden

" Better display for messages
set cmdheight=2

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

set completeopt-=preview


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

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" trigger completion.
inoremap <silent><expr> <leader>t coc#refresh()

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD <c-w>v<c-w>l<Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Using CocList
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>


" }}}
" UltiSnips {{{ "

let g:UltiSnipsExpandTrigger="mm"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories=['/Users/abdulkarim/.vim/ultisnips']
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" }}} UltiSnips "
" DelimitMate: {{{

let delimitMate_expand_cr = 1


" }}}
" Gina: {{{

command! G Gina
command! Gs Gina status -s

" }}}
" CamelCaseMotion: {{{

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

" vim:foldmethod=marker:foldlevel=0
