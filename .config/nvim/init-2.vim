" Plug Install: {{{
" ========
"
" autocmd VimEnter *
"       \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
"       \|   PlugInstall --sync | q
"       \| endif

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
let g:coc_node_path = $HOME."/.nvm/versions/node/v14.17.2/bin/node"

if exists('$TMUX')
    " Colors in tmux
    let &t_8f = "<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "<Esc>[48;2;%lu;%lu;%lum"
endif

set termguicolors
set background=dark

" Override highlight set by horizon theme
autocmd BufReadPre * :highlight Pmenu ctermbg=210 ctermfg=230 guifg=#43afc8 guibg=#111111

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/completion-nvim'
Plug 'steelsojka/completion-buffers'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/lsp-status.nvim'
Plug 'glepnir/lspsaga.nvim'
Plug 'crabdul/vim-horizon'
Plug 'sheerun/vim-polyglot'
Plug 'onsails/lspkind-nvim'
Plug 'hoob3rt/lualine.nvim'
Plug 'rizzatti/dash.vim'
Plug 'machakann/vim-highlightedyank'

" Plug 'APZelos/blamer.nvim'
" let g:blamer_enabled = 1

" Initialize plugin system
call plug#end()


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

" Convenience Mappings:
" ==============

" Fast saving
nmap <leader>w :w!<cr>

" Fast quiting
nmap <leader>q :q!<cr>

" Insert space
nmap <enter> o<ESC>

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


" QuickFix List:
" ==============
" Display results in cope
nmap zx :botright cope<cr>

" Close QuickFix window
nmap zz :cclose<cr>

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

" }}}

" Lsp: {{{
" ======


lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)

  require'completion'.on_attach(client, bufnr)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "pyright", "tsserver" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

local saga = require 'lspsaga'
saga.init_lsp_saga {
  error_sign = '',
  warn_sign = '',
  hint_sign = '',
  infor_sign = '',
  border_style = "round",
}

local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    mappings = {
      n = {
        ["q"] = actions.close
      },
    },
  }
}

local status, lualine = pcall(require, "lualine")
if (not status) then return end
lualine.setup {
  options = {
    icons_enabled = true,
    theme = 'solarized_dark',
    section_separators = {'', ''},
    component_separators = {'', ''},
    disabled_filetypes = {}
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {'filename'},
    lualine_x = {
      { 'diagnostics', sources = {"nvim_lsp"}, symbols = {error = ' ', warn = ' ', info = ' ', hint = ' '} },
      'encoding',
      'filetype'
    },
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {'fugitive'}
}

require('lspkind').init({
    -- enables text annotations
    --
    -- default: true
    with_text = true,

    -- default symbol map
    -- can be either 'default' or
    -- 'codicons' for codicon preset (requires vscode-codicons font installed)
    --
    -- default: 'default'
    preset = 'codicons',

    -- override preset symbols
    --
    -- default: {}
    symbol_map = {
      Text = '',
      Method = 'ƒ',
      Function = '',
      Constructor = '',
      Variable = '',
      Class = '',
      Interface = 'ﰮ',
      Module = '',
      Property = '',
      Unit = '',
      Value = '',
      Enum = '了',
      Keyword = '',
      Snippet = '﬌',
      Color = '',
      File = '',
      Folder = '',
      EnumMember = '',
      Constant = '',
      Struct = ''
    },
})

vim.g.completion_chain_complete_list = {
  default = {
    { complete_items = { 'lsp' } },
    { complete_items = { 'buffers' } },
    { mode = { '<c-p>' } },
    { mode = { '<c-n>' } }
  },
}

EOF



" let g:completion_enable_auto_popup = 0

" https://github.com/nvim-lua/completion-nvim#enabledisable-auto-popup
imap <tab> <Plug>(completion_smart_tab)
imap <s-tab> <Plug>(completion_smart_s_tab)

let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy', 'all']

let g:completion_matching_smart_case = 1

let g:completion_word_min_length = 3

nnoremap <silent> <leader>f <cmd>Telescope find_files<cr>
nnoremap <silent> <leader>a <cmd>Telescope live_grep<cr>
nnoremap <silent> <leader>d <cmd>Telescope buffers<cr>

set completeopt=menuone,noinsert,noselect

let g:lsc_server_commands = {
 \ 'javascript': { 'command': 'typescript-language-server --stdio' },
 \ 'javascript.jsx': { 'command': 'typescript-language-server --stdio' },
 \ 'typescript': { 'command': 'typescript-language-server --stdio' },
 \ 'typescript.tsx': { 'command': 'typescript-language-server --stdio' }
 \ }
let g:lsc_auto_map = {
 \  'GoToDefinition': 'gd',
 \  'FindReferences': 'gr',
 \  'Rename': 'gR',
 \  'ShowHover': 'K',
 \  'FindCodeActions': 'ga',
 \  'Completion': 'omnifunc',
 \}

let g:completion_items_priority = {
 \  'Reference': '9',
 \  'Function': '8',
 \  'Method': '5',
 \}

" Statusline
function! LspStatus() abort
  if luaeval('#vim.lsp.buf_get_clients() > 0')
    return luaeval("require('lsp-status').status()")
  endif

  return ''
endfunction

" black.vim
" Author: Łukasz Langa
" Created: Mon Mar 26 23:27:53 2018 -0700
" Requires: Vim Ver7.0+
" Version:  1.2
"
" Documentation:
"   This plugin formats Python files.
"
" History:
"  1.0:
"    - initial version
"  1.1:
"    - restore cursor/window position after formatting
"  1.2:
"    - use autoload script

if v:version < 700 || !has('python3')
    func! __BLACK_MISSING()
        echo "The black.vim plugin requires vim7.0+ with Python 3.6 support."
    endfunc
    command! Black :call __BLACK_MISSING()
    command! BlackUpgrade :call __BLACK_MISSING()
    command! BlackVersion :call __BLACK_MISSING()
    finish
endif

if exists("g:load_black")
  finish
endif

let g:load_black = "py1.0"
if !exists("g:black_virtualenv")
  if has("nvim")
    let g:black_virtualenv = "~/.local/share/nvim/black"
  else
    let g:black_virtualenv = "~/.vim/black"
  endif
endif
if !exists("g:black_fast")
  let g:black_fast = 0
endif
if !exists("g:black_linelength")
  let g:black_linelength = 88
endif
if !exists("g:black_skip_string_normalization")
  if exists("g:black_string_normalization")
    let g:black_skip_string_normalization = !g:black_string_normalization
  else
    let g:black_skip_string_normalization = 0
  endif
endif
if !exists("g:black_quiet")
  let g:black_quiet = 0
endif


command! Black :call black#Black()
command! BlackUpgrade :call black#BlackUpgrade()
command! BlackVersion :call black#BlackVersion()
