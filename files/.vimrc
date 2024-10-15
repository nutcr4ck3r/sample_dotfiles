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

Plug 'tpope/vim-surround'
Plug 'sjl/badwolf'
Plug 'obcat/vim-sclow'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'babarot/vim-buftabs'
Plug 'tpope/vim-commentary'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'pbogut/fzf-mru.vim'

call plug#end()

" Plugin's commands
" ff : Search files with fzf
" fr : Search strings with fzf:ripgrep
" fm : Search files in MRU

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
nnoremap <silent> ff :Files<CR>
nnoremap <silent> fg :GFiles<CR>
nnoremap <silent> fr :RG<CR>
nnoremap <silent> fm :FZFMru<CR>

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
nnoremap <C-w> :bdelete<CR>

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
set cmdheight=2
set laststatus=2
set showcmd
set display=lastline

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
highlight ColorColumn guibg=#333333 ctermbg=darkgray

" Fix CursorLineNr
hi CursorLineNr   cterm=bold ctermfg=White gui=bold guifg=White

" Cursor shaping
if has('vim_starting')
    " Use line type cursol on insert mode.
    let &t_SI .= "\e[6 q"
    " Use block type cursol on normal mode.
    let &t_EI .= "\e[2 q"
    " Use blink line cursol on replace mode.
    let &t_SR .= "\e[4 q"
endif

colorscheme badwolf
