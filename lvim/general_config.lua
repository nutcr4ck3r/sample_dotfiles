-- general
lvim.log.level = "warn"
lvim.format_on_save = false
lvim.colorscheme = "tokyonight"
vim.cmd("autocmd!")
vim.cmd([[
if has("autocmd")
  augroup saveposition    " to save the last cursor position.
    " When editing a file, always jump to the last cursor position
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
  augroup END
endif
]])

-- Individual settings for each file types
-- for markdown
vim.cmd([[
augroup markdown
  autocmd Filetype markdown setlocal nowrap
  autocmd Filetype markdown set spelllang=
augroup END
]])

-- Keybindings
-- General
vim.cmd([[
  inoremap <silent> jj <ESC>
  vnoremap <silent> nn <ESC>
]])

-- for Window splitting/moving
lvim.keys.normal_mode["fu"] = "<C-w>s"
lvim.keys.normal_mode["fi"] = "<C-w>v"
lvim.keys.normal_mode["fh"] = "<C-w>h"
lvim.keys.normal_mode["fj"] = "<C-w>j"
lvim.keys.normal_mode["fk"] = "<C-w>k"
lvim.keys.normal_mode["fl"] = "<C-w>l"
lvim.keys.normal_mode["fH"] = "<C-w>H"
lvim.keys.normal_mode["fJ"] = "<C-w>J"
lvim.keys.normal_mode["fK"] = "<C-w>K"
lvim.keys.normal_mode["fL"] = "<C-w>L"
lvim.keys.normal_mode["f."] = "<C-w>>"
lvim.keys.normal_mode["f,"] = "<C-w><"
lvim.keys.normal_mode["f-"] = "<C-w>_"
lvim.keys.normal_mode["f="] = "<C-w>="
lvim.keys.normal_mode["f\\"] = "<C-w>|"
lvim.keys.normal_mode["fx"] = "<C-w>c"

-- for Fold/Open
lvim.keys.visual_mode["zf"] = "zf"
lvim.keys.normal_mode["zk"] = "zc"
lvim.keys.normal_mode["zj"] = "zo"
lvim.keys.normal_mode["zJ"] = "zO"
lvim.keys.normal_mode["zh"] = "zm"
lvim.keys.normal_mode["zH"] = "zM"
lvim.keys.normal_mode["zl"] = "zr"
lvim.keys.normal_mode["zL"] = "zR"
-- vim.cmd([[
-- " for folding status saving
-- autocmd BufWritePost * if expand('%') != '' && &buftype !~ 'nofile' | mkview | endif
-- autocmd BufRead * if expand('%') != '' && &buftype !~ 'nofile' | silent loadview | endif
-- set viewoptions-=options
-- ]])

-- Function to toggle window size between normal to max.
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
-- Change background color at 80-characters
vim.cmd([[
  execute "set colorcolumn=" . join(range(81, 9999), ',')
  highlight ColorColumn guibg=#202020 ctermbg=black
]])
-- Cursor moving
lvim.keys.normal_mode["<S-k>"] = "<C-y>"
lvim.keys.normal_mode["<S-j>"] = "<C-e>"
lvim.keys.normal_mode["0"] = "$"
lvim.keys.normal_mode["`"] = "0"
lvim.keys.normal_mode["W"] = "b"
lvim.keys.visual_mode["W"] = "b"
lvim.keys.normal_mode["E"] = "ge"
lvim.keys.visual_mode["E"] = "ge"
lvim.keys.normal_mode["<Esc><Esc>"] = ":nohlsearch<CR>"

-- Buffer control
lvim.keys.normal_mode["<C-w>"] = ":bdelete<CR>"
lvim.keys.normal_mode["<C-l>"] = ":bnext<CR>"
lvim.keys.normal_mode["<C-h>"] = ":bprevious<CR>"

-- Toggle switches
lvim.keys.normal_mode["<C-o>"] = ":NvimTreeToggle<CR>"
lvim.keys.normal_mode["<C-j>"] = ":ToggleTerm<CR>"
lvim.keys.normal_mode["tt"] = ":TableModeToggle<CR>"
lvim.keys.normal_mode["tr"] = ":WinResizerStartResize<CR>"
lvim.keys.normal_mode["tm"] = ":MinimapToggle<CR>"
lvim.keys.normal_mode["rf"] = ":Telescope find_files<CR>"
lvim.keys.normal_mode["rg"] = ":Telescope live_grep<CR>"
lvim.keys.normal_mode["rh"] = ":Telescope oldfiles<CR>"

-- Lsp controls
-- If you set keybindings on this file,
-- please modify "lua/lvim/lsp/config.lua" too
lvim.keys.normal_mode["<F12>"] = vim.lsp.buf.hover
lvim.keys.normal_mode["<F2>"] = vim.lsp.buf.rename
lvim.keys.normal_mode["<C-k>"] = vim.lsp.buf.definition
lvim.keys.normal_mode["gr"] = vim.lsp.buf.references
lvim.keys.normal_mode["gd"] = ":Telescope diagnostics bufnr=0 theme=get_ivy<cr>"
lvim.keys.normal_mode["gn"] = vim.diagnostic.goto_next
lvim.keys.normal_mode["gN"] = vim.diagnostic.goto_prev

-- Settings for uiltin plugins
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- Core plugins
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "html",
  "rust",
  "java",
  "yaml",
  "markdown",
  "vim",
}

-- treesitter settings
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- Additional Plugins
lvim.plugins = {
  -- Colorscheme
  { "folke/tokyonight.nvim" },
  { "crusoexia/vim-monokai" },
  -- Appearance tweak
  { "lukas-reineke/indent-blankline.nvim" },
  { "p00f/nvim-ts-rainbow" },
  { "wfxr/minimap.vim" },
  -- { "yggdroot/hipairs" },
  -- Utilities
  { "simeji/winresizer" },
  { "tpope/vim-surround" },
  { "norcalli/nvim-colorizer.lua" },
  -- Spellcheck etc
  { "bronson/vim-trailing-whitespace" },
  -- for Markdown
  { "previm/previm" },
  { "tyru/open-browser.vim" },
  { "dhruvasagar/vim-table-mode" },
  { "mattn/vim-maketable" },
  { "preservim/vim-markdown" },
  -- for HTML
  { "windwp/nvim-ts-autotag" },
  -- others
  { "folke/trouble.nvim",
    cmd = "TroubleToggle" },
}

-- Plugin's settings
-- for winresizer
vim.g.winresizer_start_key = '<C-`>'
-- for indent-blankline
vim.opt.listchars:append "eol:↴"
require("indent_blankline").setup {
  show_current_context = true,
  show_current_context_start = true,
}

-- for nvim-colorizer.lua
require("colorizer").setup {
  '*';
  '!markdown';
}

-- for nvim-ts-autotag
require("nvim-ts-autotag").setup()

-- for nvim-ts-rainbow
lvim.builtin.treesitter.rainbow.enable = true

-- for vim-markdown
vim.g.vim_markdown_folding_disabled = 1
vim.g.vim_markdown_conceal = 0
vim.g.vim_markdown_conceal_code_blockes = 0
vim.g.vim_markdown_toc_autofit = 1

-- for previm
vim.g.previm_enable_realtime = 0

-- for minimap.vim
vim.g.minimap_width = 10
vim.g.minimap_auto_start = 0
vim.g.minimap_auto_start_win_enter = 1

-- for hipairs
vim.cmd([[let g:hiPairs_hl_matchPair = {'gui': 'bold', 'guifg': 'White', 'guibg': 'Black'}]])

-- Plugin's shortcuts
-- Install Language server => :LspInstall
-- Rename variable names => <leader> lr
-- View hover informations => <S-k>
-- Jump to a definition => LspDefinition (Shortcut: Ctrl+k)
-- Open NERDtree => NERDTreeToggle (Shortcut:Ctrl+o)
--   Toggle hidden files showing => shift+i
--   Reload a tree => r
-- Toggle comment out
--   for block = gc, for a line = gcc
-- Preview a markdown file => :PrevimOpen
-- Show Toc on a markdown file
--   on Vertical => :Toc (f -> o) , on Horizontal => :Toch
-- vim-table-mode
--   Toggle table mode :TableModeToggle (Ctrl+t)
-- Make markdown table from csv syntax
--   Make table => Select lines and :MakeTable
--   Make table with top index => Select lines and :MakeTable!
--   Make CSV from markdown table => :UnmakeTable
-- Vim-Surround
--   Surround with `...` => Select word in visual mode and press S -> `
--   Delete surround `...` => press ds -> ` at inner words in `...`
--   Change surround from `...` to (...) => press cs`( at inner words in `...`
-- Win-Resizer
--   Into Resize-mode: Ctrl + e
--   Change mode: e, End any-mode: enter

vim.cmd([[

" Smooth scroll
let s:stop_time = 10

function! s:down(timer) abort
  execute "normal! 3\<C-e>3j"
endfunction

function! s:up(timer) abort
  execute "normal! 3\<C-y>3k"
endfunction

function! s:smooth_scroll(fn) abort
  let working_timer = get(s:, 'smooth_scroll_timer', 0)
  if !empty(timer_info(working_timer))
    call timer_stop(working_timer)
  endif
  if (a:fn ==# 'down' && line('$') == line('w$')) ||
        \ (a:fn ==# 'up' && line('w0') == 1)
    return
  endif
  let s:smooth_scroll_timer = timer_start(s:stop_time, function('s:' . a:fn), {'repeat' : &scroll/6})
endfunction

nnoremap <silent> <C-u> <cmd>call <SID>smooth_scroll('up')<CR>
nnoremap <silent> <C-d> <cmd>call <SID>smooth_scroll('down')<CR>
vnoremap <silent> <C-u> <cmd>call <SID>smooth_scroll('up')<CR>
vnoremap <silent> <C-d> <cmd>call <SID>smooth_scroll('down')<CR>
]])
