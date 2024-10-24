" ------------------------------------------------------------------------------
" Description
" ------------------------------------------------------------------------------
" This .vimrc file contains the following contents:
" - Plugins
" - General settings
" - File Tree View (netrw)
" - Auto commands
" - Session Saving
" - Custom Keybinds
" - Input settings
" - Tab's number settings
" - Search settings
" - Appearance settings

" ------------------------------------------------------------------------------
" Plugins
" ------------------------------------------------------------------------------

call plug#begin()

" Colorscheme
Plug 'sjl/badwolf'
Plug 'rakr/vim-one'
Plug 'ayu-theme/ayu-vim'
Plug 'wadackel/vim-dogrun'
Plug 'whatyouhide/vim-gotham'
Plug 'catppuccin/vim', {'as': 'catppuccin'}
" Editing Support
Plug 'obcat/vim-hitspop'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'LunarWatcher/auto-pairs'
Plug 'ntpeters/vim-better-whitespace'
Plug 'ConradIrwin/vim-bracketed-paste'
" User Interface
Plug 'junegunn/fzf'
Plug 'obcat/vim-sclow'
Plug 'junegunn/fzf.vim'
Plug 'pacha/vem-tabline'
Plug 'pbogut/fzf-mru.vim'
Plug 'luochen1990/rainbow'
Plug 'voldikss/vim-floaterm'
Plug 'vim-airline/vim-airline'
Plug 'liuchengxu/vim-which-key'
Plug 'vim-airline/vim-airline-themes'
" Coding
Plug 'SidOfc/mkdx'
Plug 'preservim/vim-markdown'

call plug#end()

" Colorscheme ------------------------------------------------------------------
" colorscheme one
" colorscheme ayu
" let ayucolor="mirage"
colorscheme gotham
" colorscheme dogrun
" colorscheme onedark
" colorscheme badwolf
" colorscheme catppuccin_mocha

" vim-airline/vim-airline ------------------------------------------------------
let g:airline_theme  = 'gotham'
" let g:airline_theme  = 'distinguished'

" Plugin's commands ------------------------------------------------------------
" ff : Search files with fzf
" fr : Search strings with fzf:ripgrep
" fm : Search files in MRU
" <C-t> : Toggle Floaterm
" StripWhitespace : Delete all trailing spaces
" TableFormat : Format markdown table under the cursor
" :Toc : Create vertical TOC for markdown
" :Toc : Create horizontal TOC for markdown
nnoremap <silent> ff :Files<CR>
nnoremap <silent> fg :GFiles<CR>
nnoremap <silent> fr :RG<CR>
nnoremap <silent> fm :FZFMru<CR>
nnoremap <silent> <C-t> :FloatermToggle<CR>
tnoremap <silent> <C-t> <C-\><C-n>:FloatermToggle<CR>
let mapleader = "\<Space>"
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

" liuchengxu/vim-which-key -----------------------------------------------------
let g:which_key_ignore_outside_mappings = 1
let g:which_key_map = {}
let g:which_key_map['e'] = {
      \ 'name' : '+etc' ,
      \ 's' : [':StripWhitespace', 'StripWhitespace: Delete all trailing spaces'],
      \ }
let g:which_key_map['f'] = {
      \ 'name' : '+fzf' ,
      \ 'f' : [':Files', 'Files: Search Files in the CD'],
      \ 'm' : [':FZFMru', 'FZFMru: Search MRU'],
      \ 'g' : [':GFiles', 'GFiles: Search Files in the Git repo'],
      \ 'r' : [':RG', 'RG: Search Strings in the CD'],
      \ 'c' : [':Colors', 'Colors: Search installed colorschemes'],
      \ }
let g:which_key_map['m'] = {
      \ 'name' : '+Markdown' ,
      \ 't' : [':Tocv', 'Tocv: Create vertical TOC'],
      \ 'T' : [':Toch', 'Toch: Create horizontal TOC'],
      \ 'f' : [':TableFormat', 'TableFormat: Format table under the cursor'],
      \ }
let g:which_key_map['p'] = {
      \ 'name' : '+Plug' ,
      \ 'i' : [':PlugInstall', 'PlugInstall: Install listed plugins'],
      \ 'c' : [':PlugClean', 'PlugClean: Uninstall unlisted plugins'],
      \ 'd' : [':PlugDiff', 'PlugDiff: Show diff Pre/Post editing'],
      \ 'u' : [':PlugUpdate', 'PlugUpdate: Update/Install listed plugins'],
      \ 'U' : [':PlugUpgrade', 'PlugUpgrade: Update vim-plug itself'],
      \ }
let g:which_key_map['z'] = {
      \ 'name' : '+Fold' ,
      \ 'f' : ['zf', 'Create fold'],
      \ 'D' : ['zD', 'Delete all fold'],
      \ 'k' : ['zk', 'Close fold'],
      \ 'j' : ['zj', 'Open one fold'],
      \ 'J' : ['zJ', 'Open all fold'],
      \ 'h' : ['zh', 'Collapse one fold in the page'],
      \ 'H' : ['zH', 'Collapse all fold in the page'],
      \ 'l' : ['zl', 'Open one fold in the page'],
      \ 'L' : ['zL', 'Open all fold in the page'],
      \ }
call which_key#register('<Space>', "g:which_key_map")

" obcat/vim-sclow --------------------------------------------------------------
set updatetime=100
let g:sclow_block_buftypes = ['terminal', 'prompt']
let g:sclow_hide_full_length = 1
let g:sclow_sbar_text = '┃'

" preservim/vim-markdown -------------------------------------------------------
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_no_default_key_mappings = 1
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_borderless_table = 1
let g:vim_markdown_auto_insert_bullets = 0

" voldikss/vim-floaterm --------------------------------------------------------
let g:floaterm_autoclose = 2
let g:floaterm_height = 0.9
let g:floaterm_width = 0.9
augroup vimrc_floaterm
  autocmd!
  autocmd QuitPre * FloatermKill!
augroup END

" fzf.vim  ---------------------------------------------------------------------
" Modified Rg command to direct path
function! FZGrep(query, fullscreen)
  let command_fmt = 'rg --hidden --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
command! -nargs=* -bang RG call FZGrep(<q-args>, <bang>0)
" Modified FZFMru command to show preview
command! -bang -nargs=? FZFMru call fzf_mru#actions#mru(<q-args>,
    \{
      \'window': {'width': 0.9, 'height': 0.6},
      \'options': [
        \'--preview', 'bat --style=numbers --color=always {}',
        \'--preview-window', 'down:50%'
      \]
    \})

" luochen1990/rainbow ----------------------------------------------------------
let g:rainbow_active = 1
let g:rainbow_conf = {
      \'guifgs': ['orange', 'magenta', 'cyan'],
      \'ctermfgs': ['yellow', 'magenta', 'cyan'],
      \'guis': ['bold'],'cterms': ['bold']
      \}

" ------------------------------------------------------------------------------
" General settings
" ------------------------------------------------------------------------------
set nobackup              " Not create backup file.
set noswapfile            " Not create swapfile.
set smartindent           " Use smart indent.
set fenc=utf-8            " Use UFT-8
set autoread              " Reload file automatically when editing file was modify.
set hidden                " Enable to open other file when editing buffer.
set clipboard=unnamedplus " Ebable allignment to clipboard.
set belloff=all           " Disable beep.
set timeoutlen=400        " Timeout time untill key input.
set updatetime=200        " Set update time for gitgutter sign updating
set signcolumn=yes        " Always show a sign column to show lsp signs
set mouse=a               " Enable mouse controls in nomal, visual, insert and command mode.
set autochdir             " Change Current Directory when open tab/buffer.

" ------------------------------------------------------------------------------
" File Tree View (netrw)
" ------------------------------------------------------------------------------
filetype plugin indent on     " Enable filetree-view (netrw)
filetype plugin on            " Enable plugin
set nocp                      " Disable 'compatible'
let g:netrw_preview=1         " Split preview window
let g:netrw_liststyle=3       " tree style
let g:netrw_keepdir = 0       " Set current dir at tree opening
let g:netrw_banner = 0        " Delete banner
let g:netrw_winsize = 25      " Window size
let g:netrw_browse_split = 4  " Splitting size

" netrw toggle function
let g:NetrwIsOpen=0
function! ToggleNetrw()
    if g:NetrwIsOpen
        let i = bufnr("$")
        while (i >= 1)
            if (getbufvar(i, "&filetype") == "netrw")
                silent exe "bwipeout " . i
            endif
            let i-=1
        endwhile
        let g:NetrwIsOpen=0
    else
        let g:NetrwIsOpen=1
        silent Vex
    endif
endfunction

" ------------------------------------------------------------------------------
" Auto commands
" ------------------------------------------------------------------------------
autocmd!
" to load .vimrc automaticaly when change it.
au BufWritePost *.vimrc source ~/.vimrc
" to save the last cursor position.
autocmd BufReadPost *
\ if line("'\"") > 0 && line ("'\"") <= line("$") |
\   exe "normal! g'\"" |
\ endif

" to save & restore current session
augroup session
function! SaveSess()
  execute 'mksession! ~/.session.vim'
endfunction
function! RestoreSess()
  if !empty(glob('~/.session.vim'))
      execute 'so ~/.session.vim'
  endif
endfunction
autocmd VimLeave * call SaveSess()
autocmd VimEnter * nested call RestoreSess()
augroup END

" ------------------------------------------------------------------------------
" Custom Keybinds
" ------------------------------------------------------------------------------
" Set Leader key
let mapleader = "\<space>"

" Enable jj key for exit insert mode.
inoremap <silent> jj <ESC>
vnoremap <silent> nn <ESC>

" Enable direct cursor moving in wrapped line
nnoremap j gj
nnoremap k gk

" 1 line scrolling
nnoremap <S-k> <C-y>
nnoremap <S-j> <C-e>

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
nnoremap <C-w> :bp<bar>sp<bar>bn<bar>bd<CR>

" Split window
nnoremap <silent> fu <C-w>s<C-w>j
nnoremap <silent> fi <C-w>v<C-w>l
" Close current window
nnoremap <silent> fx <C-w>c
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
nnoremap <silent> f. <C-w>>  " Move partition to right
nnoremap <silent> f, <C-w><  " Move partition to left
nnoremap <silent> f- <C-w>_  " Move partition to up
nnoremap <silent> f= <C-w>=  " Move partition to down
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

" Release hilight search strings when continuous input ESC.
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" Fold/Open
vnoremap <silent> zf zf  " Create fold
nnoremap <silent> zD zD  " Delete all fold
nnoremap <silent> zk zc  " Close fold
nnoremap <silent> zj zo  " Open fold
nnoremap <silent> zJ zO  " Open all fold
nnoremap <silent> zh zm  " Collapse one fold in the page
nnoremap <silent> zH zM  " Collapse all fold in the page
nnoremap <silent> zl zr  " Open one fold in the page
nnoremap <silent> zL zR  " Open all fold in the page

" Toggle netrw
noremap <silent><C-o> :call ToggleNetrw()<CR>

" ------------------------------------------------------------------------------
" Input settings
" ------------------------------------------------------------------------------
set whichwrap=b,s,h,l,<,>,[,]   " Cursol can move between line end to line head.
set backspace=indent,eol,start  " Enable backspace.
set shiftwidth=2                " Change indent to space.
set wildmode=list:longest       " Complement file name when input command.
set textwidth=0                 " Disable auto indentation.

" ------------------------------------------------------------------------------
" Tab's number settings
" ------------------------------------------------------------------------------
set list listchars=tab:\?\-  " Tab are displayed as symbols.
set expandtab                " Modify tab to space.
set tabstop=2                " Set number of tabs (at line top).
set shiftwidth=2             " Set number of tabs (inline).

" ------------------------------------------------------------------------------
" Search settings
" ------------------------------------------------------------------------------
set ignorecase  " Ignore case sensitivity when search strings is lower case.
set incsearch   " Enable live search.
set wrapscan    " Go file head when search is arrive at EOF
set hlsearch    " Hilight search strings.

" ------------------------------------------------------------------------------
" Appearance settings
" ------------------------------------------------------------------------------
set t_Co=256                           " Enable 256 colors.
set termguicolors                      " Enable termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set cursorline                         " Hilight current line.
set nowrap                             " Disable line wrap.
syntax enable                          " Enable syntax hilight.

" Status & command line
set showcmd
set cmdheight=1
set laststatus=2
set display=lastline
" set statusline=%{mode()}│%f\ %m│%R%<
" set statusline+=%=│%Y│%{&fileencoding}│row\ %L│

" Display line numbers.
set number

" Hilight pairs brackets.
set showmatch
set matchtime=1
set matchpairs& matchpairs+=<:>

" Display double quotation in json file.
set conceallevel=0
let g:vim_json_syntax_conceal = 0

" Display column limit '80'
execute "set colorcolumn=" . join(range(81, 9999), ',')
" highlight ColorColumn guibg=#333333 ctermbg=darkgray

" Cursor shaping
if has('vim_starting')
    " Use line type cursol on insert mode.
    let &t_SI .= "\e[6 q"
    " Use block type cursol on normal mode.
    let &t_EI .= "\e[2 q"
    " Use blink line cursol on replace mode.
    let &t_SR .= "\e[4 q"
endif

