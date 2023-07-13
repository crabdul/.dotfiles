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
        'L3MON4D3/LuaSnip',
    }
    use { 'junegunn/fzf.vim' }
    use { 'junegunn/fzf' }
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
    use 'wellle/targets.vim'
    use 'bkad/CamelCaseMotion'
    use 'machakann/vim-sandwich'
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

-- Keep undo history between sessions
if vim.fn.has('persistent_undo') then
    vim.o.undofile = true
    vim.o.undodir = vim.fn.expand('$HOME') .. '/.vim_undo'
    vim.o.undolevels = 2000
end

vim.api.nvim_set_keymap('n', 'gb', "`[v`]y<C-O>", {noremap = true})

-- Declare lines from end of file just for vim
-- This allows the folding setting to be read
vim.o.modelines = 1

-- Ignore specific directories
vim.o.wildignore = vim.o.wildignore .. '**/node_modules/**,**/__pycache__/**'

-- Errors
vim.o.errorbells = false
vim.o.visualbell = false
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
vim.o.eol = false

-- Don't insert two spaces after sentence joins
vim.o.joinspaces = false

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
-- vim.api.nvim_set_keymap('n', 'H', 'gT', {})
-- vim.api.nvim_set_keymap('n', 'L', 'gt', {})
-- https://github.com/romgrk/barbar.nvim#mappings--commands
vim.api.nvim_set_keymap('n', 'H', ':BufferPrevious<CR>', { silent = true })
vim.api.nvim_set_keymap('n', 'L', ':BufferNext<CR>', { silent = true })

-- Enter to enter space
vim.api.nvim_set_keymap('n', '<enter>', 'o<ESC>', {})

vim.api.nvim_set_keymap('n', '<leader>p', ':let @*=expand("%:.")<CR>', {})

-- Open splits
vim.api.nvim_set_keymap('n', '<leader>v', ':botright vsplit<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>x', ':botright split<CR>', {})

-- Window Navigation:
vim.api.nvim_set_keymap('n', '<C-j>', '<C-W>j', {})
vim.api.nvim_set_keymap('n', '<C-k>', '<C-W>k', {})
vim.api.nvim_set_keymap('n', '<C-h>', '<C-W>h', {})
vim.api.nvim_set_keymap('n', '<C-l>', '<C-W>l', {})

-- Map <leader>/ to perform a global search and replace using the current word
vim.api.nvim_set_keymap('n', '<leader>/', [[:%s:<C-r>=expand("<cword>")<CR>::g<Left><Left>]], { noremap = true })

-- Map <leader>; to perform a search and replace using the current word
vim.api.nvim_set_keymap('n', '<leader>;', [[:%s:<C-r>=expand("<cword>")<CR>:\<C-r>=expand("<cword>")<CR>:g<Left><Left>]], { noremap = true })

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
            vim.keymap.set('n', '<C-s>', vim.lsp.buf.signature_help, opts)
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
                -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
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


                ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
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
vim.cmd([[autocmd BufWritePre *.py,*.ts,*.tsx lua vim.lsp.buf.format()]])

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


vim.cmd([[
 autocmd BufReadPre *
     \ let f=getfsize(expand("<afile>"))
     \ | if f > 100000 || f == -2
     \ | let b:copilot_enabled = v:false
     \ | endif
]])


-- Gina
vim.keymap.set('n', '<leader>gs', ':Gina status -s<cr>', {silent = true})
vim.keymap.set('n', '<leader>gc', ':Gina compare<cr>', {noremap = true})
vim.keymap.set('n', '<leader>gd', ':Gina diff<cr>', {noremap = true})
vim.keymap.set('n', '<leader>gl', ':Gina log<cr>', {noremap = true})

vim.api.nvim_set_keymap('n', 'W', '<Plug>CamelCaseMotion_w', {silent = true})
vim.api.nvim_set_keymap('n', 'B', '<Plug>CamelCaseMotion_b', {silent = true})
vim.api.nvim_set_keymap('n', 'E', '<Plug>CamelCaseMotion_e', {silent = true})
vim.api.nvim_set_keymap('n', 'gE', '<Plug>CamelCaseMotion_ge', {silent = true})

vim.api.nvim_set_keymap('o', 'iW', '<Plug>CamelCaseMotion_iw', {silent = true})
vim.api.nvim_set_keymap('x', 'iW', '<Plug>CamelCaseMotion_iw', {silent = true})
vim.api.nvim_set_keymap('o', 'iB', '<Plug>CamelCaseMotion_ib', {silent = true})
vim.api.nvim_set_keymap('x', 'iB', '<Plug>CamelCaseMotion_ib', {silent = true})
vim.api.nvim_set_keymap('o', 'iE', '<Plug>CamelCaseMotion_ie', {silent = true})
vim.api.nvim_set_keymap('x', 'iE', '<Plug>CamelCaseMotion_ie', {silent = true})

-- Status line
vim.opt.fillchars = { stl = "─", stlnc = "─" }
vim.opt.statusline = "%F%=%3l:%-2c%=%m"
vim.cmd("hi StatusLine guifg=#C51162")

function UnitTestModuleFilepath(filepath)
    local path_segments = vim.split(filepath, "/")
    local filename = path_segments[#path_segments]:gsub("^_", "")
    return "tests/unit/common/" .. table.concat(vim.list_slice(path_segments, 2, -2), "/") .. "/test_" .. filename
end

function ApplicationModuleFilepath(filepath)
    local path_segments = vim.split(filepath, "/")
    local index = vim.fn.index(path_segments, "tests")
    local filename = path_segments[#path_segments]:gsub("^test_", "")
    return "octoenergy/" .. table.concat(vim.list_slice(path_segments, index + 2, -2), "/") .. "/" .. filename
end

function ComplementaryFilepath(filepath)
    if vim.fn.match(filepath, "tests/") ~= -1 then
        return ApplicationModuleFilepath(filepath)
    else
        return UnitTestModuleFilepath(filepath)
    end
end

function PyTestOptions(filepath)
    local test_cases = {
        ['tests/unit/territories/jpn/plugins/territories/jpn'] = "--ds=tests.settings --dc=OEJPInterfaceAgnostic",
        ['tests/unit/clients/oejp'] = "--ds=tests.settings --dc=OEJPInterfaceAgnostic",
        ['tests/integration/territories/jpn'] = "--ds=tests.settings --dc=OEJPInterfaceAgnostic",
        ['tests/integration/clients/oejp'] = "--ds=tests.settings --dc=OEJPInterfaceAgnostic",
        ['tests/functional/commands/territories/jpn'] = "--ds=tests.settings --dc=OEJPManagementCommand",
        ['tests/functional/commands/clients/oejp'] = "--ds=tests.settings --dc=OEJPManagementCommand",
        ['tests/functional/tasks/territories/jpn'] = "--ds=tests.settings --dc=OEJPWorker",
        ['tests/functional/apisite/territories/jpn'] = "--ds=tests.settings --dc=OEJPAPISite",
        ['tests/functional/supportsite/territories/jpn'] = "--ds=tests.settings --dc=OEJPSupportSite",
        ['tests/functional/webhooksite/territories/jpn'] = "--ds=tests.settings --dc=OEJPWebhookSite",
        ['tests/functional/supportsite/common'] = "--ds=tests.settings --dc=OctoEnergySupportSite"
    }

    for pattern, options in pairs(test_cases) do
        if filepath:match(pattern) then
            return options
        end
    end

    return ""
end

function RunMostRecentTest()
    local current_file = vim.fn.expand("%")
    local test_module, test_function

    if current_file ~= "" then
        vim.cmd("wall")
        if current_file:match("test_.*%.py$") then
            test_module = current_file
            test_function = vim.fn.expand("<cword>")
        else
            local unit_test_filepath = UnitTestModuleFilepath(current_file)
            if vim.fn.filereadable(unit_test_filepath) then
                test_module = unit_test_filepath
            end
        end
    end

    if not test_module then
        print("Don't know which test module to run!")
    elseif not test_function then
        print("Don't know which test function to run!")
    else
        local test_options = PyTestOptions(test_module)
        vim.cmd("silent !clear")
        print("Running " .. test_function .. " from " .. test_module .. " ...")
        local cmd = "py.test -s " .. test_options .. " " .. test_module .. " -k " .. test_function .. " -v -ss"
        vim.cmd("!tmux send -l -t 2 " .. vim.fn.shellescape(cmd))
    end
end

function RunMostRecentTestModule()
    local current_file = vim.fn.expand("%")
    local test_module

    if current_file ~= "" then
        vim.cmd("wall")
        if current_file:match("test_.*%.py$") then
            test_module = current_file
        else
            local unit_test_filepath = UnitTestModuleFilepath(current_file)
            if vim.fn.filereadable(unit_test_filepath) then
                test_module = unit_test_filepath
            end
        end
    end

    if not test_module then
        print("Don't know which test module to run!")
    else
        local test_options = PyTestOptions(test_module)
        vim.cmd("silent !clear")
        print("Running tests from " .. test_module .. " ...")
        local cmd = "py.test " .. test_options .. " " .. test_module
        vim.cmd("!tmux send -t 2 " .. vim.fn.shellescape(cmd))
    end
end

-- Mappings
vim.api.nvim_set_keymap("n", "<leader>u", ":lua RunMostRecentTest()<cr>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>U", ":lua RunMostRecentTestModule()<cr>", { silent = true })


vim.cmd([[
  augroup MyAbbreviations
    autocmd!
    autocmd FileType python inoreabbrev pd import ipdb; ipdb.set_trace()
  augroup END
]])


vim.cmd([[autocmd BufNewFile * lua vim.cmd(":exe ': !mkdir -p ' . escape(fnamemodify(bufname('%'),':p:h'),'#% \\')")]])


function TranslateHelper()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local line = vim.api.nvim_get_current_line()
  local col = cursor[2]
  local translation = vim.fn.input('Enter the translation text: ')

  -- Check if cursor is inside an HTML tag
  local tag_pattern = "<([%w:]+)"
  local tag_match = string.match(line, tag_pattern, col)
  if tag_match then
    local tag_start = string.find(line, tag_match, col)
    local tag_end = string.find(line, ">", tag_start)
    if tag_end then
      local tag_text = string.sub(line, tag_start, tag_end)
      local translated_tag = string.gsub(tag_text, ">(.-)<", ">" .. translation .. "<")
      local translated_line = string.sub(line, 1, tag_start - 1) .. translated_tag .. string.sub(line, tag_end + 1)
      vim.api.nvim_set_current_line(translated_line)
      print('Translation replaced inside HTML tag.')
      return
    end
  end

  -- Check if cursor is within double quotes
  local quote_pattern = [["([^"]*)"]]
  local quote_match = string.match(line, quote_pattern, col)
  if quote_match then
    local quote_start = string.find(line, quote_match, col)
    local quote_end = string.find(line, quote_match, quote_start + 1)
    if quote_end then
      local translated_line = string.sub(line, 1, quote_start - 1) .. translation .. string.sub(line, quote_end + 1)
      vim.api.nvim_set_current_line(translated_line)
      print('Translation replaced within double quotes.')
      return
    end
  end

  -- Insert translation template at cursor position
  local translation_template = "{% translation '" .. translation .. "' %}"
  vim.api.nvim_put({translation_template}, "c", true, true)
end

vim.cmd('command! Tr lua TranslateHelper()')

vim.cmd([[
autocmd FileType html lua vim.bo.filetype = 'htmldjango'
autocmd FileType htmldjango inoremap {{ {{  }}<left><left><left>
autocmd FileType htmldjango inoremap {% {%  %}<left><left><left>
autocmd FileType htmldjango inoremap {# {#  #}<left><left><left>
]])


function SourceInitLua()
  local home_dir = vim.loop.os_homedir()
  local init_lua = home_dir .. '/.config/nvim/init.lua'

  -- Source the init.lua file
  local success, error_msg = pcall(vim.cmd, 'luafile ' .. init_lua)

  if success then
    print('init.lua sourced successfully.')
  else
    print('Error sourcing init.lua:', error_msg)
  end
end

vim.cmd('command! SourceInitLua lua SourceInitLua()')


vim.api.nvim_set_keymap('n', '<leader>a', ':Rg<space>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>f', ':Files<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>b', ':Buffers<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>h', ':History<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>l', ':BLines<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>s', ':Tags<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>d', ':Files <C-R>=expand(\'%:p:h\') . \'/\'<CR><CR>', {noremap = true})
vim.api.nvim_set_keymap('n', 'gw', ':Rg <C-R><C-W><CR>', {noremap = true})

function _G.list_buffers()
    local list = vim.fn.execute('silent ls')
    return vim.split(list, "\n")
end

function _G.delete_buffers(lines)
    vim.cmd('bwipeout ' .. table.concat(vim.tbl_map(function(line) return vim.split(line, ' ')[1] end, lines), ' '))
end

vim.cmd([[command! -nargs=0 Fzfc call fzf#run(fzf#wrap({'source': 'git ls-files --exclude-standard --others --modified'}))]])
vim.api.nvim_set_keymap('n', '<Leader>c', ':Fzfc<cr>', {noremap = true})

vim.cmd([[command! -nargs=0 BD call fzf#run(fzf#wrap({
            \ 'source': luaeval('list_buffers()'),
            \ 'sink*': luaeval('delete_buffers(v:lua._fzf_lines)'),
            \ 'options': '--multi --reverse --bind ctrl-a:select-all+accept'
            \ }))]])

vim.g.fzf_action = {
    ['ctrl-t'] = 'tab split',
    ['ctrl-x'] = 'split',
    ['ctrl-v'] = 'vsplit'
}

vim.g.fzf_buffers_jump = 1

vim.g.fzf_colors = {
    fg = {'fg', 'Normal'},
    bg = {'bg', 'Normal'},
    hl = {'fg', 'Comment'},
    ['fg+'] = {'fg', 'CursorLine', 'CursorColumn', 'Normal'},
    ['bg+'] = {'bg', 'CursorLine', 'CursorColumn'},
    ['hl+'] = {'fg', 'Statement'},
    info = {'fg', 'PreProc'},
    border = {'fg', 'Ignore'},
    prompt = {'fg', 'Conditional'},
    pointer = {'fg', 'Exception'},
    marker = {'fg', 'Keyword'},
    spinner = {'fg', 'Label'},
    header = {'fg', 'Comment'}
}

vim.cmd([[command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>,
            \ fzf#vim#with_preview('right:30%', 'ctrl-p'), <bang>0)]])

-- vim.cmd([[autocmd WinEnter * lua WindowMaximiseHorizontally()]])

-- https://github.com/ibhagwan/fzf-lua/wiki/Advanced#explore-changes-from-a-git-branch
vim.api.nvim_create_user_command(
  'ListFilesFromBranch',
  function(opts)
    require 'fzf-lua'.files({
      cmd = "git ls-tree -r --name-only " .. opts.args,
      prompt = opts.args .. "> ",
      actions = {
        ['default'] = false,
        ['ctrl-s'] = false,
        ['ctrl-v'] = function(selected, o)
          local file = require'fzf-lua'.path.entry_to_file(selected[1], o)
          local cmd = string.format("Gvsplit %s:%s", opts.args, file.path)
          vim.cmd(cmd)
        end,
      },
      previewer = false,
      preview = require'fzf-lua'.shell.raw_preview_action_cmd(function(items)
        local file = require'fzf-lua'.path.entry_to_file(items[1])
        return string.format("git diff %s HEAD -- %s | delta", opts.args, file.path)
      end)
    })
  end,
  {
    nargs = 1,
    force = true,
    complete = function()
      local branches = vim.fn.systemlist("git branch --all --sort=-committerdate")
      if vim.v.shell_error == 0 then
        return vim.tbl_map(function(x)
          return x:match("[^%s%*]+"):gsub("^remotes/", "")
        end, branches)
      end
    end,
  })


-- -- https://github.com/ibhagwan/fzf-lua/wiki/Advanced#prioritize-cwd-when-using-git_files
-- -- The reason I added  'opts' as a parameter is so you can
-- -- call this function with your own parameters / customizations
-- -- for example: 'git_files_cwd_aware({ cwd = <another git repo> })'
-- function M.git_files_cwd_aware(opts)
--   opts = opts or {}
--   local fzf_lua = require('fzf-lua')
--   -- git_root() will warn us if we're not inside a git repo
--   -- so we don't have to add another warning here, if
--   -- you want to avoid the error message change it to:
--   -- local git_root = fzf_lua.path.git_root(opts, true)
--   local git_root = fzf_lua.path.git_root(opts)
--   if not git_root then return end
--   local relative = fzf_lua.path.relative(vim.loop.cwd(), git_root)
--   opts.fzf_opts = { ['--query'] = git_root ~= relative and relative or nil }
--   return fzf_lua.git_files(opts)
-- end


