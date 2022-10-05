" ------------------------------------------------------------------------------
" General settings
" ------------------------------------------------------------------------------
set nobackup              " Not create backup file.
set noswapfile            " Not create swapfile.
set smartindent           " Use smart indent.
set fenc=utf-8            " Use UFT-8
set autoread              " Reload file automatically when editing file was modify.
set hidden                " Enable to open other file when editing buffer.
set clipboard=unnamed     " Ebable allignment to clipboard.
set belloff=all           " Disable beep.
set timeoutlen=300        " Timeout time untill key input.
set updatetime=100        " Set update time for gitgutter sign updating
set signcolumn=yes        " Always show a sign column to show lsp signs
set mouse=a               " Enable mouse controls in nomal, visual, insert and command mode.

" ------------------------------------------------------------------------------
" Modified functions
" ------------------------------------------------------------------------------
autocmd!
" to load init.vim automaticaly when change it.
augroup vimrc
 au BufWritePost *init.vim source ~/.config/nvim/init.vim
augroup END
if has("autocmd")
  augroup saveposition    " to save the last cursor position.
    " When editing a file, always jump to the last cursor position
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
  augroup END
endif

" Save and restore folding states
fu! SaveFoldings()
  mkview 1
endfunction
fu! LoadFoldings()
  silent! loadview 1
endfunction
augroup remember_folds
  au BufWinLeave call SaveFoldings()
  au BufWinEnter call LoadFoldings()
augroup END

" Save and restore session automatically
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

" Smooth scrolling
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
  let s:smooth_scroll_timer = timer_start(s:stop_time, function('s:' . a:fn), {'repeat' : &scroll/3})
endfunction

nnoremap <silent> <C-u> <cmd>call <SID>smooth_scroll('up')<CR>
nnoremap <silent> <C-d> <cmd>call <SID>smooth_scroll('down')<CR>
vnoremap <silent> <C-u> <cmd>call <SID>smooth_scroll('up')<CR>
vnoremap <silent> <C-d> <cmd>call <SID>smooth_scroll('down')<CR>

" ------------------------------------------------------------------------------
" Custom Keybind
" ------------------------------------------------------------------------------
" Enable jj key for exit insert mode.
inoremap <silent> jj <ESC>
vnoremap <silent> nn <ESC>
" Can move between line head to end.
nnoremap j gj
nnoremap k gk

" 1 line scrolling
nnoremap <S-k> <C-y>
nnoremap <S-j> <C-e>
vnoremap <S-k> <C-y>
vnoremap <S-j> <C-e>

" Home / End
nnoremap - $
nnoremap _ 0
vnoremap - $
vnoremap _ 0

" Jump to previous word's head/end.
nnoremap <S-w> b
nnoremap <S-e> ge
vnoremap <S-w> b
vnoremap <S-e> ge

" Toggle buffer
nnoremap <C-h> :bprevious<CR>
nnoremap <C-l> :bnext<CR>
nnoremap <C-w> :bdelete<CR>

" Split window
nnoremap <silent> fu <C-w>s<C-w>j
nnoremap <silent> fi <C-w>v<C-w>l

" Change current window
nnoremap <silent> fh <C-w>h
nnoremap <silent> fj <C-w>j
nnoremap <silent> fk <C-w>k
nnoremap <silent> fl <C-w>l

" Move current window position
nnoremap <silent> fH <C-w>H
nnoremap <silent> fJ <C-w>J
nnoremap <silent> fK <C-w>K
nnoremap <silent> fL <C-w>L

" Change current window size
nnoremap <silent> f. <C-w>>
nnoremap <silent> f, <C-w><
nnoremap <silent> f- <C-w>_
nnoremap <silent> f= <C-w>=
nnoremap <silent> f\ <C-w>|

" Function to toggle window size between normal to max.
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

" Close current window
nnoremap <silent> fx <C-w>c

" Release hilight search strings when continuous input ESC.
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" Fold/Open
vnoremap <silent> zf zf
nnoremap <silent> zk zc
nnoremap <silent> zj zo
nnoremap <silent> zJ zO
nnoremap <silent> zh zm
nnoremap <silent> zH zM
nnoremap <silent> zl zr
nnoremap <silent> zL zR

" ------------------------------------------------------------------------------
" Input settings
" ------------------------------------------------------------------------------
set whichwrap=b,s,h,l,<,>,[,]   " Cursol can move between line end to line head.
set backspace=indent,eol,start  " Enable backspace.
set shiftwidth=2                " Change indent to space.
set wildmode=list:longest       " Complement file name when input command.

" ------------------------------------------------------------------------------
" Appearance settings
" ------------------------------------------------------------------------------
set t_Co=256                           " Enable 256 colors.
set cursorline                         " Hilight current line.
set nowrap                             " Disable line wrap.
syntax enable                          " Enable syntax hilight.

" Display line numbers.
set number
autocmd ColorScheme * highlight LineNr ctermfg=8 ctermbg=235

" Display double quotation in json file.
set conceallevel=0
let g:vim_json_syntax_conceal = 0

" Disable hilight pairs brackets.
let loaded_matchparen = 1

" ------------------------------------------------------------------------------
" Tab's number settings
" ------------------------------------------------------------------------------
set list listchars=tab:\?\-  " Tab are displayed as symbols.
set expandtab                " Modify tab to space.
set tabstop=2                " Set number of tabs (at line top).

" ------------------------------------------------------------------------------
" Search settings
" ------------------------------------------------------------------------------
set ignorecase  " Ignore case sensitivity when search strings is lower case.
set incsearch   " Enable live search.
set wrapscan    " Go file head when search is arrive at EOF
set hlsearch    " Hilight search strings.

" ------------------------------------------------------------------------------
" vim-plug
" ------------------------------------------------------------------------------
call plug#begin()
" utilities
  Plug 'echasnovski/mini.nvim'
  Plug 'kyazdani42/nvim-tree.lua'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'simeji/winresizer'
  Plug 'akinsho/toggleterm.nvim'
  Plug 'mhinz/vim-startify'
  Plug 'folke/which-key.nvim'
  Plug 'Xuyuanp/scrollbar.nvim'
  Plug 'tpope/vim-surround'
" for using LSP and snippets
  Plug 'neovim/nvim-lspconfig'
  Plug 'williamboman/mason.nvim'
  Plug 'williamboman/mason-lspconfig.nvim'
  Plug 'hrsh7th/vim-vsnip'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-vsnip'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'rafamadriz/friendly-snippets'
  Plug 'onsails/lspkind.nvim'
  Plug 'ray-x/lsp_signature.nvim'
  Plug 'folke/trouble.nvim'
" for automation
  Plug 'ConradIrwin/vim-bracketed-paste'
  Plug 'tpope/vim-repeat'
" for appearance
  Plug 'wfxr/minimap.vim'
  Plug 'lilydjwg/colorizer'
  Plug 'lukas-reineke/indent-blankline.nvim'
  Plug 'p00f/nvim-ts-rainbow'
" for searching and tags
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'majutsushi/tagbar'
  Plug 'szw/vim-tags'
" for Git
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'
" for markdown editing
  Plug 'preservim/vim-markdown'
  Plug 'dhruvasagar/vim-table-mode'
  Plug 'mattn/vim-maketable'
  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
" for HTML
  Plug 'alvan/vim-closetag'
" for JSON
  Plug 'elzr/vim-json'
" for Dockerfile
  Plug 'ekalinin/Dockerfile.vim'
" for Syntax hilight
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'mechatroner/rainbow_csv'
" Color schemes
  Plug 'crusoexia/vim-monokai'
  Plug 'ghifarit53/tokyonight-vim'
  Plug 'joshdick/onedark.vim'
  Plug 'arcticicestudio/nord-vim'
  Plug 'wadackel/vim-dogrun'
  Plug 'tomasiser/vim-code-dark'
  Plug 'romgrk/doom-one.vim'
  Plug 'jonathanfilip/vim-lucius'
  Plug 'beikome/cosme.vim'
  Plug 'gmoe/vim-espresso'
call plug#end()

" Plugin's keybind
" Toggles
nnoremap <C-o> :NvimTreeToggle<CR>
nnoremap <silent> tm :MinimapToggle<CR>
nnoremap <silent> tp :TagbarToggle<CR>
nnoremap <silent> tr :WinResizerStartResize<CR>

nnoremap <silent> mm :MakeTable!<CR>
nnoremap <silent> mu :UnmakeTable<CR>
nnoremap <silent> mo :Toc<CR>
nnoremap <silent> mO :Toc!<CR>
nnoremap <silent> mp :MarkdownPreview<CR>
nnoremap <silent> mt :TableModeToggle<CR>

" FZF
nnoremap <silent> rf :Files<CR>
nnoremap <silent> rb :BLines<CR>
nnoremap <silent> rg :Rg<CR>
nnoremap <silent> rh :History<CR>

" LSP
lua vim.keymap.set('n', '<F12>',  '<cmd>lua vim.lsp.buf.hover()<CR>')
lua vim.keymap.set('n', 'gf', '<cmd>lua vim.lsp.buf.formatting()<CR>')
lua vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
lua vim.keymap.set('n', '<C-k>', '<cmd>lua vim.lsp.buf.definition()<CR>')
lua vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<CR>')
lua vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<CR>')
lua vim.keymap.set('n', 'gn', '<cmd>lua vim.diagnostic.goto_next()<CR>')
lua vim.keymap.set('n', 'gN', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
lua vim.keymap.set('n', 'gd', ':TroubleToggle<CR>')

" gitgutter
nnoremap <silent> gh :GitGutterNextHunk<CR>
nnoremap <silent> gH :GitGutterPrevHunk<CR>

" Plugin configurations
" for winresizer
let g:winresizer_start_key = '<C-`>'

" for vim-table_mode
let g:table_mode_enable = 1

" for python-syntax
let g:python_highlight_all = 1

" for vim-closetag
let g:closetag_filenames = '*.html, *.htm, *.js'
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum" " Font color
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum" " Background color

" for vim-markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_toc_autofit = 1

" for scrollbar.nvim
augroup ScrollbarInit
  autocmd WinScrolled,VimResized,QuitPre * silent! lua require('scrollbar').show()
  autocmd WinEnter,FocusGained           * silent! lua require('scrollbar').show()
  autocmd WinLeave,BufLeave,BufWinLeave,FocusLost            * silent! lua require('scrollbar').clear()
augroup end

" for toggleterm
lua require('toggleterm').setup({direction = 'float',})
autocmd TermEnter term://*toggleterm#*
      \ tnoremap <silent><c-j> <Cmd>exe v:count1 . "ToggleTerm"<CR>
nnoremap <C-j> :ToggleTerm<CR>

" for mini.nvim
lua require('mini.comment').setup()
lua require('mini.cursorword').setup()
highlight MiniCursorword gui=nocombine guibg=#444444
highlight! MiniCursorwordCurrent gui=nocombine guifg=NONE guibg=NONE
lua require('mini.pairs').setup()
lua require('mini.statusline').setup()
lua require('mini.tabline').setup()
lua require('mini.trailspace').setup()
highlight MiniTrailspace guibg=Red

" for vim-tags
if has("mac")
  let Tlist_Ctags_Cmd = "/usr/local/bin/ctags"
elseif has("unix")
  let Tlist_Ctags_Cmd = "/usr/bin/ctags"
endif
let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Use_Right_Window = 1

" for minimap.vim
let g:minimap_width = 10
let g:minimap_auto_start = 0
let g:minimap_auto_start_win_enter = 1
let g:minimap_highlight_range = 0
let g:minimap_highlight_search = 1
let g:minimap_git_colors = 1

" for vim-gitgutter
set signcolumn=yes:2
let g:gitgutter_sign_added = ''
let g:gitgutter_sign_modified = ''
let g:gitgutter_sign_removed = ''
let g:gitgutter_sign_removed_first_line = ''
let g:gitgutter_sign_modified_removed = ''

" for tree-sitter
lua << EOF
require('nvim-treesitter.configs').setup({
      ensure_installed = { 'python', 'javascript', 'html', 'css', 'bash', 'lua', 'vim', 'c' },
      auto_install = true,
      highlight = {enable = true,},
      rainbow = {enable = true, extended_mode = true, max_file_lines = 999,
      colors = { "#5f87d7", "#af87ff", "#00af87"}
      }
    })
EOF

" for indent-blankline.nvim
lua vim.opt.list = true
lua << EOF
require("indent_blankline").setup({
         context_patterns = {
          "body", "class", "function", "method", "block", "list_literal", "selector",
          "^if", "^table", "if_statement", "while", "for",  "type", "var",
          "import", "declaration", "expression", "pattern", "primary_expression",
          "statement", "switch_body"
        },
          space_char_blankline = " ",
          show_end_of_line = true,
          show_current_context = true,
          show_current_context_start = true,
      })
EOF

" for nvim-tree
let g:loaded = 1
let g:loaded_netrwPlugin = 1
lua << EOF
require('nvim-tree').setup({
        sort_by = "name",
        update_focused_file = {
          enable = true,
          update_root = true,
        },
        view = {
          adaptive_size = true,
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
EOF

" for LSP & autocompletion
lua << EOF
-- mason
require('mason').setup()
require('mason-lspconfig').setup_handlers({ function(server)
         local opt = {
           capabilities = require('cmp_nvim_lsp').update_capabilities(
             vim.lsp.protocol.make_client_capabilities()
           )
         }
         require('lspconfig')[server].setup(opt)
      end})
-- cmp
local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  window = {
  },
  mapping = cmp.mapping.preset.insert({
    ["<S-TAB>"] = cmp.mapping.select_prev_item(),
    ["<TAB>"] = cmp.mapping.select_next_item(),
    ['<C-l>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm { select = true },
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'buffer' },
    { name = 'path' },
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
    source_names = {
      nvim_lsp = "(LSP)",
      emoji = "(Emoji)",
      path = "(Path)",
      calc = "(Calc)",
      cmp_tabnine = "(Tabnine)",
      vsnip = "(Snippet)",
      luasnip = "(Snippet)",
      buffer = "(Buffer)",
      tmux = "(TMUX)",
    },
    duplicates = {
      buffer = 1,
      path = 1,
      nvim_lsp = 0,
      luasnip = 1,
    },
    duplicates_default = 0,
  },
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
EOF

" for startify
let g:startify_files_number = 5
let g:startify_custom_header = [
\'┌───────────────────────────────────────────────┐',
\'│                                               │',
\'│                   - V I M -                   │',
\'│                                               │',
\'│                 "Vi IMproved"                 │',
\'│                                               │',
\"│ Simplicity's the most valuable thing in life. │",
\'│                                               │',
\'│        There is NOT substitute for it.        │',
\'│                                               │',
\'└───────────────────────────────────────────────┘',
\]
let g:startify_list_order = [
        \ ['♻  Recently used files:'],
        \ 'files',
        \ ['♲  Recently used files (Current directory):'],
        \ 'dir',
        \ ['⚑  Sessions:'],
        \ 'sessions',
        \ ['☺  Bookmarks:'],
        \ 'bookmarks',
        \ ]
let g:startify_bookmarks = ["~/.config/nvim/init.vim"]

" for which-key.nim
let g:mapleader = "\<Space>"
lua << EOF
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
    M = { '<cmd>Startify<CR>', 'goto Main menu' },
    f = { '<cmd>Files<CR>', 'find Files' },
    h = { '<cmd>History<CR>', 'find Histories' },
    r = {
      name = '+Find',
      b = { '<cmd>BLines<CR>', 'Buffer lines (rb)' },
      c = { '<cmd>Colors<CR>', 'Color schemes' },
      C = { '<cmd>Commands<CR>', 'Commands' },
      f = { '<cmd>Files<CR>', 'Files (rf)' },
      h = { '<cmd>History<CR>', 'Recently used files (rh)' },
      k = { '<cmd>Maps<CR>', 'Key mappings in nomalmode' },
      H = { '<cmd>History:<CR>', 'Command histories' },
      r = { '<cmd>Rg<CR>', 'Text (rg)' },
      },
    g = {
      name = '+LSP',
      d = { '<cmd>TroubleToggle<CR>', 'Diagnostics list (gd)' },
      D = { '<cmdlua vim.lsp.buf.definition()><CR>', 'Definition (<C-k>)' },
      f = { '<cmd>lua vim.lsp.buf.formatting()<CR>', 'Document formatting (gf)' },
      h = { '<cmd>lua vim.lsp.buf.hover()<CR>', 'Hover information (<F12>)' },
      l = { '<cmd>lua vim.diagnostic.open_float()<CR>', 'Diagnostics detailes (gl)' },
      n = { '<cmd>lua vim.diagnostic.goto_next()<CR>', 'Next diagnostics (gn)' },
      N = { '<cmd>lua vim.diagnostic.goto_prev()<CR>', 'Prev diagnostics (gN)' },
      r = { '<cmd>lua vim.lsp.buf.references()<CR>', 'References list (gr)' },
      R = { '<cmd><CR>', 'Rename (<F2>)' },
      m = { '<cmd>Mason<CR>', 'LSP manager' },
      },
    t = {
      name = '+Toggles',
      m = { '<cmd>MinimapToggle<CR>', 'Minimap (tm)' },
      n = { '<cmd>NvimTreeToggle<CR>', 'NvimTree (<C-o>)' },
      p = { '<cmd>TagbarToggle<CR>', 'Tagbar (tp)' },
      r = { '<cmd>WinResizerStartResize<CR>', 'WinRisezier (tr)' },
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
    t = {
      name = '+Fold/Open',
      f = { 'zf', 'create Fold (zf)' },
      d = { 'zd', 'delete All fold (zd)' },
      k = { 'zk', 'Collapse (zk)' },
      j = { 'zj', 'Open (zj)' },
      J = { 'zJ', 'Open all (zJ)' },
      h = { 'zh', 'Collapse / file (zh)'},
      H = { 'zH', 'Collapse all / file (zH)' },
      l = { 'zl', 'Open / file (zl)' },
      L = { 'zL', 'Open all / file (zL)' },
      },
  },
  { prefix = '<leader>' }
)
EOF

" Colorschemes
let g:tokyonight_style = 'storm'
let g:tokyonight_enable_italic = 1
" colorscheme monokai
" colorscheme nord
" colorscheme tokyonight
colorscheme dogrun
" colorscheme codedark
" colorscheme doom-one
" colorscheme lucius
" colorscheme cosme
" colorscheme espresso

" ------------------------------------------------------------------------------
" Additional appearance settings
" ------------------------------------------------------------------------------

" Make transparent for background
" highlight Normal      guibg=none
" highlight NonText     guibg=none
" highlight LineNr      guibg=none
" highlight Folded      guibg=none
" highlight EndOfBuffer guibg=none

" Display column limit '80'
execute "set colorcolumn=" . join(range(80, 9999), ',')
" highlight ColorColumn guibg=#202020 ctermbg=black
" set textwidth=80
" set colorcolumn=+2
hi ColorColumn guibg=none guifg=Orange
