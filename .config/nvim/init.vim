

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

" https://github.com/nvim-treesitter/nvim-treesitter
Plug 'nvim-treesitter/nvim-treesitter'

" https://github.com/hrsh7th/nvim-cmp/
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" https://github.com/L3MON4D3/LuaSnip
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

Plug 'itchyny/lightline.vim'
Plug 'vim-denops/denops.vim'
Plug 'lambdalisue/gina.vim'
Plug 'mhinz/vim-signify'
Plug 'machakann/vim-highlightedyank'
Plug 'rhysd/git-messenger.vim'
Plug 'neomake/neomake'
Plug 'christoomey/vim-tmux-navigator'


" Initialize plugin system
call plug#end()


lua <<EOF

lspconfig = require'lspconfig'

local opts = { noremap=true, silent=true }
    vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

local completion_callback = function (client, bufnr)
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


require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
}

-- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end,
    },
    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' }, -- For vsnip users.
        -- { name = 'luasnip' }, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
    }, {
        { name = 'buffer' },
    })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
        { name = 'buffer' },
    })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

lspconfig.tsserver.setup{
    on_attach=completion_callback,
    capabilities = capabilities
}

local python_root_files = {
  'Pipfile',
}

lspconfig.pyright.setup {
    on_attach = completion_callback,
    root_dir = lspconfig.util.root_pattern(unpack(python_root_files)),
    capabilities = capabilities
}

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

nmap gd :SignifyHunkDiff<CR>
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
call neomake#configure#automake('w')


