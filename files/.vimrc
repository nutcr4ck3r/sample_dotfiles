" ------------------------------------------------------------------------------
" General settings.
" ------------------------------------------------------------------------------
set nobackup           " Not create backup file.
set noswapfile         " Not create swapfile.
set smartindent        " Use smart indent.
set fenc=utf-8         " Use UFT-8
set autoread           " Reload file automatically when editing file was modify.
set hidden             " Enable to open other file when editing buffer.
set clipboard=unnamed  " Ebable allignment to clipboard.
set belloff=all         " Disable beep.
filetype plugin indent on     " Enable filetree-view (netrw)
" Tree view type (like ls-la)
  let g:netrw_liststyle=1
" Hide Headder
  let g:netrw_banner=0
" File-Size format (use K, M, G)
  let g:netrw_sizestyle="H"
" Date format (use yyyy/mm/dd hh:mm:ss
  let g:netrw_timefmt="%Y/%m/%d(%a) %H:%M:%S"
" display preview-window by vertical-split
  let g:netrw_preview=1

" ------------------------------------------------------------------------------
" Custom Keybind.
" ------------------------------------------------------------------------------
" Enable jj key for exit insert mode.
inoremap <silent> jj <ESC>
" Can move between line head to end.
nnoremap j gj
nnoremap k gk

" Home / End
nnoremap ( 0
nnoremap ) $
vnoremap ( 0
vnoremap ) $

" Scroll 1 line
nnoremap <S-k> <C-y>
nnoremap <S-j> <C-e>

" Jump to previous word's head/end.
nnoremap <S-w> b
nnoremap <S-e> ge

" Close current buffer. (not closes window)
:command QQ bp<bar>sp<bar>bn<bar>bd<CR>
nnoremap <silent> qq :bp<bar>sp<bar>bn<bar>bd<CR>

" Toggle buffer
nnoremap <C-h> :bprevious<CR>
nnoremap <C-l> :bnext<CR>
nnoremap <C-w> :bdelete<CR>

" Split window
nnoremap <silent> fu <C-w>s
nnoremap <silent> fi <C-w>v
" Change current window
nnoremap <silent> fh <C-w>h
nnoremap <silent> fj <C-w>j
nnoremap <silent> fk <C-w>k
nnoremap <silent> fl <C-w>l
" Move current window
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

" ------------------------------------------------------------------------------
" Input settings.
" ------------------------------------------------------------------------------
set whichwrap=b,s,h,l,<,>,[,]   " Cursol can move between line end to line head.
set backspace=indent,eol,start  " Enable backspace.
set shiftwidth=2                " Change indent to space.
set wildmode=list:longest       " Complement file name when input command.

" ------------------------------------------------------------------------------
" Appearance settings.
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

" Display column limit '80'
execute "set colorcolumn=" . join(range(81, 9999), ',')
highlight ColorColumn guibg=#202020 ctermbg=black

" Hilight pairs brackets.
" set showmatch
" set matchtime=1
" set matchpairs& matchpairs+=<:>
let loaded_matchparen = 1

" For use Transparency and powerline-shell.
highlight Normal ctermbg=none
highlight NonText ctermbg=none

"highlight LineNr ctermbg=none
highlight Folded ctermbg=none
highlight EndOfBuffer ctermbg=none

if has('vim_starting')
    " Use line type cursol on insert mode.
    let &t_SI .= "\e[6 q"
    " Use block type cursol on normal mode.
    let &t_EI .= "\e[2 q"
    " Use blink line cursol on replace mode.
    let &t_SR .= "\e[4 q"
endif

"colorscheme elflord                    " Colorscheme settings.

" ------------------------------------------------------------------------------
" Tab's number settings.
" ------------------------------------------------------------------------------
set list listchars=tab:\?\-  " Tab are displayed as symbols.
set expandtab                " Modify tab to space.
set tabstop=2                " Set number of tabs (at line top).
set shiftwidth=2             " Set number of tabs (inline).

" ------------------------------------------------------------------------------
" Search settings.
" ------------------------------------------------------------------------------
set ignorecase  " Ignore case sensitivity when search strings is lower case.
set incsearch   " Enable live search.
set wrapscan    " Go file head when search is arrive at EOF
set hlsearch    " Hilight search strings.

" ------------------------------------------------------------------------------
" vim-plug
"
" Install Plugins => :PlugInstall
" Update Plugins => :PlugUpdate
" Install Language server => :LspInstallServer
" Check & install Lnaguage servers => :LspManageServers (to install: press `i`)
" Format Code => :LspDocumentFormatSync (Shortcut: Ctrl+i)
" Rename variable names => LspRename (Shortcut: F2)
" View hover informations => LspHover (Shortcut: F12)
" Jump to a definition => LspDefinition (Shortcut: Ctrl+k)
" Open NERDtree => NERDTreeToggle (Shortcut:Ctrl+o)
"   Toggle hidden files showing => shift+i
"   Reload a tree => r
" Toggle comment out
"   for block = gc, for a line = gcc
" Preview a markdown file => :PrevimOpen
" Show Toc on a markdown file
"   on Vertical => :Toc (Ctrl+p) , on Horizontal => :Toch
" vim-table-mode
"   Toggle table mode :TableModeToggle (Ctrl+t)
" Make markdown table from csv syntax
"   Make table => Select lines and :MakeTable
"   Make table with top index => Select lines and :MakeTable!
"   Make CSV from markdown table => :UnmakeTable
" Vim-Surround
"   Surround with `...` => Select word in visual mode and press S`
"   Delete surround `...` => press ds` at inner words in `...`
"   Change surround from `...` to (...) => press cs`( at inner words in `...`
" Win-Resizer
"   Into Resize-mode: Ctrl + e
"   Change mode: e, End any-mode: enter
" ------------------------------------------------------------------------------
call plug#begin()
" Always ON
  "Plug 'fholgado/minibufexpl.vim'
  Plug 'scrooloose/nerdtree'
" for Coding / mandatory plugins
  Plug 'prabirshrestha/asyncomplete.vim'
  Plug 'prabirshrestha/asyncomplete-lsp.vim'
  Plug 'prabirshrestha/vim-lsp'
  Plug 'mattn/vim-lsp-settings'
  Plug 'mattn/vim-lsp-icons'
  Plug 'hrsh7th/vim-vsnip'
  Plug 'hrsh7th/vim-vsnip-integ'
  Plug 'rafamadriz/friendly-snippets'
  Plug 'bronson/vim-trailing-whitespace'
  Plug 'tpope/vim-commentary'
  Plug 'jiangmiao/auto-pairs'
  Plug 'frazrepo/vim-rainbow'
  Plug 'yggdroot/hipairs'
  Plug 'gko/vim-coloresque'
  Plug 'lilydjwg/colorizer'
  Plug 'ConradIrwin/vim-bracketed-paste'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-repeat'
  Plug 'godlygeek/tabular'
  Plug 'simeji/winresizer'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'vim-scripts/taglist.vim'
  Plug 'szw/vim-tags'
" for Appearance
  Plug 'Yggdroot/indentLine'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'ryanoasis/vim-devicons'
  Plug 'crusoexia/vim-monokai'
  Plug 'ghifarit53/tokyonight-vim'
" for vimrc
  Plug 'guns/xterm-color-table.vim'
" for markdown editing
  Plug 'previm/previm'
  Plug 'tyru/open-browser.vim'
  Plug 'dhruvasagar/vim-table-mode'
  Plug 'mattn/vim-maketable'
" for HTML
  Plug 'alvan/vim-closetag'
" for Git
  Plug 'airblade/vim-gitgutter'
" for JSON
  Plug 'elzr/vim-json'
" for Dockerfile
  Plug 'ekalinin/Dockerfile.vim'
" for Syntax hilight
  Plug 'yuezk/vim-js'
  Plug 'HerringtonDarkholme/yats.vim'
  Plug 'MaxMEllon/vim-jsx-pretty'
  Plug 'pangloss/vim-javascript'
  Plug 'vim-python/python-syntax'
  Plug 'preservim/vim-markdown'
  Plug 'rhysd/vim-gfm-syntax'
call plug#end()

" Plugin's keybind
nnoremap <C-o>   :NERDTreeToggle<CR>
nnoremap <silent> ff :Files<CR>
nnoremap <silent> fr :Rg<CR>
" nnoremap <C-p>   :LspInstallServer<CR>
" nnoremap <C-p>   :Toc<CR>
nnoremap <silent> fo :Toc<CR>
nnoremap <C-p>   :Tlist<CR>
nnoremap <C-i>   :LspDocumentFormatSync<CR>
nnoremap <C-k>   :LspDefinition<CR>
nnoremap <F2>    :LspRename<CR>
nnoremap <F12>   :LspHover<CR>
imap <expr> <Tab> vsnip#available(1)   ? '<Plug>(vsnip-expand-or-jump)' : '<Tab>'
smap <expr> <Tab> vsnip#available(1)   ? '<Plug>(vsnip-expand-or-jump)' : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
nnoremap <C-t>   :TableModeToggle<CR>

" Plugin's settings
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_signature_help_enabled = 0
let g:asyncomplete_auto_popup = 1
let g:asyncomplete_auto_completeopt = 1
let g:asyncomplete_popup_delay = 200
let g:lsp_text_edit_enabled = 1
let g:airline_theme = 'dark'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 0
let g:previm_enable_realtime = 1
let g:previm_disable_default_css = 1
let g:previm_custom_css_path = '~/.vim/css/markdown.css'
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_toc_autofit = 1
let g:table_mode_enable = 1
let g:python_highlight_all = 1
let g:rainbow_active = 1
let g:rainbow_guifgs = ['RoyalBlue3', 'DarkOrange3', 'DarkOrchid3', 'FireBrick']
let g:rainbow_ctermfgs = ['lightblue', 'lightgreen', 'yellow', 'red', 'magenta']
let g:hiPairs_hl_matchPair = { 'term'    : 'underline,bold',
            \                  'cterm'   : 'bold',
            \                  'ctermfg' : 'red',
            \                  'ctermbg' : 'black',
            \                  'gui'     : 'bold',
            \                  'guifg'   : 'Black',
            \                  'guibg'   : '#D3B17D' }
let g:closetag_filenames = '*.html, *.htm, *.js'
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum" " Font color
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum" " Background color
if has("mac")
  let Tlist_Ctags_Cmd = "/usr/local/bin/ctags"
elseif has("unix")
  let Tlist_Ctags_Cmd = "/usr/bin/ctags"
endif
let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Use_Right_Window = 1

" Colorscheme
colorscheme monokai                    " Colorscheme settings.
" colorscheme molokai                    " Colorscheme settings.
" colorscheme monokai_pro                " Colorscheme settings.

" set termguicolors
" let g:tokyonight_style = 'night' " available: night, storm
" let g:tokyonight_enable_italic = 1
" colorscheme tokyonight

" Personal syntax highlight settings (for monokai)
" memo: If want to check highlight group under the cursor,
"       type a command below.
"         :echo synIDattr(synID(line("."), col("."), 1), "name")
"       And confirm highlight value with a command below.
"         :highlight {highlight-group-name}
" Color reference: http://www.calmar.ws/vim/256-xterm-24bit-rgb-color-chart.html
highlight Title cterm=bold ctermfg=148 guifg=#A6E22D
highlight mkdHeading cterm=bold ctermfg=148 guifg=#A6E22D
highlight githubFlavoredMarkdownCode ctermfg=208 ctermbg=234 guifg=#ff8700 guibg=#1c1c1c
highlight mkdCode ctermfg=208 ctermbg=234 guifg=#ff8700 guibg=#1c1c1c
highlight mkdCodeStart ctermfg=8 guifg=#808080
highlight mkdCodeEnd ctermfg=8 guifg=#808080
highlight lv5 ctermfg=208 guifg=#ff8700
highlight mkdInlineURL cterm=underline ctermfg=184 guifg=#ffff5f
highlight mkdDelimiter ctermfg=white guifg=white
highlight op_lv0 cterm=bold ctermfg=148 guifg=#A6E22D
