" ============
" Environment:
" ============

" Python source
" Run: pip3 install neovim black autopep8 pynvim
" Figure out the system Python for Neovim.
if exists("$VIRTUAL_ENV")
    let g:python3_host_prog=substitute(system("which -a python3 | head -n2 | tail -n1"), "\n", '', 'g')
else
    let g:python3_host_prog=substitute(system("which python3"), "\n", '', 'g')
endif


" =====
" Plug:
" =====

" Install any new plugins
autocmd VimEnter *
            \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
            \|   PlugInstall --sync | q
            \| endif

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" MUST
" ----

Plug 'crabdul/vim-horizon' " Theme
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " FZF
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-commentary'
Plug 'itchyny/lightline.vim'
Plug 'lambdalisue/gina.vim'
Plug 'mhinz/vim-signify'
Plug 'machakann/vim-highlightedyank'
Plug 'rhysd/git-messenger.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'github/copilot.vim'

" LSP
" ---

Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'

" CHECK
" -----

" Black
Plug 'averms/black-nvim'
Plug 'vim-denops/denops.vim'
Plug 'neomake/neomake'


" Initialize plugin system
call plug#end()


lua <<EOF

-- 1. LSP Sever management
require('mason').setup()
require('mason-lspconfig').setup_handlers({ function(server)
  local opt = {
    -- -- Function executed when the LSP server startup
    -- on_attach = function(client, bufnr)
    --   local opts = { noremap=true, silent=true }
    --   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    --   vim.cmd 'autocmd BufWritePre * lua vim.lsp.buf.formatting_sync(nil, 1000)'
    -- end,
    capabilities = require('cmp_nvim_lsp').update_capabilities(
      vim.lsp.protocol.make_client_capabilities()
    )
  }
  require('lspconfig')[server].setup(opt)
end })

-- 2. build-in LSP function
-- keyboard shortcut
vim.keymap.set('n', 'K',  '<cmd>lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', 'gf', '<cmd>lua vim.lsp.buf.formatting()<CR>')
vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
vim.keymap.set('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>')
vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
vim.keymap.set('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>')
vim.keymap.set('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>')
vim.keymap.set('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
-- LSP handlers
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }
)
-- Reference highlight
vim.cmd [[
set updatetime=500
highlight LspReferenceText  cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
highlight LspReferenceRead  cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
highlight LspReferenceWrite cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
augroup lsp_document_highlight
  autocmd!
  autocmd CursorHold,CursorHoldI * lua vim.lsp.buf.document_highlight()
  autocmd CursorMoved,CursorMovedI * lua vim.lsp.buf.clear_references()
augroup END
]]

EOF

" https://blog.ojisan.io/neovim-config/

" ==============
" Core Settings:
" ==============

set clipboard=unnamed            " Use system clipboard as default clipboard


" ======
" Theme:
" ======

" colorscheme palenight
" let g:palenight_terminal_italics=1

set background=dark
colorscheme horizon

" Enable true colours
if (has("termguicolors"))
    set termguicolors
endif


" ===
" UI:
" ===

set number                       " Show current line number
set norelativenumber             " Show line number 
set showcmd                      " Show command in bottom bar
set lazyredraw                   " Don't redraw while executing macros
set magic                        " For regular expressions turn magic on


" ======
" Mouse:
" ======
"
set mouse=a                     " Enable use of mouse in all modes
set mousehide                   " Hide mouse when typing


" ========
" History:
" ========

" Keep undo history between sessions
if has('persistent_undo')
    set undofile
    set undodir=~/.vim_undo
    set undolevels=2000
endif


" ==================
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


" ===========================
" Highlighting And Searching:
" ===========================

set hlsearch                    " Highlight search matches
set ignorecase                  " Ignore case when searching
set smartcase                   " When searching try to be smart about cases
set incsearch                   " Search as characters are entered
set cursorline                  " Highlight current line
set inccommand=nosplit          " Show replacement in action
set listchars=tab:>?,trail:.,extends:>,precedes:<
set list                        " Show whitespace as characters
set showmatch                   " Show closing punctuation
set matchtime=1                 " Speed up jump to matching bracket


" =============
" File Buffers:
" =============

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


" ============
" Leader Keys:
" ============

let mapleader = ","
let maplocalleader = ","
let g:mapleader = ","


" =====
" Tabs:
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


" ========
" Buffers:
" ========

" If a buffer is already open :sb filename will jump to it
" rather than opening it in the current buffer
try
    set switchbuf=useopen,usetab,newtab
    set stal=2
catch
endtry

" Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Close buffer
nnoremap <leader>d :bp\|bd #<cr>

" Close tab
nnoremap <leader>D :bd<cr>

noremap <leader>v :botright vsplit<enter>
noremap <leader>x :botright split<enter>
set winheight=6
set winminheight=6
autocmd WinEnter * wincmd _


" ==================
" Window Navigation:
" ==================

map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l


" =======
" Splits:
" =======

set splitright
set splitbelow


" ========
" Yanking:
" ========

" reyank previously yanked text
nnoremap gb `[v`]y<C-O>


" ============
" NORMAL MODE:
" ============

" Fast saving
nmap <leader>w :w!<cr>

" Fast quit
nmap <leader>q :q!<cr>

" Enter space below
nmap <enter> o<ESC>

" Turn off search highlight
nnoremap <bs> :nohlsearch<CR>

" Copy current path of file
nmap <leader>p :let @*=expand("%:.")<CR>

" Revert buffer to state when file was opened
nnoremap gu :u1\|u<CR>

nnoremap <space> zA

" Open folds after jumping
nnoremap n nzzzO
nnoremap N NzzzO

" Jump between search matches (from the error list) when using :grep and open
" the folds obscuring the matching line.
" Open folds and center
nnoremap <silent> <RIGHT> :cnext<CR>zrzz
nnoremap <silent> <LEFT> :cprev<CR>zrzz


" =======
" Search:
" =======

" Search codebase for word under cursor (v useful)
nnoremap gw :Rg <C-R><C-W><CR>

" Pull <cword> onto search/command line
nnoremap gs /<C-R><C-W>


" ========
" Replace:
" ========

" From http://www.vimregex.com
noremap <leader>/ :%s:<c-r>=expand("<cword>")<cr>::g<Left><Left>
noremap <leader>; :%s:<c-r>=expand("<cword>")<cr>:
            \<c-r>=expand("<cword>")<cr>:g<Left><Left>


" ===================
" Plugin Vim Signify:
" ===================

" Always show signcolumns
set signcolumn=yes

" nmap gd :SignifyHunkDiff<CR>
nmap U :SignifyHunkUndo<CR>

nmap gj <plug>(signify-next-hunk)
nmap gk <plug>(signify-prev-hunk)


" ===========
" Plugin FZF:
" ===========

command! Fzfc call fzf#run(fzf#wrap(
            \ {'source': 'git ls-files --exclude-standard --others --modified'}))

" Command shortcuts
map <leader>a :Rg<space>
nmap <leader>f :Files<cr>
nmap <leader>b :Buffers<CR>
nmap <Leader>h :History<CR>
nmap <Leader>l :BLines<CR>
nmap <leader>s :Tags<cr>
nmap <Leader>m :Files <C-R>=expand('%:p:h') . '/'<CR><Cr>
noremap <Leader>c :Fzfc<cr>

" Shortcuts for opening file
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


let g:lightline = {
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'readonly', 'relativepath', 'modified' ] ],
            \   'right': [ ['percent'], [ 'linterStatus', 'ctags' ] ]
            \ },
            \ 'inactive': {
            \   'left': [ [ 'mode' ],
            \             [ 'relativepath'] ],
            \ },
            \ }


            " \ 'colorscheme': 'horizon'
" let g:lightline#colorscheme#landscape#palette = lightlinep
" let lightlinep.normal.middle = [ [ '#dadada', '#121212', 253, 233 ] ]


" ===========
" Plugin Gin:
" ===========

nmap <leader>gs :Gina status -s<cr>
nmap <leader>gc :Gina compare<cr>
nmap <leader>gd :Gina diff<cr>
nmap <leader>gl :Gina log<cr>


" ====================
" Plugin GitMessenger:
" ====================

nmap Z :GitMessenger<CR>

let g:git_messenger_include_diff = "current"

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


" ========
" Neomake:
" ========

" When writing a buffer (no delay).
call neomake#configure#automake('nw', 750)


