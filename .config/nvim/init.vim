

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

Plug 'crabdul/vim-horizon' " Theme
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " FZF
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-commentary'
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'itchyny/lightline.vim'
Plug 'vim-denops/denops.vim'
Plug 'lambdalisue/gin.vim'
Plug 'mhinz/vim-signify'

" Initialize plugin system
call plug#end()


lua <<EOF

local opts = { noremap=true, silent=true }
    vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

require'nvim-lsp-installer'.on_server_ready(function(server)
    local opts = {}

    opts.on_attach = on_attach

    server:setup(opts)
end)

require'nvim-treesitter.configs'.setup {
        -- A list of parser names, or "all"
    ensure_installed = { "python", "lua", "rust" },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    highlight = {
            -- `false` will disable the whole extension
        enable = true,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
}

EOF


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


" ============
" NORMAL MODE:
" ============

" Fast saving
nmap <leader>w :w!<cr>

" Fast quit
nmap <leader>q :q!<cr>

" Enter space below
nmap <enter> o<ESC>


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
nmap <Leader>d :Files <C-R>=expand('%:p:h') . '/'<CR><Cr>
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
