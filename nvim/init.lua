-- Options ---------------------------------------------------------------------
local options = {
        -- General
        backup = false,
        swapfile = false,
        smartindent = true,
        encoding = 'utf-8',
        autoread = true,
        hidden = true,
        clipboard = 'unnamedplus',
        mouse = 'a',
        timeoutlen = 300,:warning
        updatetime = 100,
        -- Directory
        autochdir = true,
        -- Appearance
        termguicolors = true,
        title = true,
        number = true,
        cursorline = true,
        signcolumn = 'yes',
        belloff = 'all',
        conceallevel = 0,
        -- Editing
        wrap = false,
        splitbelow = false,
        splitright = false,
        expandtab = true,
        tabstop = 2,
        -- Searching
        ignorecase = true,
}
for k, v in pairs(options) do
        vim.opt[k] = v
end
vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.g.vim_json_syntax_conceal = 0

-- Autocommands ----------------------------------------------------------------
vim.cmd('autocmd!')
-- Auto reload init.lua when its updated
local autocmd = vim.api.nvim_create_autocmd
autocmd('BufWritePost', {
        pattern = '*init.lua',
        command = 'source ~/.config/nvim/init.lua'
})

-- Disable auto commenting
autocmd("BufEnter", {
        pattern = "*",
        command = "set fo-=c fo-=r fo-=o",
})

-- Restore cursor position when read buffer
autocmd({ "BufReadPost" }, {
        pattern = { "*" },
        callback = function()
                vim.api.nvim_exec('silent! normal! g`"zv', false)
        end,
})

-- Auto save & restore current session
vim.cmd([[
    fu! SaveSess()
        execute 'mksession! ~/.config/nvim/session.vim'
    endfunction

    fu! RestoreSess()
    if !empty(glob('~/.config/nvim/session.vim'))
        execute 'so ~/.config/nvim/session.vim'
    endif
    endfunction

    autocmd VimLeave * call SaveSess()
    autocmd VimEnter * nested call RestoreSess()
]])

-- Keybindings ---------------------------------------------------------------------
local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- Commands aliases
keymap('n', '@@', ':wqa<CR>', opts)
keymap('n', '!!', ':qa!<CR>', opts)

-- Leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- jj & nn => ESC
keymap('i', 'jj', '<ESC>', opts)
keymap('v', 'nn', '<ESC>', opts)

-- j & k => Move ignoring wrapping
keymap('n', 'j', 'gj', { noremap = true })
keymap('n', 'k', 'gk', { noremap = true })

-- 1 line scrolling
keymap('n', '<S-k>', '<C-y>', { noremap = true })
keymap('n', '<S-j>', '<C-e>', { noremap = true })
keymap('v', '<S-k>', '<C-y>', { noremap = true })
keymap('v', '<S-j>', '<C-e>', { noremap = true })

-- Home / End
keymap('n', '-', '$', { noremap = true })
keymap('n', '_', '0', { noremap = true })
keymap('v', '-', '$', { noremap = true })
keymap('v', '_', '0', { noremap = true })

-- Jump to previous word's head/end
keymap('n', '<S-w>', 'b', { noremap = true })
keymap('n', '<S-e>', 'ge', { noremap = true })
keymap('v', '<S-w>', 'b', { noremap = true })
keymap('v', '<S-e>', 'ge', { noremap = true })

-- Toggle buffer
keymap('n', '<C-h>', ':bprevious<CR>', { noremap = true })
keymap('n', '<C-l>', ':bnext<CR>', { noremap = true })
keymap('n', '<C-w>', ':Bdelete<CR>', { noremap = true })

-- Split window
keymap('n', 'fu', '<C-w>s<C-w>j', opts)
keymap('n', 'fi', '<C-w>v<C-w>l', opts)

-- Move current window
keymap('n', 'fh', '<C-w>h', opts)
keymap('n', 'fj', '<C-w>j', opts)
keymap('n', 'fk', '<C-w>k', opts)
keymap('n', 'fl', '<C-w>l', opts)

-- Move current window position
keymap('n', 'fH', '<C-w>H', opts)
keymap('n', 'fJ', '<C-w>J', opts)
keymap('n', 'fK', '<C-w>K', opts)
keymap('n', 'fL', '<C-w>L', opts)

-- Change current window size
keymap('n', 'f>', '<C-w>>', opts)
keymap('n', 'f<', '<C-w><', opts)
keymap('n', 'f-', '<C-w>-', opts)
keymap('n', 'f=', '<C-w>=', opts)
keymap('n', 'f|', '<C-w>|', opts)

-- Close current window
keymap('n', 'fx', '<C-w>c', opts)

-- Function to toggle window size between nomal to max
vim.cmd([[
    let g:toggle_window_size = 0
    function! ToggleWindowSize()
    if g:toggle_window_size == 1
        exec "normal f="
        let g:toggle_window_size = 0
    else
        :resize
        :vertical resize
        let g:toggle_window_size = 1
    endif
    endfunction
    nnoremap <silent> fz :call ToggleWindowSize()<CR>
]])

-- Release highlighting of searching
keymap('n', '<ESC><ESC>', ':nohlsearch<CR>', { noremap = true })

-- Fold/Open
keymap('v', 'zf', 'zf', opts) -- Create fold
keymap('n', 'zk', 'zc', opts) -- Fold
keymap('n', 'zj', 'zo', opts) -- Open
keymap('n', 'zJ', 'zO', opts) -- Open all depth
keymap('n', 'zh', 'zm', opts) -- Fold all folds in file
keymap('n', 'zH', 'zM', opts) -- Fold all folds (all depth) in file
keymap('n', 'zl', 'zr', opts) -- Open all folds in file
keymap('n', 'zL', 'zR', opts) -- Open all folds (all depth) in file

-- Plugins ---------------------------------------------------------------------
-- Plugins' keybindings
-- Toggles
keymap('n', '<C-o>', ':NvimTreeToggle<CR>', { noremap = true })
keymap('n', '<C-j>', ':ToggleTerm<CR>', { noremap = true })
keymap('n', 'tm', ':MinimapToggle<CR>', opts)
keymap('n', 'ts', ':SymbolsOutline<CR>', opts)
keymap('n', 'tr', ':WinResizerStartResize<CR>', opts)

keymap('n', 'mm', ':MakeTable!<CR>', opts)
keymap('n', 'mu', ':UnmakeTable<CR>', opts)
keymap('n', 'mo', ':Toc<CR>', opts)
keymap('n', 'mO', ':Toc!<CR>', opts)
keymap('n', 'mp', ':MarkdownPreview<CR>', opts)
keymap('n', 'mt', ':TableModeToggle<CR>', opts)

-- FZF
keymap('n', 'rf', ':Telescope find_files<CR>', opts)
keymap('n', 'rb', ':Telescope buffers<CR>', opts)
keymap('n', 'rg', ':Telescope live_grep<CR>', opts)
keymap('n', 'rh', ':Telescope oldfiles<CR>', opts)
keymap('n', 'rm', ':Telescope keymaps<CR>', opts)
keymap('n', '<C-p>', ':Telescope commands<CR>', { noremap = true })

-- LSP
keymap('n', '<F12>', '<cmd>lua vim.lsp.buf.hover()<CR>', { noremap = true })
keymap('n', 'gf', '<cmd>lua vim.lsp.buf.format()<CR>', opts)
keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true })
keymap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<CR>', { noremap = true })
keymap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
keymap('n', 'gn', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
keymap('n', 'gN', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
keymap('n', 'gd', ':TroubleToggle<CR>', opts)

-- Git
keymap('n', 'gss', ':Gitsigns stage_hunk<CR>', opts)
keymap('n', 'gsu', ':Gitsigns undo_stage_hunk<CR>', opts)
keymap('n', 'gsr', ':Gitsigns reset_hunk<CR>', opts)
keymap('n', 'gsd', ':Gitsigns diffthis<CR>', opts)
keymap('n', 'gsp', ':Gitsigns preview_hunk<CR>', opts)
keymap('n', 'gsB', ':Gitsigns toggle_current_line_blame<CR>', opts)
keymap('n', 'gsn', ':Gitsigns next_hunk<CR>', opts)
keymap('n', 'gsN', ':Gitsigns prev_hunk<CR>', opts)

-- todo-comments.nvim
keymap('n', 'cc', ':TodoLocList cwd=./<CR>', opts)
keymap('n', 'ct', ':TodoTrouble cwd=./<CR>', opts)

vim.cmd([[packadd packer.nvim]])
local ensure_packer = function()
        local fn = vim.fn
        local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
        if fn.empty(fn.glob(install_path)) > 0 then
                fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
                vim.cmd [[packadd packer.nvim]]
                return true
        end
        return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
        -- Packer
        use { 'wbthomason/packer.nvim' }

        -- Utilities
        use { 'echasnovski/mini.nvim' }
        use { 'kyazdani42/nvim-tree.lua',
                requires = { 'nvim-tree/nvim-web-devicons' } }
        use { 'nvim-tree/nvim-web-devicons' }
        use { 'simeji/winresizer' }
        use { 'akinsho/toggleterm.nvim' }
        use { 'goolord/alpha-nvim',
                requires = { 'nvim-tree/nvim-web-devicons' } }
        use { 'folke/which-key.nvim' }
        use { 'petertriho/nvim-scrollbar' }
        use { 'kevinhwang91/nvim-hlslens' }
        use { 'tpope/vim-surround' }
        use { 'folke/todo-comments.nvim' }
        use { 'nvim-lua/plenary.nvim' }
        use { 'nvim-treesitter/nvim-treesitter',
                run = ':TSUpdate' }
        use { 'yioneko/nvim-yati',
                requires = 'nvim-treesitter/nvim-treesitter'}
        use { 'famiu/bufdelete.nvim' }
        use { 'voldikss/vim-translator' }
        use { 'psliwka/vim-smoothie' }
        use { 'nvim-telescope/telescope.nvim', tag = '0.1.0',
                requires = { { 'nvim-lua/plenary.nvim' } } }
        use { 'BurntSushi/ripgrep' }

        -- LSP & snippets
        use { 'neovim/nvim-lspconfig' }
        use { 'williamboman/mason.nvim' }
        use { 'williamboman/mason-lspconfig.nvim' }
        use { 'hrsh7th/nvim-cmp' }
        use { 'hrsh7th/cmp-nvim-lsp' }
        use { 'hrsh7th/cmp-buffer' }
        use { 'hrsh7th/cmp-path' }
        use { 'hrsh7th/cmp-cmdline' }
        use { 'hrsh7th/cmp-vsnip' }
        use { 'hrsh7th/vim-vsnip' }
        use { 'rafamadriz/friendly-snippets' }
        use { 'onsails/lspkind.nvim' }
        use { 'ray-x/lsp_signature.nvim' }
        use { 'folke/trouble.nvim' }
        use { 'simrat39/symbols-outline.nvim'}

        -- Appealance
        use { 'lilydjwg/colorizer' }
        use { 'lukas-reineke/indent-blankline.nvim' }
        use { 'p00f/nvim-ts-rainbow' }
        use { 'rcarriga/nvim-notify' }
        use { 'MunifTanjim/nui.nvim' }
        use { 'folke/noice.nvim' }
        use { 'nvim-treesitter/nvim-treesitter-context' }

        -- for Markdown
        use { 'preservim/vim-markdown' }
        use { 'dhruvasagar/vim-table-mode' }
        use { 'mattn/vim-maketable' }
        use({ 'iamcco/markdown-preview.nvim',
                run = function() vim.fn["mkdp#util#install"]() end, })
        -- for html
        use { 'alvan/vim-closetag' }
        -- for JSON
        use { 'elzr/vim-json' }
        -- for Dockerfile
        use { 'ekalinin/Dockerfile.vim' }
        -- for CSV
        use { 'mechatroner/rainbow_csv' }

        -- Colorscheme
        use { 'folke/tokyonight.nvim' }
        use { 'crusoexia/vim-monokai' }

        -- Git
        use { 'lewis6991/gitsigns.nvim' }

        if packer_bootstrap then
                require('packer').sync()
        end
end)

-- Plugins' settings -----------------------------------------------------------

-- Colorscheme
vim.cmd([[colorscheme tokyonight-storm]])

-- alpha-nvim
-- require('alpha').setup(require 'alpha.themes.startify'.config)
require('alpha').setup(require 'alpha.themes.startify'.config)

-- gitsigns.nvim
require('gitsigns').setup({
        signs = {
                add          = { hl = 'GitSignsAdd', text = '', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
                change       = { hl = 'GitSignsChange', text = '', numhl = 'GitSignsChangeNr',
                        linehl = 'GitSignsChangeLn' },
                delete       = { hl = 'GitSignsDelete', text = '', numhl = 'GitSignsDeleteNr',
                        linehl = 'GitSignsDeleteLn' },
                topdelete    = { hl = 'GitSignsDelete', text = '', numhl = 'GitSignsDeleteNr',
                        linehl = 'GitSignsDeleteLn' },
                changedelete = { hl = 'GitSignsChange', text = '', numhl = 'GitSignsChangeNr',
                        linehl = 'GitSignsChangeLn' },
        },
})

-- indent-blankline.nvim
vim.opt.list = true
require("indent_blankline").setup({
        context_patterns = {
                "body", "class", "function", "method", "block", "list_literal", "selector",
                "^if", "^table", "if_statement", "while", "for", "type", "var",
                "import", "declaration", "expression", "pattern", "primary_expression",
                "statement", "switch_body"
        },
        space_char_blankline = " ",
        show_end_of_line = true,
        show_current_context = true,
        show_current_context_start = true,
})

-- LSP & snippets
-- mason
require('mason').setup()
require('mason-lspconfig').setup_handlers({ function(server)
        local opt = {
                capabilities = require('cmp_nvim_lsp').default_capabilities(
                        vim.lsp.protocol.make_client_capabilities()
                )
        }
        require('lspconfig')[server].setup(opt)
end })
require'lspconfig'.sumneko_lua.setup {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
}
-- cmp
local cmp = require 'cmp'
cmp.setup({
        snippet = {
                expand = function(args)
                        vim.fn["vsnip#anonymous"](args.body)
                end,
        },
        window = {},
        mapping = cmp.mapping.preset.insert({
                ["<S-TAB>"] = cmp.mapping.select_prev_item(),
                ["<TAB>"] = cmp.mapping.select_next_item(),
                ['<C-l>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm { select = true },
        }),
        sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'buffer' },
                { name = 'path' },
                -- { name = 'cmp_tabnine' },
                { name = 'vsnip' },
                { name = 'friendly-snippets' },
        }),
        formatting = {
                fields = { "kind", "abbr", "menu" },
                max_width = 0,
                kind_icons = {
                        Class = " ",
                        Color = " ",
                        Constant = "ﲀ ",
                        Constructor = " ",
                        Enum = "練",
                        EnumMember = " ",
                        Event = " ",
                        Field = " ",
                        File = "",
                        Folder = " ",
                        Function = " ",
                        Interface = "ﰮ ",
                        Keyword = " ",
                        Method = " ",
                        Module = " ",
                        Operator = "",
                        Property = " ",
                        Reference = " ",
                        Snippet = " ",
                        Struct = " ",
                        Text = " ",
                        TypeParameter = " ",
                        Unit = "塞",
                        Value = " ",
                        Variable = " ",
                },
        },
})
cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
                { name = 'buffer' }
        }
})
cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
                { name = 'path' }
        }, {
                { name = 'cmdline' }
        })
})
local lspkind = require('lspkind')
cmp.setup {
        formatting = {
                format = lspkind.cmp_format({
                        mode = 'symbol',
                        maxwidth = 50,
                        ellipsis_char = '...',
                })
        }
}
-- lsp_signature
require('lsp_signature').setup({})
-- trouble
require('trouble').setup({})
-- diagnostics signs
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
-- mini.nvim
require('mini.comment').setup()
require('mini.cursorword').setup()
vim.cmd([[
        highlight MiniCursorword gui=nocombine guibg=#444444
        highlight! MiniCursorwordCurrent gui=nocombine guifg=NONE guibg=NONE
            ]])
require('mini.statusline').setup()
require('mini.tabline').setup()
require('mini.pairs').setup()
require('mini.trailspace').setup()
vim.cmd 'highlight MiniTrailspace guibg=Red'

-- nvim-tree.lua
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1
require('nvim-tree').setup({
        sort_by = "name",
        update_focused_file = {
                enable = true,
                update_root = true,
        },
        view = {
                adaptive_size = false,
                width = 40,
                mappings = {
                        list = {
                                { key = "I", action = "toggle_dotfiles" },
                                { key = "u", action = "dir_up" },
                                { key = "h", action = "close_node" },
                                { key = "l", action = "edit" },
                                { key = "r", action = "refresh" },
                                { key = "R", action = "rename" },
                                { key = "D", action = "remove" },
                                { key = "X", action = "cut" },
                                { key = "Y", action = "copy" },
                                { key = "P", action = "paste" },
                                { key = "A", action = "create" },
                                { key = "c", action = "" },
                                { key = "d", action = "" },
                                { key = "f", action = "" },
                                { key = "p", action = "" },
                        },
                },
        },
        diagnostics = {
                enable = true,
                show_on_dirs = false,
                icons = {
                        hint = "",
                        info = "",
                        warning = "",
                        error = "",
                },
        },
        renderer = {
                group_empty = true,
                indent_markers = {
                        enable = true,
                        inline_arrows = true,
                        icons = {
                                corner = "└",
                                edge = "│",
                                item = "│",
                                bottom = "─",
                                none = " ",
                        },
                },
                icons = {
                        padding = " ",
                        git_placement = "after",
                        show = {
                                folder_arrow = true,
                        },
                        glyphs = {
                                default = "",
                                symlink = "",
                                git = {
                                        unstaged = "",
                                        staged = "S",
                                        unmerged = "",
                                        renamed = "➜",
                                        deleted = "",
                                        untracked = "U",
                                        ignored = "◌",
                                },
                                folder = {
                                        default = "",
                                        open = "",
                                        empty = "",
                                        empty_open = "",
                                        symlink = "",
                                },
                        },
                },
        },
        filters = {
                dotfiles = true,
        },
})

-- nvim-treesitter
require('nvim-treesitter.configs').setup({
        ensure_installed = { 'markdown', 'python', 'javascript', 'html', 'css', 'bash', 'lua', 'vim', 'c' },
        yati = { enable = true },
        auto_install = true,
        highlight = { enable = true, },
        rainbow = { enable = true, extended_mode = true, max_file_lines = 999,
                colors = { "#5f87d7", "#af87ff", "#00af87" }
        }
})

-- nvim-scrollbar
local colors = require('tokyonight.colors').setup()
require('scrollbar').setup({
        handle = {
                color = colors.black,
        },
        marks = {
                Search = { color = colors.green },
                Error = { color = colors.error },
                Warn = { color = colors.warning },
                Info = { color = colors.info },
                Hint = { color = colors.hint },
                Misc = { color = colors.purple },
        }
})
require('scrollbar.handlers.search').setup()

-- noice.nvim
require('noice').setup()

-- symbols-outline.nvim
require('symbols-outline').setup({
        keymaps = {
                close = { "<Esc>", "q" },
                goto_location = "<Cr>",
                focus_location = "o",
                hover_symbol = "i",
                toggle_preview = "p",
                rename_symbol = "<F2>",
                fold = "h",
                unfold = "l",
                fold_all = "H",
                unfold_all = "L",
                fold_reset = "R",
        },
})

-- todo-comments
require('todo-comments').setup()

-- toggleterm.nvim
require('toggleterm').setup({ direction = 'float', })
vim.cmd([[
autocmd TermEnter term://*toggleterm#*
      \ tnoremap <silent><c-j> <Cmd>exe v:count1 . "ToggleTerm"<CR>
]])

-- vim-markdown
vim.g.vim_markdown_folding_disabled = 1
vim.g.vim_markdown_conceal = 0
vim.g.vim_markdown_conceal_code_blocks = 0
vim.g.vim_markdown_toc_autofit = 1

-- vim-smoothie
keymap('n', '<C-d>', '<cmd>call smoothie#do("<C-D>")<CR>', { noremap = true })
keymap('n', '<C-u>', '<cmd>call smoothie#do("<C-U>")<CR>', { noremap = true })
keymap('v', '<C-d>', '<cmd>call smoothie#do("<C-D>")<CR>', { noremap = true })
keymap('v', '<C-u>', '<cmd>call smoothie#do("<C-U>")<CR>', { noremap = true })

-- vim-table_mode
vim.g.table_mode_enable = 1

-- vim-translator
vim.g.translator_target_lang = 'ja'

-- which-key.nvim
require('which-key').setup({
        ignore_missing = true,
        window = {
                border = 'single',
                position = 'bottom',
                margin = { 1, 0, 1, 0 },
                padding = { 2, 2, 2, 2 },
                winblend = 0,
        },
        layout = {
                spacing = 8,
                align = 'center'
        },
})
local wk = require('which-key')
wk.register(
        {
                M = { '<cmd>Alpha<CR>', 'goto Main menu' },
                r = {
                        name = '+Find',
                        b = { '<cmd>Telescope buffers<CR>', 'Buffer lines (rb)' },
                        c = { '<cmd>Telescope colorscheme<CR>', 'Color schemes' },
                        C = { '<cmd>Telescope commands<CR>', 'Commands (<C-p>)' },
                        f = { '<cmd>Telescope find_files<CR>', 'Files (rf)' },
                        h = { '<cmd>Telescope oldfiles<CR>', 'Recently used files (rh)' },
                        n = { '<cmd>Telescope keymaps<CR>', 'Key mappings in nomalmode (rm)' },
                        H = { '<cmd>Telescope command_history<CR>', 'Command histories' },
                        r = { '<cmd>Telescope live_grep<CR>', 'Text (rg)' },
                },
                g = {
                        name = '+LSP',
                        d = { '<cmd>TroubleToggle<CR>', 'Diagnostics list (gd)' },
                        D = { '<cmdlua vim.lsp.buf.definition()><CR>', 'Definition (<C-k>)' },
                        f = { '<cmd>lua vim.lsp.buf.format { async = true }<CR>', 'Document formatting (gf)' },
                        h = { '<cmd>lua vim.lsp.buf.hover()<CR>', 'Hover information (<F12>)' },
                        l = { '<cmd>lua vim.diagnostic.open_float()<CR>', 'Diagnostics detailes (gl)' },
                        n = { '<cmd>lua vim.diagnostic.goto_next()<CR>', 'Next diagnostics (gn)' },
                        N = { '<cmd>lua vim.diagnostic.goto_prev()<CR>', 'Prev diagnostics (gN)' },
                        r = { '<cmd>lua vim.lsp.buf.references()<CR>', 'References list (gr)' },
                        R = { '<cmd>lua vim.lsp.buf.rename()<CR>', 'Rename (<F2>)' },
                        m = { '<cmd>Mason<CR>', 'LSP manager' },
                },
                G = {
                        name = '+Git',
                        s = { '<cmd>Gitsigns stage_hunk<CR>', 'Stage changes (gss)' },
                        u = { '<cmd>Gitsigns undo_stage_hunk<CR>', 'Unstage changes (gsu)' },
                        r = { '<cmd>Gitsigns reset_hunk<CR>', 'Reset changes (gsr)' },
                        d = { '<cmd>Gitsigns diffthis<CR>', 'Difftool (gsd)' },
                        p = { '<cmd>Gitsigns preview_hunk<CR>', 'Preview diff (gsp)' },
                        B = { '<cmd>Gitsigns toggle_current_line_blame<CR>', 'Toggle current line blame (gsB)' },
                        n = { '<cmd>Gitsigns next_hunk<CR>', 'Jump to next hunk (gsn)' },
                        N = { '<cmd>Gitsigns prev_hunk<CR>', 'Jump to preview hunk (gsN)' },
                },
                t = {
                        name = '+Toggles',
                        m = { '<cmd>MinimapToggle<CR>', 'Minimap (tm)' },
                        n = { '<cmd>NvimTreeToggle<CR>', 'NvimTree (<C-o>)' },
                        p = { '<cmd>TagbarToggle<CR>', 'Tagbar (tp)' },
                        s = { '<cmd>SymbolsOutline<CR>', 'Symbols list (ts)' },
                        r = { '<cmd>WinResizerStartResize<CR>', 'WinRisezier (tr)' },
                },
                c = {
                        name = '+Comments',
                        c = { '<cmd>TodoLocList cwd=./<CR>', 'Comments in CWD (cc)' },
                        t = { '<cmd>TodoTrouble cwd=./<CR>', 'Comments in Trouble (ct)' },
                },
                m = {
                        name = '+Markdown',
                        m = { '<cmd>MakeTable!<CR>', 'Make markdown table from CSV (mm)' },
                        u = { '<cmd>UnmakeTable<CR>', 'Make CSV from markdown table (mu)' },
                        t = { '<cmd>TablemodeToggle<CR>', 'Tablemode toggle (mt)' },
                        o = { '<cmd>Toc<CR>', 'TOC (mo)' },
                        O = { '<cmd>Toch<CR>', 'TOC with horizontal (mO)' },
                        p = { '<cmd>MarkdownPreview<CR>', 'Preview markdown in browser (mp)' },
                },
                z = {
                        name = '+Fold/Open',
                        f = { 'zf', 'create Fold (zf)' },
                        d = { 'zd', 'delete All fold (zd)' },
                        k = { 'zk', 'Collapse (zk)' },
                        j = { 'zj', 'Open (zj)' },
                        J = { 'zJ', 'Open all (zJ)' },
                        h = { 'zh', 'Collapse / file (zh)' },
                        H = { 'zH', 'Collapse all / file (zH)' },
                        l = { 'zl', 'Open / file (zl)' },
                        L = { 'zL', 'Open all / file (zL)' },
                },
        },
        { prefix = '<leader>' }
)
