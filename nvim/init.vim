" ------------------------------------------------------------------------------
" General settings.
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
set updatetime=200        " Set update time for gitgutter sign updating
set signcolumn=yes        " Always show a sign column to show lsp signs
set mouse=a               " Enable mouse controls in nomal, visual, insert and command mode.
filetype plugin indent on " Enable filetree-view (netrw)
autocmd!
augroup vimrc             " to load .vimrc automaticaly when change it.
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
vnoremap <silent> nn <ESC>
" Can move between line head to end.
nnoremap j gj
nnoremap k gk

" 1 line scrolling
nnoremap <S-k> <C-y>
nnoremap <S-j> <C-e>

" Home / End
nnoremap 0 $
nnoremap ` 0
vnoremap 0 $
vnoremap ` 0

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

" Colorscheme settings.
" colorscheme pablo

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
" LSP control
"   Install Plugins => :PlugInstall
"   Update Plugins => :PlugUpdate
"   Install Language server => :LspInstallServer
"   Check & install Lnaguage servers => :LspManageServers (to install: press `i`)
"
"   Format Code => :LspDocumentFormatSync (Ctrl+i)
"   Rename variable names => LspRename (F2)
"   View hover informations => LspHover (Shift+k)
"
"   Jump to a definition => LspDefinition (Ctrl+k)
"   Jump to next diagnostic => LspNextDiagnostic (fd)
"   Jump to next warning => LspNextDiagnostic (fnw)
"   Jump to next error => LspNextDiagnostic (fne)
"
" Open NERDtree => NERDTreeToggle (Shortcut:Ctrl+o)
"   Toggle hidden files showing => shift+i
"
" Toggle comment out
"   for block = gc, for a line = gcc
"
" Toggle minimap
"   Toggle minimap => :MinimapToggle (fm)
"
" Preview a markdown file
"   Open preview with browser => :PrevimOpen
"
" Show Toc on a markdown file
"   on Vertical => :Toc (f -> o) , on Horizontal => :Toch
"
" vim-table-mode
"   Toggle table mode :TableModeToggle (Ctrl+t)
"
" Make markdown table from csv syntax
"   Make table => Select lines and :MakeTable
"   Make table with top index => Select lines and :MakeTable!
"   Make CSV from markdown table => :UnmakeTable
"
" Vim-Surround
"   Surround with `...` => Select word in visual mode and press S -> `
"   Delete surround `...` => press ds -> ` at inner words in `...`
"   Change surround from `...` to (...) => press cs`( at inner words in `...`
"
" Win-Resizer
"   Into Resize-mode: fe
"   Change mode: e, End any-mode: enter
"
" Taglist
"   Show taglist => :Tlist (Ctrl + p)
" ------------------------------------------------------------------------------
call plug#begin()
" utilities
  Plug 'scrooloose/nerdtree'
  " Plug 'cocopon/vaffle.vim'
  Plug 'simeji/winresizer'
  Plug 'voldikss/vim-floaterm'
  Plug 'mhinz/vim-startify'
  Plug 'liuchengxu/vim-which-key'
" for using LSP and snippets
  Plug 'prabirshrestha/asyncomplete.vim'
  Plug 'prabirshrestha/asyncomplete-lsp.vim'
  Plug 'prabirshrestha/vim-lsp'
  Plug 'mattn/vim-lsp-settings'
  Plug 'mattn/vim-lsp-icons'
  Plug 'hrsh7th/vim-vsnip'
  Plug 'hrsh7th/vim-vsnip-integ'
  Plug 'rafamadriz/friendly-snippets'
" for formatting
  Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
    \ 'for': ['python', 'javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'] }
" for automation
  Plug 'tpope/vim-commentary'
  Plug 'jiangmiao/auto-pairs'
  Plug 'ConradIrwin/vim-bracketed-paste'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-repeat'
" for appearance
  Plug 'bronson/vim-trailing-whitespace'
  " Plug 'yggdroot/hipairs'
  Plug 'wfxr/minimap.vim'
  Plug 'lilydjwg/colorizer'
  Plug 'Yggdroot/indentLine'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'ryanoasis/vim-devicons'
" for searching and tags
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'majutsushi/tagbar'
  Plug 'szw/vim-tags'
" for Git
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'
" for markdown editing
  Plug 'tyru/open-browser.vim'
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
  Plug 'yuezk/vim-js'
  Plug 'HerringtonDarkholme/yats.vim'
  Plug 'MaxMEllon/vim-jsx-pretty'
  Plug 'pangloss/vim-javascript'
  Plug 'vim-python/python-syntax'
  Plug 'preservim/vim-markdown'
  Plug 'rhysd/vim-gfm-syntax'
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
" nnoremap <C-o>   :Vaffle<CR>
nnoremap <C-o> :NERDTreeToggle<CR>
nnoremap <silent> tm :MinimapToggle<CR>
nnoremap <silent> tp :TagbarToggle<CR>
nnoremap <silent> tr :WinResizerStartResize<CR>

nnoremap <silent> mm :MakeTable<CR>
nnoremap <silent> mu :UnmakeTable<CR>
nnoremap <silent> mo :Toc<CR>
nnoremap <silent> mp :MarkdownPreviewc<CR>
nnoremap <silent> mt :TableModeToggle<CR>

" FZF
nnoremap <silent> rf :Files<CR>
nnoremap <silent> rb :BLines<CR>
nnoremap <silent> rg :Rg<CR>
nnoremap <silent> rh :History<CR>

" LSP
nnoremap <C-i>   :LspDocumentFormatSync<CR>
nnoremap <C-k>   :LspDefinition<CR>
nnoremap <F2>    :LspRename<CR>
nnoremap <F12>   :LspHover<CR>
nnoremap <silent> gr :LspReferences<CR>
nnoremap <silent> gd :LspDocumentDiagnostics<CR>
nnoremap <silent> gn :LspNextDiagnostic<CR>
nnoremap <silent> gN :LspPreviousDiagnostic<CR>
nnoremap <silent> gw :LspNextWarning<CR>
nnoremap <silent> ge :LspNextError<CR>
nnoremap <silent> gf :LspDocumentFormat<CR>
nnoremap <silent> gp :Prettier<CR>

imap <expr> <Tab> vsnip#available(1)   ? '<Plug>(vsnip-expand-or-jump)' : '<Tab>'
smap <expr> <Tab> vsnip#available(1)   ? '<Plug>(vsnip-expand-or-jump)' : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

" Plugin's settings
" for winresizer
let g:winresizer_start_key = '<C-`>'

" for LSP & autocompletion
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_signature_help_enabled = 0
let g:lsp_diagnostics_highlights_delay = 100
let g:lsp_diagnostics_signs_delay = 100
let g:lsp_diagnostics_virtual_text_delay = 100
let g:asyncomplete_auto_popup = 1
let g:asyncomplete_auto_completeopt = 1
let g:asyncomplete_popup_delay = 50
let g:lsp_text_edit_enabled = 1

" for vim-airline
let g:airline_theme = 'violet'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 0

" for vim-markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_toc_autofit = 1

" for vim-table_mode
let g:table_mode_enable = 1

let g:python_highlight_all = 1

" for vim-rainbow
let g:rainbow_active = 1
let g:rainbow_guifgs = ['RoyalBlue3', 'DarkOrange3', 'DarkOrchid3', 'FireBrick']
let g:rainbow_ctermfgs = ['lightblue', 'lightgreen', 'yellow', 'red', 'magenta']

" for hipairs
" let g:hiPairs_hl_matchPair = { 'ctermbg' : 'black',
"             \                  'ctermfg' : 'white',
"             \                  'term'    : 'bold',
"             \                  'cterm'   : 'bold',
"             \                  'gui'     : 'bold',
"             \                  'guifg'   : 'Yellow',
"             \                  'guibg'   : 'Black' }
" function! CheckFileType()
"   if &filetype == 'markdown'
"     :HiPairsDisable
"   else
"     :HiPairsEnable
"   endif
" endfunction
" au BufEnter,BufRead,BufNewFile * call CheckFileType()

" for vim-closetag
let g:closetag_filenames = '*.html, *.htm, *.js'
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum" " Font color
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum" " Background color

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

" for vim-floaterm
let g:floaterm_keymap_toggle = '<C-j>'
augroup floaterm
 au QuitPre * FloatermKill!
augroup END

" for Vaffle
" function! VaffleRenderCustomIcon(item)
"   return WebDevIconsGetFileTypeSymbol(a:item.basename, a:item.is_dir)
" endfunction
" let g:vaffle_render_custom_icon = 'VaffleRenderCustomIcon'
" let g:vaffle_open_selected_split_position = 'topleft'
" function! s:customize_vaffle_mappings() abort
"     nmap <buffer> <silent> <Left> <Plug>(vaffle-open-parent)
"     nmap <buffer> <silent> <Right> <Plug>(vaffle-open-current)
"     nmap <buffer> <silent> I <Plug>(vaffle-toggle-hidden)
"     nmap <buffer> <silent> n <Plug>(vaffle-new-file)
"     nmap <buffer> <silent> N <Plug>(vaffle-mkdir)
"     nmap <buffer> <silent> r <Plug>(vaffle-refresh)
"     nmap <buffer> <silent> R <Plug>(vaffle-rename-selected)
"     nmap <buffer> <silent> D <Plug>(vaffle-delete-selected)
"     nmap <buffer> <silent> M <Plug>(vaffle-move-selected)
"     nmap <buffer> <silent> <ESC> <Plug>(vaffle-quit)
" endfunction
" augroup vim_vaffle
"     autocmd FileType vaffle call s:customize_vaffle_mappings()
" augroup END

" for startify
let g:startify_files_number = 5
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

" for vim-which-key
let g:mapleader = "\<Space>"
let g:which_key_hspace = 2
let g:which_key_vertical = 0
let g:which_key_position = 'botright'
let g:which_key_hspace = 3
let g:which_key_map = {}
let g:which_key_map.m = [ ':Startify', 'open Start menu' ]
let g:which_key_map.r = {
      \ 'name' : '+Find' ,
      \ 'b' : [':BLines', 'find Buffer lines (rb)'],
      \ 'c' : [':Colors', 'find Color schemes'],
      \ 'C' : [':Commands', 'find Commands'],
      \ 'f' : [':Files', 'find Files (rf)'],
      \ 'h' : [':History', 'find Recetly used files (rh)'],
      \ 'k' : [':Maps:', 'find Key mappings in normalmode'],
      \ 'H' : [':History:', 'find Command histories'],
      \ 'r' : [':Rg', 'find Texts (rg)'],
      \ }
let g:which_key_map.g = {
      \ 'name' : '+LSP' ,
      \ 'd' : [':LspDocumentDiagnostics', 'display Diagnostics list (gd)'],
      \ 'D' : [':LspDefinition', 'goto Definition point (<C-k>)'],
      \ 'e' : [':LspNextError', 'jump to next Error (ge)'],
      \ 'f' : [':LspDocumentFormat', 'format Document (gf)'],
      \ 'h' : [':LspHover', 'view a Hover information (<F12>)'],
      \ 'n' : [':LspNextDiagnostic', 'jump to next Diagnostics (gn)'],
      \ 'N' : [':LspNextDiagnostic', 'jump to previous Diagnostics (gN)'],
      \ 'p' : [':Prettier', 'format Document with Prettier (gp)'],
      \ 'r' : [':LspReferences', 'view References list (gr)'],
      \ 'R' : [':LspRename', 'rename Variable name (<F2>)'],
      \ 'w' : [':LspNextWarning', 'jump to next Warning (gw)'],
      \ }
let g:which_key_map.t = {
      \ 'name' : '+Toggles' ,
      \ 'c' : ['', 'which_key_ignore'],
      \ 'm' : [':MinimapToggle', 'toggle Minimap (tm)'],
      \ 'n' : [':NERDTreeToggle', 'toggle NERDTree (<C-o>)'],
      \ 'p' : [':TagbarToggle', 'toggle Tagbar (tp)'],
      \ 'r' : [':WinResizerStartResize', 'start WinResizer (tr)'],
      \ '?' : ['', 'which_key_ignore'],
      \ 'd' : ['', 'which_key_ignore'],
      \ 'f' : ['', 'which_key_ignore'],
      \ 'i' : ['', 'which_key_ignore'],
      \ 's' : ['', 'which_key_ignore'],
      \ 't' : ['', 'which_key_ignore'],
      \ }
let g:which_key_map.m = {
      \ 'name' : '+Markdown' ,
      \ 'm' : [':MakeTable', 'create a Markdown table from CSV (mm)'],
      \ 'u' : [':UnmakeTable', 'create CSV from a Markdown table (mu)'],
      \ 't' : [':TablemodeToggle', 'toggle Tablemode (mt)'],
      \ 'o' : [':Toc', 'display TOC (mo)'],
      \ 'p' : [':MarkdownPreview', 'preview Markdown file in browser (mp)'],
      \ }
let g:which_key_map.z = {
      \ 'name' : '+Fold/Open' ,
      \ 'f' : ['zf', 'create a Folding on Selections'],
      \ 'k' : ['zk', 'collapse Folding'],
      \ 'j' : ['zj', 'open Folding'],
      \ 'J' : ['zJ', 'open All folding '],
      \ 'h' : ['zh', 'collapse Foldings in the file'],
      \ 'H' : ['zH', 'collapse All foldings in the file'],
      \ 'l' : ['zl', 'open Foldings in the file'],
      \ 'L' : ['zL', 'open All foldings in the file'],
      \ }
let g:which_key_map.h = [ '', 'which_key_ignore' ]
let g:which_key_map.p = [ '', 'which_key_ignore' ]
nnoremap <silent> <leader> :<C-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<C-u>WhichKeyVisual '<Space>'<CR>

call which_key#register('<Space>', "g:which_key_map")

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

" Personal syntax highlight settings (for monokai)
" memo: If want to check highlight group under the cursor,
"       type a command below.
"         :echo synIDattr(synID(line("."), col("."), 1), "name")
"       And confirm highlight value with a command below.
"         :highlight {highlight-group-name}
" Color reference: http://www.calmar.ws/vim/256-xterm-24bit-rgb-color-chart.html
" filetype detect
" if &filetype == 'markdown'
"   highlight Title cterm=bold ctermfg=148 guifg=#A6E22D
"   highlight mkdHeading cterm=bold ctermfg=148 guifg=#A6E22D
"   highlight githubFlavoredMarkdownCode ctermfg=208 ctermbg=234 guifg=#ff8700 guibg=#1c1c1c
"   highlight mkdCode ctermfg=208 ctermbg=234 guifg=#ff8700 guibg=#1c1c1c
"   highlight mkdCodeStart ctermfg=8 guifg=#808080
"   highlight mkdCodeEnd ctermfg=8 guifg=#808080
"   highlight lv5 ctermfg=208 guifg=#ff8700
"   highlight mkdInlineURL cterm=underline ctermfg=184 guifg=#ffff5f
"   highlight mkdDelimiter ctermfg=white guifg=white
"   highlight op_lv0 cterm=bold ctermfg=148 guifg=#A6E22D
" endif

" Implement smooth scrolling
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
