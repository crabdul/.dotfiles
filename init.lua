--[[ Setup notes

## 2023-06-08

Install packer [source](https://www.meetgor.com/neovim-vimscript-to-lua/)
https://github.com/wbthomason/packer.nvim

### Mason

:Mason to open available language servers
:MasonInstall pyright to install python lsp


Added use 'wbthomason/packer.nvim'
after downloading it on the command line

Minimal setup copied over from https://github.com/neovim/nvim-lspconfig

Install autocompletion plugins from https://github.com/hrsh7th/nvim-cmp/

If folds don't work, checkout https://github.com/nvim-treesitter/nvim-treesitter/wiki/Installation#packernvim

:MasonInstall black
:MasonInstall isort

mkvirtualenv vim
Install https://github.com/python-lsp/python-lsp-black

Maybe install into the kraken-core venv instead
pip install "python-lsp-server[all]" pyls-isort


-- ]]


require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'crabdul/vim-horizon'
    use {
        "williamboman/mason.nvim",
        run = ":MasonUpdate" -- :MasonUpdate updates registry contents
    }
    use {
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    }
    use {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/nvim-cmp',
        'onsails/lspkind.nvim', -- Optional icons. Requires https://www.nerdfonts.com/font-downloads
    }
    use { 'ibhagwan/fzf-lua',
        -- optional for icon support
        requires = { 'nvim-tree/nvim-web-devicons' }
    }
    use { "anuvyklack/windows.nvim",
        requires = {
            "anuvyklack/middleclass",
            "anuvyklack/animation.nvim"
        },
        config = function()
            vim.o.winwidth = 10
            vim.o.winminwidth = 10
            vim.o.equalalways = false
            require('windows').setup()
        end
    }
    use({
            "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
            config = function()
                require("lsp_lines").setup()
            end,
        })
    use {
        'lewis6991/gitsigns.nvim',
        -- tag = 'release' -- To use the latest release (do not use this if you run Neovim nightly or dev builds!)
    }
    use 'lambdalisue/gina.vim'
    use 'christoomey/vim-tmux-navigator'
    use {
        'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'
    }
    use 'machakann/vim-highlightedyank'
    use 'ambv/black'
    use 'tpope/vim-commentary'

end)

-- TODO:
if vim.fn.exists('$VIRTUAL_ENV') ~= 0 then
    local python3_host_prog = vim.fn.substitute(vim.fn.system('which -a python3 | head -n2 | tail -n1'), "\n", '', 'g')
    vim.g.python3_host_prog = python3_host_prog
else
    local python3_host_prog = vim.fn.substitute(vim.fn.system('which python3'), "\n", '', 'g')
    vim.g.python3_host_prog = python3_host_prog
end

vim.cmd[[set termguicolors]]
vim.cmd[[set background=dark]]
vim.cmd[[colorscheme horizon]]

-- Turn on filetype detection
vim.cmd('filetype indent plugin on')

-- Use system clipboard as default clipboard
vim.o.clipboard = 'unnamed'

-- Make swapfiles be kept in a central location to avoid polluting file system
vim.o.directory = '$HOME/.vim/swapfiles//'

-- Declare lines from end of file just for vim
-- This allows the folding setting to be read
vim.o.modelines = 1

-- Ignore specific directories
vim.o.wildignore = vim.o.wildignore .. '**/node_modules/**,**/__pycache__/**'

-- Errors
vim.o.errorbells = true
vim.o.noerrorbells = true
vim.o.novisualbell = true
vim.o.t_vb = ''
vim.o.tm = 500

-- Mouse
vim.o.mouse = 'a'
vim.o.mousehide = true

-- UI
vim.o.number = true
vim.o.relativenumber = false
vim.o.showcmd = true
vim.o.equalalways = true
vim.o.title = true
vim.o.colorcolumn = '80'
vim.o.lazyredraw = true
vim.o.magic = true

vim.cmd[[let mapleader = ","]]
vim.cmd[[let maplocalleader = ","]]
vim.cmd[[let g:mapleader = ","]]

vim.cmd[[set clipboard=unnamed]]

-- Expand tabs into spaces
vim.o.expandtab = true

-- Set the number of spaces for each level of indentation
vim.o.shiftwidth = 4

-- Round indent to the nearest multiple of 'shiftwidth'
vim.o.shiftround = true

-- Set auto-indentation based on the previous line
vim.o.autoindent = true

-- Allow backspacing over indent, end-of-line, and start of insert
vim.o.backspace = "indent,eol,start"

-- Set the number of lines to keep above and below the cursor when scrolling
vim.o.scrolloff = 10

-- Prevent a carriage return at the end of the last line
vim.o.noeol = true

-- Don't insert two spaces after sentence joins
vim.o.nojoinspaces = true

-- Highlight search matches
vim.o.hlsearch = true

-- Ignore case when searching, unless an uppercase letter is used
vim.o.ignorecase = true
vim.o.smartcase = true

-- Highlight the current line
vim.wo.cursorline = true

-- Show the replacement in action
vim.o.inccommand = "nosplit"

-- Show whitespace characters
vim.o.listchars = "tab:>·,trail:.,extends:>,precedes:<"
vim.o.list = true

-- Show the matching closing punctuation
vim.o.showmatch = true

-- Speed up jump to matching bracket
vim.o.matchtime = 1

-- Don't abandon unloaded buffers, hide them instead
vim.o.hidden = true

-- Set the file format to Unix-style line endings
vim.o.fileformats = "unix"

-- Auto-write the file if modified on exit
vim.o.autowrite = true

-- Auto-load the file if it changes elsewhere
vim.o.autoread = true

-- Disable backup files
vim.o.backup = false

-- Disable swap files
vim.o.swapfile = false

-- Highlight conflict markers
vim.cmd([[match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$']])

-- Center search
vim.cmd([[
cnoremap <expr> <CR> getcmdtype() == '/' ? '<CR>zz' : '<CR>'
]])

local servers = { "pyright", "tsserver" }

require("mason").setup()

require("mason-lspconfig").setup {
    ensure_installed = servers
}

-- Global mappings.

-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

vim.keymap.set('n', '<leader>f', ':FzfLua files<CR>', {noremap = true})
vim.keymap.set('n', '<leader>a', ':FzfLua grep<CR>', {noremap = true})

vim.keymap.set('n', '<leader>w', ':w<CR>', {noremap = true})
vim.keymap.set('n', '<leader>q', ':q<CR>', {noremap = true})
vim.keymap.set('n', '<bs>', ':nohlsearch<CR>', {noremap = true})

-- Window Navigation
vim.keymap.set('n', '<C-j>', '<C-W>j', {noremap = true})
vim.keymap.set('n', '<C-k>', '<C-W>k', {noremap = true})
vim.keymap.set('n', '<C-h>', '<C-W>h', {noremap = true})
vim.keymap.set('n', '<C-l>', '<C-W>l', {noremap = true})

-- Refresh buffer
vim.keymap.set('n', '<leader>r', ':e %<CR>', {noremap = true})

-- Centre when scrolling
vim.api.nvim_set_keymap('n', '<C-f>', '<C-f>zz', {})
vim.api.nvim_set_keymap('n', '<C-b>', '<C-b>zz', {})

-- Put result in centre of window when jumping between search results
vim.api.nvim_set_keymap('n', 'n', 'nzz', {})
vim.api.nvim_set_keymap('n', 'N', 'Nzz', {})


-- Tab commands
vim.api.nvim_set_keymap('n', '<leader>te', ':tabedit <c-r>=expand("%:p:h")<cr>/', {})
vim.api.nvim_set_keymap('n', '<leader>to', ':tabonly<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>tc', ':tabclose<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>tm', ':tabmove<space>', {})
vim.api.nvim_set_keymap('n', '<leader>tn', ':tabnew<cr>', {})

-- Left/right tab
vim.api.nvim_set_keymap('n', 'H', 'gT', {})
vim.api.nvim_set_keymap('n', 'L', 'gt', {})

-- Enter to enter space
vim.api.nvim_set_keymap('n', '<enter>', 'o<ESC>', {})

vim.api.nvim_set_keymap('n', '<leader>p', ':let @*=expand("%:.")<CR>', {})

-- Search codebase for word under cursor (v useful)
vim.api.nvim_set_keymap('n', 'gw', ':FzfLua grep_cWORD<CR>', {})

-- Open splits
vim.api.nvim_set_keymap('n', '<leader>v', ':botright vsplit<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>x', ':botright split<CR>', {})

-- Window Navigation:
vim.api.nvim_set_keymap('n', '<C-j>', '<C-W>j', {})
vim.api.nvim_set_keymap('n', '<C-k>', '<C-W>k', {})
vim.api.nvim_set_keymap('n', '<C-h>', '<C-W>h', {})
vim.api.nvim_set_keymap('n', '<C-l>', '<C-W>l', {})


-- Language server

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
            -- Enable completion triggered by <c-x><c-o>
            vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

            -- Buffer local mappings.
            -- See `:help vim.lsp.*` for documentation on any of the below functions
            local opts = { buffer = ev.buf }
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
            vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
            vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
            vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
            vim.keymap.set('n', '<space>wl', function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, opts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
        end, opts)
end,
})

-- Autocomplete

local cmp = require'cmp'
local lspkind = require('lspkind')

cmp.setup({
        formatting = {
            fields = { "kind", "abbr", "menu" },
            format = function(entry, vim_item)
                local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
                local strings = vim.split(kind.kind, "%s", { trimempty = true })
                kind.kind = " " .. (strings[1] or "") .. " "
                kind.menu = "    (" .. (strings[2] or "") .. ")"

                return kind
            end,
        },
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
            completion = {
                winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
                col_offset = -3,
                side_padding = 0,
            },
        },
        view = {
            entries = {name = 'custom', selection_order = 'near_cursor' } -- https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#custom-menu-direction
        },
        mapping = cmp.mapping.preset.insert({
                -- ['<TAB>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                -- ['<TAB>'] = cmp.mapping.complete(),
                ['<C-a>'] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping({
                        i = function(fallback)
                            if cmp.visible() and cmp.get_active_entry() then
                                cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                            else
                                fallback()
                            end
                        end,
                        s = cmp.mapping.confirm({ select = true }),
                        c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
                    }),
            }),
        sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                -- { name = 'vsnip' }, -- For vsnip users.
                -- { name = 'luasnip' }, -- For luasnip users.
                -- { name = 'ultisnips' }, -- For ultisnips users.
                -- { name = 'snippy' }, -- For snippy users.
            }, {
                { name = 'buffer' },
            })
    })

-- Set up lspconfig.
local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        capabilities = capabilities,
    }
    lspconfig.pylsp.setup {
    on_attach = function(client)
        if string.match(vim.api.nvim_buf_get_name(0), "/site-packages/") then
        return
        end
        if string.match(vim.api.nvim_buf_get_name(0), "/lib/python") then
        return
        end
        require("lsp-format").on_attach(client)
    end,
    settings = {
        pylsp = {
        plugins = {
            noy_pyls = { enabled = true },
            pydocstyle = { enabled = false },
            pycodestyle = { enabled = false },
            pyflakes = { enabled = false },
            flake8 = { enabled = true },
            mccabe = { enabled = false },
            pylint = { enabled = true },
            yapf = { enabled = false },
            pyls_isort = { enabled = true },
            black = { enabled = true, line_length = 88 },
            pylsp_mypy = { enabled = true, dmypy = true, live_mode = false }
        }
        }
    },
    flags = {
        debounce_text_changes = 200,
    }
    }
end

-- Format on save
vim.cmd([[autocmd BufWritePre * lua vim.lsp.buf.format()]])

require("lsp_lines").setup()
-- Disable virtual_text since it's redundant due to lsp_lines.
vim.diagnostic.config({
        virtual_text = false,
    })
vim.keymap.set(
    "",
    "<Leader>l",
    require("lsp_lines").toggle,
    { desc = "Toggle lsp_lines" }
    )

require('gitsigns').setup{
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
        end, {expr=true})

    map('n', '[c', function()
        if vim.wo.diff then return '[c' end
        vim.schedule(function() gs.prev_hunk() end)
        return '<Ignore>'
    end, {expr=true})

-- Actions
map('n', '<leader>hs', gs.stage_hunk)
map('n', '<leader>hr', gs.reset_hunk)
map('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line("."), vim.fn.line("v")} end)
map('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line("."), vim.fn.line("v")} end)
map('n', '<leader>hS', gs.stage_buffer)
map('n', '<leader>hu', gs.undo_stage_hunk)
map('n', '<leader>hR', gs.reset_buffer)
map('n', '<leader>hp', gs.preview_hunk)
map('n', '<leader>hb', function() gs.blame_line{full=true} end)
map('n', '<leader>tb', gs.toggle_current_line_blame)
map('n', '<leader>hd', gs.diffthis)
map('n', '<leader>hD', function() gs.diffthis('~') end)
map('n', '<leader>td', gs.toggle_deleted)

-- Text object
map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
}


require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = false,
    disable = {},
  },
  ensure_installed = {
    "python",
    "tsx",
    "toml",
    "json",
    "yaml",
    "html",
    "scss",
    "lua",
  },
}


-- https://codeinthehole.com/tips/vim-and-github-copilot/
vim.g.copilot_filetypes = {
    gitcommit = true,
    markdown = true,
    yaml = true
}

-- Gina
vim.keymap.set('n', '<leader>gs', ':Gina status -s<cr>', {noremap = true})
vim.keymap.set('n', '<leader>gc', ':Gina compare<cr>', {noremap = true})
vim.keymap.set('n', '<leader>gd', ':Gina diff<cr>', {noremap = true})
vim.keymap.set('n', '<leader>gl', ':Gina log<cr>', {noremap = true})


-- Create a function to populate the quickfix list with old files
function PopulateOldFilesQuickfix()
  local oldfiles = vim.fn.split(vim.fn.execute('oldfiles'), '\n')
  oldfiles = vim.tbl_filter(function(val) return val ~= '' end, oldfiles)

  local processed_files = {}
  for _, file in ipairs(oldfiles) do
    local processed_file = string.gsub(file, '^%s*%d+:%s*', '')
    table.insert(processed_files, processed_file)
  end

  -- Create a quickfix list with old files
  vim.fn.setqflist(vim.tbl_map(function(val)
    return {
      filename = val,
      lnum = 1,
      text = val
    }
  end, processed_files))

  -- Open the quickfix window
  vim.cmd(':FzfLua quickfix')
end

-- Map a key to populate the quickfix list with old files
vim.api.nvim_set_keymap('n', '<leader>h', '<cmd>lua PopulateOldFilesQuickfix()<CR>', { noremap = true })
