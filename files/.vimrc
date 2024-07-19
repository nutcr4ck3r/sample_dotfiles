" ------------------------------------------------------------------------------
" Description
" ------------------------------------------------------------------------------
" This .vimrc file contains the following contents:
" - General Vim settings
" - File Tree View
" - Session Saving
" - Keybinds
" - Static Plugin data
"   - Colorscheme (dogrun)
"   - surround.vim

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
set timeoutlen=400        " Timeout time untill key input.
set updatetime=200        " Set update time for gitgutter sign updating
set signcolumn=yes        " Always show a sign column to show lsp signs
set mouse=a               " Enable mouse controls in nomal, visual, insert and command mode.
filetype plugin indent on " Enable filetree-view (netrw)

" ------------------------------------------------------------------------------
" netrw
" ------------------------------------------------------------------------------
set nocp                  " Disable 'compatible'
filetype plugin on        " Enable plugin
let g:netrw_preview=1     " Split preview window
let g:netrw_liststyle=3   " tree style
let g:netrw_keepdir = 0   " Set current dir at tree opening
let g:netrw_banner = 0    " Delete banner
" window size
let g:netrw_winsize = 25
let g:netrw_browse_split = 4

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

" Set shortcut key
noremap <silent><C-o> :call ToggleNetrw()<CR>

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
fu! SaveSess()
execute 'mksession! ~/.session.vim'
endfunction
fu! RestoreSess()
if !empty(glob('~/.session.vim'))
    execute 'so ~/.session.vim'
endif
endfunction
autocmd VimLeave * call SaveSess()
autocmd VimEnter * nested call RestoreSess()
augroup END

" ------------------------------------------------------------------------------
" Custom Keybind.
" ------------------------------------------------------------------------------
" Kill all
nnoremap <silent> @@ :wqa<CR>
nnoremap <silent> !! :qa!<CR>

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
set termguicolors                      " Enable termguicolors
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

" Cursor shaping
if has('vim_starting')
    " Use line type cursol on insert mode.
    let &t_SI .= "\e[6 q"
    " Use block type cursol on normal mode.
    let &t_EI .= "\e[2 q"
    " Use blink line cursol on replace mode.
    let &t_SR .= "\e[4 q"
endif

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
" Colorscheme / copied dogrun
" ------------------------------------------------------------------------------
if &background !=# 'dark'
  set background=dark
endif

if exists('g:colors_name')
  hi clear
endif

if exists('g:syntax_on')
  syntax reset
endif

hi Normal guifg=#9ea3c0 ctermfg=146 guibg=#222433 ctermbg=235
hi Delimiter guifg=#8085a6 ctermfg=103
hi NonText guifg=#363859 ctermfg=60 guibg=NONE ctermbg=NONE
hi VertSplit guifg=#32364c ctermfg=237 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi LineNr guifg=#32364c ctermfg=237 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi EndOfBuffer guifg=#363859 ctermfg=60 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Comment guifg=#545c8c ctermfg=60 gui=NONE cterm=NONE
hi Cursor guifg=#222433 ctermfg=235 guibg=#9ea3c0 ctermbg=146
hi CursorIM guifg=#222433 ctermfg=235 guibg=#9ea3c0 ctermbg=146
hi SignColumn guifg=#545c8c ctermfg=60 guibg=NONE ctermbg=NONE
hi ColorColumn guibg=#2a2c3f ctermbg=236 gui=NONE cterm=NONE
hi CursorColumn guibg=#2a2c3f ctermbg=236 gui=NONE cterm=NONE
hi CursorLine guibg=#2a2c3f ctermbg=236 gui=NONE cterm=NONE
hi CursorLineNr guifg=#535f98 ctermfg=61 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Conceal guifg=#ac8b83 ctermfg=138 guibg=#222433 ctermbg=235 gui=NONE cterm=NONE
hi NormalFloat guifg=#9ea3c0 ctermfg=146 guibg=#32364c ctermbg=237 gui=NONE cterm=NONE
hi Folded guifg=#666c99 ctermfg=60 guibg=#32364c ctermbg=237 gui=NONE cterm=NONE
hi FoldColumn guifg=#32364c ctermfg=237 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi MatchParen gui=bold guibg=#000000 guifg=#b871b8 ctermbg=236
hi Directory guifg=#a8a384 ctermfg=144
hi Underlined gui=underline cterm=underline
hi String guifg=#7cbe8c ctermfg=108
hi Statement guifg=#929be5 ctermfg=104 gui=NONE cterm=NONE
hi Label guifg=#929be5 ctermfg=104 gui=NONE cterm=NONE
hi Function guifg=#929be5 ctermfg=104 gui=NONE cterm=NONE
hi Constant guifg=#73c1a9 ctermfg=79
hi Boolean guifg=#73c1a9 ctermfg=79
hi Number guifg=#73c1a9 ctermfg=79
hi Float guifg=#73c1a9 ctermfg=79
hi Title guifg=#a8a384 ctermfg=144 gui=bold cterm=bold
hi Keyword guifg=#ac8b83 ctermfg=138
hi Identifier guifg=#ac8b83 ctermfg=138
hi Exception guifg=#a8a384 ctermfg=144
hi Type guifg=#a8a384 ctermfg=144 gui=NONE cterm=NONE
hi TypeDef guifg=#a8a384 ctermfg=144 gui=NONE cterm=NONE
hi PreProc guifg=#929be5 ctermfg=104
hi Special guifg=#b871b8 ctermfg=133
hi SpecialKey guifg=#b871b8 ctermfg=133
hi SpecialChar guifg=#b871b8 ctermfg=133
hi SpecialComment guifg=#b871b8 ctermfg=133
hi Error guifg=#dc6f79 ctermfg=167 guibg=#222433 ctermbg=235 gui=bold cterm=bold
hi ErrorMsg guifg=#dc6f79 ctermfg=167 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi WarningMsg guifg=#ac8b83 ctermfg=138 gui=bold cterm=bold
hi MoreMsg guifg=#73c1a9 ctermfg=79
hi Todo guifg=#a8a384 ctermfg=144 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi Pmenu guifg=#9ea3c0 ctermfg=146 guibg=#32364c ctermbg=237
hi PmenuSel guifg=#9ea3c0 ctermfg=146 guibg=#424865 ctermbg=60
hi PmenuSbar guibg=#292c3f ctermbg=236
hi PmenuThumb guibg=#464f7f ctermbg=60
hi Visual guibg=#363e7f ctermbg=61 gui=NONE cterm=NONE
hi Search guifg=#a6afff ctermfg=147 guibg=#6471e5 ctermbg=63
hi IncSearch guifg=#a4b2ff ctermfg=147 guibg=#4754cb ctermbg=62 gui=NONE cterm=NONE
hi Question guifg=#73c1a9 ctermfg=79 gui=bold cterm=bold
hi WildMenu guifg=#222433 ctermfg=235 guibg=#929be5 ctermbg=104
hi SpellBad guifg=#dc6f79 ctermfg=167 gui=underline cterm=underline
hi SpellCap gui=underline cterm=underline
hi SpellLocal guifg=#dc6f79 ctermfg=167 gui=underline cterm=underline
hi SpellRare guifg=#a8a384 ctermfg=144 gui=underline cterm=underline
hi DiffAdd guibg=#1c394b ctermbg=237 gui=bold cterm=bold
hi DiffChange guibg=#26463b ctermbg=23 gui=bold cterm=bold
hi DiffDelete guifg=#d2d9ff ctermfg=189 guibg=#5e3e5e ctermbg=96 gui=bold cterm=bold
hi DiffText guibg=#28795c ctermbg=29 gui=NONE cterm=NONE
hi QuickFixLine guifg=#9ea3c0 ctermfg=146 guibg=#363e7f ctermbg=61
hi StatusLine guifg=#757aa5 ctermfg=103 guibg=#2a2c3f ctermbg=236 gui=bold cterm=bold
hi StatusLineTerm guifg=#757aa5 ctermfg=103 guibg=#2a2c3f ctermbg=236 gui=bold cterm=bold
hi StatusLineNC guifg=#4b4e6d ctermfg=60 guibg=#282a3a ctermbg=235 gui=NONE cterm=NONE
hi StatusLineTermNC guifg=#4b4e6d ctermfg=60 guibg=#282a3a ctermbg=235 gui=NONE cterm=NONE
hi TabLine guifg=#757aa5 ctermfg=103 guibg=#2a2c3f ctermbg=236 gui=NONE cterm=NONE
hi TabLineFill guifg=#757aa5 ctermfg=103 guibg=#2a2c3f ctermbg=236 gui=NONE cterm=NONE
hi TabLineSel guifg=#222433 ctermfg=235 guibg=#929be5 ctermbg=104 gui=bold cterm=bold
hi qfFileName guifg=#73c1a9 ctermfg=79
hi qfLineNr guifg=#545c8c ctermfg=60
hi DiagnosticError guifg=#dc6f79 ctermfg=167
hi DiagnosticVirtualTextError guifg=#dc6f79 ctermfg=167 gui=bold cterm=bold
hi DiagnosticUnderlineError guifg=#dc6f79 ctermfg=167 gui=underline cterm=underline
hi DiagnosticWarn guifg=#ac8b83 ctermfg=138
hi DiagnosticVirtualTextWarn guifg=#ac8b83 ctermfg=138 gui=bold cterm=bold
hi DiagnosticUnderlineWarn guifg=#ac8b83 ctermfg=138 gui=underline cterm=underline
hi DiagnosticInfo guifg=#82dabf ctermfg=115
hi DiagnosticVirtualTextInfo guifg=#545c8c ctermfg=60 gui=bold cterm=bold
hi DiagnosticUnderlineInfo gui=underline cterm=underline
hi DiagnosticHint guifg=#82dabf ctermfg=115
hi DiagnosticVirtualTextHint guifg=#545c8c ctermfg=60 gui=bold cterm=bold
hi DiagnosticUnderlineHint gui=underline cterm=underline
hi htmlTag guifg=#8085a6 ctermfg=103
hi htmlEndTag guifg=#8085a6 ctermfg=103
hi htmlSpecialTagName guifg=#ac8b83 ctermfg=138
hi htmlArg guifg=#8085a6 ctermfg=103
hi jsonQuote guifg=#8085a6 ctermfg=103
hi yamlBlockMappingKey guifg=#929be5 ctermfg=104
hi yamlAnchor guifg=#b871b8 ctermfg=133
hi pythonStatement guifg=#ac8b83 ctermfg=138
hi pythonBuiltin guifg=#59b6b6 ctermfg=73
hi pythonRepeat guifg=#ac8b83 ctermfg=138
hi pythonOperator guifg=#ac8b83 ctermfg=138
hi pythonDecorator guifg=#b871b8 ctermfg=133
hi pythonDecoratorName guifg=#b871b8 ctermfg=133
hi zshVariableDef guifg=#929be5 ctermfg=104
hi zshFunction guifg=#929be5 ctermfg=104
hi zshKSHFunction guifg=#929be5 ctermfg=104
hi cPreCondit guifg=#ac8b83 ctermfg=138
hi cIncluded guifg=#b871b8 ctermfg=133
hi cStorageClass guifg=#ac8b83 ctermfg=138
hi cppStructure guifg=#b871b8 ctermfg=133
hi cppSTLnamespace guifg=#ac8b83 ctermfg=138
hi csStorage guifg=#ac8b83 ctermfg=138
hi csModifier guifg=#929be5 ctermfg=104
hi csClass guifg=#929be5 ctermfg=104
hi csClassType guifg=#b871b8 ctermfg=133
hi csNewType guifg=#ac8b83 ctermfg=138
hi rubyConstant guifg=#ac8b83 ctermfg=138
hi rubySymbol guifg=#929be5 ctermfg=104
hi rubyBlockParameter guifg=#929be5 ctermfg=104
hi rubyClassName guifg=#b871b8 ctermfg=133
hi rubyInstanceVariable guifg=#b871b8 ctermfg=133
hi typescriptImport guifg=#929be5 ctermfg=104
hi typescriptDocRef guifg=#545c8c ctermfg=60 gui=underline cterm=underline
hi mkdHeading guifg=#545c8c ctermfg=60
hi mkdLink guifg=#929be5 ctermfg=104
hi mkdCode guifg=#929be5 ctermfg=104
hi mkdCodeStart guifg=#929be5 ctermfg=104
hi mkdCodeEnd guifg=#929be5 ctermfg=104
hi mkdCodeDelimiter guifg=#929be5 ctermfg=104
hi tomlTable guifg=#929be5 ctermfg=104
hi rustModPath guifg=#929be5 ctermfg=104
hi rustTypedef guifg=#929be5 ctermfg=104
hi rustStructure guifg=#929be5 ctermfg=104
hi rustMacro guifg=#929be5 ctermfg=104
hi rustExternCrate guifg=#929be5 ctermfg=104
hi graphqlStructure guifg=#b871b8 ctermfg=133
hi graphqlDirective guifg=#b871b8 ctermfg=133
hi graphqlName guifg=#929be5 ctermfg=104
hi graphqlTemplateString guifg=#9ea3c0 ctermfg=146
hi vimfilerOpenedFile guifg=#6f78be ctermfg=104
hi vimfilerClosedFile guifg=#6f78be ctermfg=104
hi vimfilerNonMark guifg=#73c1a9 ctermfg=79
hi vimfilerLeaf guifg=#73c1a9 ctermfg=79
hi DefxIconsMarkIcon guifg=#6f78be ctermfg=104 gui=NONE cterm=NONE
hi DefxIconsDirectory guifg=#6f78be ctermfg=104 gui=NONE cterm=NONE
hi DefxIconsParentDirectory guifg=#6f78be ctermfg=104 gui=NONE cterm=NONE
hi DefxIconsSymlinkDirectory guifg=#73c1a9 ctermfg=79 gui=NONE cterm=NONE
hi DefxIconsOpenedTreeIcon guifg=#6f78be ctermfg=104 gui=NONE cterm=NONE
hi DefxIconsNestedTreeIcon guifg=#6f78be ctermfg=104 gui=NONE cterm=NONE
hi DefxIconsClosedTreeIcon guifg=#6f78be ctermfg=104 gui=NONE cterm=NONE
hi Defx_git_Untracked guifg=#929be5 ctermfg=104 gui=NONE cterm=NONE
hi Defx_git_Ignored guifg=#545c8c ctermfg=60 gui=NONE cterm=NONE
hi Defx_git_Unknown guifg=#545c8c ctermfg=60 gui=NONE cterm=NONE
hi Defx_git_Renamed guifg=#26463b ctermfg=23
hi Defx_git_Modified guifg=#26463b ctermfg=23
hi Defx_git_Unmerged guifg=#b871b8 ctermfg=133
hi Defx_git_Deleted guifg=#5e3e5e ctermfg=96
hi Defx_git_Staged guifg=#73c1a9 ctermfg=79
hi FernBranchSymbol guifg=#6f78be ctermfg=104 gui=NONE cterm=NONE
hi FernBranchText guifg=#929be5 ctermfg=104 gui=NONE cterm=NONE
hi FernLeafSymbol guifg=#548e7c ctermfg=66 gui=NONE cterm=NONE
hi FernLeafText guifg=#9ea3c0 ctermfg=146 gui=NONE cterm=NONE
hi FernMarked guifg=#59b6b6 ctermfg=73 gui=NONE cterm=NONE
hi GitGutterAdd guifg=#7cbe8c ctermfg=108
hi GitGutterChange guifg=#a8a384 ctermfg=144
hi GitGutterDelete guifg=#b871b8 ctermfg=133
hi GitGutterChangeDelete guifg=#28795c ctermfg=29
hi fugitiveHeader guifg=#73c1a9 ctermfg=79 gui=bold cterm=bold
hi ALEWarningSign guifg=#ac8b83 ctermfg=138 gui=bold cterm=bold
hi ALEInfoSign guifg=#82dabf ctermfg=115 gui=NONE cterm=NONE
hi CocErrorSign guifg=#dc6f79 ctermfg=167 gui=bold cterm=bold
hi CocWarningSign guifg=#ac8b83 ctermfg=138 gui=bold cterm=bold
hi CocInfoSign guifg=#82dabf ctermfg=115 gui=bold cterm=bold
hi CocHintSign guifg=#82dabf ctermfg=115 gui=bold cterm=bold
hi LspError guifg=#dc6f79 ctermfg=167
hi LspErrorText guifg=#dc6f79 ctermfg=167 gui=bold cterm=bold
hi LspErrorHighlight gui=underline cterm=underline
hi LspErrorVirtualText guifg=#dc6f79 ctermfg=167 gui=bold cterm=bold
hi LspWarning guifg=#ac8b83 ctermfg=138
hi LspWarningText guifg=#ac8b83 ctermfg=138 gui=bold cterm=bold
hi LspWarningHighlight gui=underline cterm=underline
hi LspWarningVirtualText guifg=#ac8b83 ctermfg=138 gui=bold cterm=bold
hi LspInformation guifg=#82dabf ctermfg=115
hi LspInformationText guifg=#82dabf ctermfg=115 gui=bold cterm=bold
hi LspInformationHighlight gui=underline cterm=underline
hi LspInformationVirtualText guifg=#545c8c ctermfg=60 gui=bold cterm=bold
hi LspHint guifg=#82dabf ctermfg=115
hi LspHintText guifg=#82dabf ctermfg=115 gui=bold cterm=bold
hi LspHintHighlight gui=underline cterm=underline
hi LspHintVirtualText guifg=#545c8c ctermfg=60 gui=bold cterm=bold
hi LspCodeActionText guifg=#6f78be ctermfg=104 gui=bold cterm=bold
hi CmpItemAbbr guifg=#9ea3c0 ctermfg=146
hi CmpItemAbbrMatch guifg=#929be5 ctermfg=104 gui=bold cterm=bold
hi CmpItemAbbrMatchFuzzy guifg=#929be5 ctermfg=104 gui=bold cterm=bold
hi CmpItemKind guifg=#8085a6 ctermfg=103
hi CmpItemKindDefault guifg=#8085a6 ctermfg=103
hi CmpItemKindText guifg=#8085a6 ctermfg=103
hi CmpItemKindVariable guifg=#8085a6 ctermfg=103
hi CmpItemKindKeyword guifg=#8085a6 ctermfg=103
hi CmpItemKindInterface guifg=#8085a6 ctermfg=103
hi CmpItemKindFunction guifg=#8085a6 ctermfg=103
hi CmpItemKindMethod guifg=#8085a6 ctermfg=103
hi CmpItemKindProperty guifg=#8085a6 ctermfg=103
hi CmpItemKindUnit guifg=#8085a6 ctermfg=103
hi TelescopeNormal guifg=#8085a6 ctermfg=103
hi TelescopeTitle guifg=#929be5 ctermfg=104
hi TelescopeMatching guifg=#bdc3e6 ctermfg=146 gui=bold cterm=bold
hi TelescopeBorder guifg=#545c8c ctermfg=60
hi TelescopePromptPrefix guifg=#73c1a9 ctermfg=79
hi TelescopePromptCounter guifg=#545c8c ctermfg=60
hi TelescopeMultiIcon guifg=#a8a384 ctermfg=144
hi TelescopeMultiSelection guifg=#a8a384 ctermfg=144
hi CleverFChar guifg=#a6afff ctermfg=147 guibg=#6471e5 ctermbg=63 gui=underline cterm=underline
hi ConflictMarkerBegin guibg=#548e7c ctermbg=66 gui=bold cterm=bold
hi ConflictMarkerOurs guibg=#26463b ctermbg=23 gui=NONE cterm=NONE
hi ConflictMarkerTheirs guibg=#1c394b ctermbg=237 gui=NONE cterm=NONE
hi ConflictMarkerEnd guibg=#417593 ctermbg=31 gui=bold cterm=bold
hi ConflictMarkerSeparator guifg=#363859 ctermfg=60 gui=bold cterm=bold
hi EasyMotionTarget guifg=#a8a384 ctermfg=144 gui=bold cterm=bold
hi EasyMotionShade guifg=#545c8c ctermfg=60 guibg=#222433 ctermbg=235
hi EasyMotionIncCursor guifg=#9ea3c0 ctermfg=146 guibg=#222433 ctermbg=235
hi FidgetTitle guifg=#73c1a9 ctermfg=79 gui=bold cterm=bold
hi FidgetTask guifg=#545c8c ctermfg=60
let g:defx_icons_gui_colors = {
  \ 'brown': 'a9323d',
  \ 'aqua': '5b9c9c',
  \ 'blue': '5d8fac',
  \ 'darkBlue': '557486',
  \ 'purple': '6f78be',
  \ 'lightPurple': '959acb',
  \ 'red': 'c2616b',
  \ 'beige': '686765',
  \ 'yellow': '8e8a6f',
  \ 'orange': 'c59f96',
  \ 'darkOrange': '79564f',
  \ 'pink': '9e619e',
  \ 'salmon': 'ab57ab',
  \ 'green': '63976f',
  \ 'lightGreen': '5aa46c',
  \ 'white': '898da6',
  \ }
let g:defx_icons_term_colors = {
  \ 'brown': 131,
  \ 'aqua': 73,
  \ 'blue': 67,
  \ 'darkBlue': 67,
  \ 'purple': 104,
  \ 'lightPurple': 103,
  \ 'red': 131,
  \ 'beige': 242,
  \ 'yellow': 101,
  \ 'orange': 181,
  \ 'darkOrange': 95,
  \ 'pink': 133,
  \ 'salmon': 133,
  \ 'green': 65,
  \ 'lightGreen': 71,
  \ 'white': 103,
  \ }
let g:fzf_colors = {
  \ 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine'],
  \ 'bg+':     ['bg', 'CursorLine'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'Comment'],
  \ 'gutter':  ['bg', 'Normal'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Label'],
  \ 'pointer': ['fg', 'Boolean'],
  \ 'marker':  ['fg', 'Boolean'],
  \ 'spinner': ['fg', 'Title'],
  \ 'header':  ['fg', 'Comment'],
  \ }

" ------------------------------------------------------------------------------
" Override colorscheme
" ------------------------------------------------------------------------------
" Display trail spacing
set list
set listchars=tab:^\ ,trail:~

" ------------------------------------------------------------------------------
" Copied surround.vim
" ------------------------------------------------------------------------------
if exists("g:loaded_surround") || &cp || v:version < 700
  finish
endif
let g:loaded_surround = 1

" Input functions {{{1

function! s:getchar()
  let c = getchar()
  if c =~ '^\d\+$'
    let c = nr2char(c)
  endif
  return c
endfunction

function! s:inputtarget()
  let c = s:getchar()
  while c =~ '^\d\+$'
    let c .= s:getchar()
  endwhile
  if c == " "
    let c .= s:getchar()
  endif
  if c =~ "\<Esc>\|\<C-C>\|\0"
    return ""
  else
    return c
  endif
endfunction

function! s:inputreplacement()
  let c = s:getchar()
  if c == " "
    let c .= s:getchar()
  endif
  if c =~ "\<Esc>" || c =~ "\<C-C>"
    return ""
  else
    return c
  endif
endfunction

function! s:beep()
  exe "norm! \<Esc>"
  return ""
endfunction

function! s:redraw()
  redraw
  return ""
endfunction

" }}}1

" Wrapping functions {{{1

function! s:extractbefore(str)
  if a:str =~ '\r'
    return matchstr(a:str,'.*\ze\r')
  else
    return matchstr(a:str,'.*\ze\n')
  endif
endfunction

function! s:extractafter(str)
  if a:str =~ '\r'
    return matchstr(a:str,'\r\zs.*')
  else
    return matchstr(a:str,'\n\zs.*')
  endif
endfunction

function! s:fixindent(str,spc)
  let str = substitute(a:str,'\t',repeat(' ',&sw),'g')
  let spc = substitute(a:spc,'\t',repeat(' ',&sw),'g')
  let str = substitute(str,'\(\n\|\%^\).\@=','\1'.spc,'g')
  if ! &et
    let str = substitute(str,'\s\{'.&ts.'\}',"\t",'g')
  endif
  return str
endfunction

function! s:process(string)
  let i = 0
  for i in range(7)
    let repl_{i} = ''
    let m = matchstr(a:string,nr2char(i).'.\{-\}\ze'.nr2char(i))
    if m != ''
      let m = substitute(strpart(m,1),'\r.*','','')
      let repl_{i} = input(match(m,'\w\+$') >= 0 ? m.': ' : m)
    endif
  endfor
  let s = ""
  let i = 0
  while i < strlen(a:string)
    let char = strpart(a:string,i,1)
    if char2nr(char) < 8
      let next = stridx(a:string,char,i+1)
      if next == -1
        let s .= char
      else
        let insertion = repl_{char2nr(char)}
        let subs = strpart(a:string,i+1,next-i-1)
        let subs = matchstr(subs,'\r.*')
        while subs =~ '^\r.*\r'
          let sub = matchstr(subs,"^\r\\zs[^\r]*\r[^\r]*")
          let subs = strpart(subs,strlen(sub)+1)
          let r = stridx(sub,"\r")
          let insertion = substitute(insertion,strpart(sub,0,r),strpart(sub,r+1),'')
        endwhile
        let s .= insertion
        let i = next
      endif
    else
      let s .= char
    endif
    let i += 1
  endwhile
  return s
endfunction

function! s:wrap(string,char,type,removed,special)
  let keeper = a:string
  let newchar = a:char
  let s:input = ""
  let type = a:type
  let linemode = type ==# 'V' ? 1 : 0
  let before = ""
  let after  = ""
  if type ==# "V"
    let initspaces = matchstr(keeper,'\%^\s*')
  else
    let initspaces = matchstr(getline('.'),'\%^\s*')
  endif
  let pairs = "b()B{}r[]a<>"
  let extraspace = ""
  if newchar =~ '^ '
    let newchar = strpart(newchar,1)
    let extraspace = ' '
  endif
  let idx = stridx(pairs,newchar)
  if newchar == ' '
    let before = ''
    let after  = ''
  elseif exists("b:surround_".char2nr(newchar))
    let all    = s:process(b:surround_{char2nr(newchar)})
    let before = s:extractbefore(all)
    let after  =  s:extractafter(all)
  elseif exists("g:surround_".char2nr(newchar))
    let all    = s:process(g:surround_{char2nr(newchar)})
    let before = s:extractbefore(all)
    let after  =  s:extractafter(all)
  elseif newchar ==# "p"
    let before = "\n"
    let after  = "\n\n"
  elseif newchar ==# 's'
    let before = ' '
    let after  = ''
  elseif newchar ==# ':'
    let before = ':'
    let after = ''
  elseif newchar =~# "[tT\<C-T><]"
    let dounmapp = 0
    let dounmapb = 0
    if !maparg(">","c")
      let dounmapb = 1
      " Hide from AsNeeded
      exe "cn"."oremap > ><CR>"
    endif
    let default = ""
    if newchar ==# "T"
      if !exists("s:lastdel")
        let s:lastdel = ""
      endif
      let default = matchstr(s:lastdel,'<\zs.\{-\}\ze>')
    endif
    let tag = input("<",default)
    if dounmapb
      silent! cunmap >
    endif
    let s:input = tag
    if tag != ""
      let keepAttributes = ( match(tag, ">$") == -1 )
      let tag = substitute(tag,'>*$','','')
      let attributes = ""
      if keepAttributes
        let attributes = matchstr(a:removed, '<[^ \t\n]\+\zs\_.\{-\}\ze>')
      endif
      let s:input = tag . '>'
      if tag =~ '/$'
        let tag = substitute(tag, '/$', '', '')
        let before = '<'.tag.attributes.' />'
        let after = ''
      else
        let before = '<'.tag.attributes.'>'
        let after  = '</'.substitute(tag,' .*','','').'>'
      endif
      if newchar == "\<C-T>"
        if type ==# "v" || type ==# "V"
          let before .= "\n\t"
        endif
        if type ==# "v"
          let after  = "\n". after
        endif
      endif
    endif
  elseif newchar ==# 'l' || newchar == '\'
    " LaTeX
    let env = input('\begin{')
    if env != ""
      let s:input = env."\<CR>"
      let env = '{' . env
      let env .= s:closematch(env)
      echo '\begin'.env
      let before = '\begin'.env
      let after  = '\end'.matchstr(env,'[^}]*').'}'
    endif
  elseif newchar ==# 'f' || newchar ==# 'F'
    let fnc = input('function: ')
    if fnc != ""
      let s:input = fnc."\<CR>"
      let before = substitute(fnc,'($','','').'('
      let after  = ')'
      if newchar ==# 'F'
        let before .= ' '
        let after = ' ' . after
      endif
    endif
  elseif newchar ==# "\<C-F>"
    let fnc = input('function: ')
    let s:input = fnc."\<CR>"
    let before = '('.fnc.' '
    let after = ')'
  elseif idx >= 0
    let spc = (idx % 3) == 1 ? " " : ""
    let idx = idx / 3 * 3
    let before = strpart(pairs,idx+1,1) . spc
    let after  = spc . strpart(pairs,idx+2,1)
  elseif newchar == "\<C-[>" || newchar == "\<C-]>"
    let before = "{\n\t"
    let after  = "\n}"
  elseif newchar !~ '\a'
    let before = newchar
    let after  = newchar
  else
    let before = ''
    let after  = ''
  endif
  let after  = substitute(after ,'\n','\n'.initspaces,'g')
  if type ==# 'V' || (a:special && type ==# "v")
    let before = substitute(before,' \+$','','')
    let after  = substitute(after ,'^ \+','','')
    if after !~ '^\n'
      let after  = initspaces.after
    endif
    if keeper !~ '\n$' && after !~ '^\n'
      let keeper .= "\n"
    elseif keeper =~ '\n$' && after =~ '^\n'
      let after = strpart(after,1)
    endif
    if keeper !~ '^\n' && before !~ '\n\s*$'
      let before .= "\n"
      if a:special
        let before .= "\t"
      endif
    elseif keeper =~ '^\n' && before =~ '\n\s*$'
      let keeper = strcharpart(keeper,1)
    endif
    if type ==# 'V' && keeper =~ '\n\s*\n$'
      let keeper = strcharpart(keeper,0,strchars(keeper) - 1)
    endif
  endif
  if type ==# 'V'
    let before = initspaces.before
  endif
  if before =~ '\n\s*\%$'
    if type ==# 'v'
      let keeper = initspaces.keeper
    endif
    let padding = matchstr(before,'\n\zs\s\+\%$')
    let before  = substitute(before,'\n\s\+\%$','\n','')
    let keeper = s:fixindent(keeper,padding)
  endif
  if type ==# 'V'
    let keeper = before.keeper.after
  elseif type =~ "^\<C-V>"
    " Really we should be iterating over the buffer
    let repl = substitute(before,'[\\~]','\\&','g').'\1'.substitute(after,'[\\~]','\\&','g')
    let repl = substitute(repl,'\n',' ','g')
    let keeper = substitute(keeper."\n",'\(.\{-\}\)\(\n\)',repl.'\n','g')
    let keeper = substitute(keeper,'\n\%$','','')
  else
    let keeper = before.extraspace.keeper.extraspace.after
  endif
  return keeper
endfunction

function! s:wrapreg(reg,char,removed,special)
  let orig = getreg(a:reg)
  let type = substitute(getregtype(a:reg),'\d\+$','','')
  let new = s:wrap(orig,a:char,type,a:removed,a:special)
  call setreg(a:reg,new,type)
endfunction
" }}}1

function! s:insert(...) " {{{1
  " Optional argument causes the result to appear on 3 lines, not 1
  let linemode = a:0 ? a:1 : 0
  let char = s:inputreplacement()
  while char == "\<CR>" || char == "\<C-S>"
    " TODO: use total count for additional blank lines
    let linemode += 1
    let char = s:inputreplacement()
  endwhile
  if char == ""
    return ""
  endif
  let cb_save = &clipboard
  set clipboard-=unnamed clipboard-=unnamedplus
  let reg_save = @@
  call setreg('"',"\032",'v')
  call s:wrapreg('"',char,"",linemode)
  " If line mode is used and the surrounding consists solely of a suffix,
  " remove the initial newline.  This fits a use case of mine but is a
  " little inconsistent.  Is there anyone that would prefer the simpler
  " behavior of just inserting the newline?
  if linemode && match(getreg('"'),'^\n\s*\zs.*') == 0
    call setreg('"',matchstr(getreg('"'),'^\n\s*\zs.*'),getregtype('"'))
  endif
  " This can be used to append a placeholder to the end
  if exists("g:surround_insert_tail")
    call setreg('"',g:surround_insert_tail,"a".getregtype('"'))
  endif
  if &ve != 'all' && col('.') >= col('$')
    if &ve == 'insert'
      let extra_cols = virtcol('.') - virtcol('$')
      if extra_cols > 0
        let [regval,regtype] = [getreg('"',1,1),getregtype('"')]
        call setreg('"',join(map(range(extra_cols),'" "'),''),'v')
        norm! ""p
        call setreg('"',regval,regtype)
      endif
    endif
    norm! ""p
  else
    norm! ""P
  endif
  if linemode
    call s:reindent()
  endif
  norm! `]
  call search("\032",'bW')
  let @@ = reg_save
  let &clipboard = cb_save
  return "\<Del>"
endfunction " }}}1

function! s:reindent() abort " {{{1
  if get(b:, 'surround_indent', get(g:, 'surround_indent', 1)) && (!empty(&equalprg) || !empty(&indentexpr) || &cindent || &smartindent || &lisp)
    silent norm! '[=']
  endif
endfunction " }}}1

function! s:dosurround(...) " {{{1
  let sol_save = &startofline
  set startofline
  let scount = v:count1
  let char = (a:0 ? a:1 : s:inputtarget())
  let spc = ""
  if char =~ '^\d\+'
    let scount = scount * matchstr(char,'^\d\+')
    let char = substitute(char,'^\d\+','','')
  endif
  if char =~ '^ '
    let char = strpart(char,1)
    let spc = 1
  endif
  if char == 'a'
    let char = '>'
  endif
  if char == 'r'
    let char = ']'
  endif
  let newchar = ""
  if a:0 > 1
    let newchar = a:2
    if newchar == "\<Esc>" || newchar == "\<C-C>" || newchar == ""
      if !sol_save
        set nostartofline
      endif
      return s:beep()
    endif
  endif
  let cb_save = &clipboard
  set clipboard-=unnamed clipboard-=unnamedplus
  let append = ""
  let original = getreg('"')
  let otype = getregtype('"')
  call setreg('"',"")
  let strcount = (scount == 1 ? "" : scount)
  if char == '/'
    exe 'norm! '.strcount.'[/d'.strcount.']/'
  elseif char =~# '[[:punct:][:space:]]' && char !~# '[][(){}<>"''`]'
    exe 'norm! T'.char
    if getline('.')[col('.')-1] == char
      exe 'norm! l'
    endif
    exe 'norm! dt'.char
  else
    exe 'norm! d'.strcount.'i'.char
  endif
  let keeper = getreg('"')
  let okeeper = keeper " for reindent below
  if keeper == ""
    call setreg('"',original,otype)
    let &clipboard = cb_save
    if !sol_save
      set nostartofline
    endif
    return ""
  endif
  let oldline = getline('.')
  let oldlnum = line('.')
  if char ==# "p"
    call setreg('"','','V')
  elseif char ==# "s" || char ==# "w" || char ==# "W"
    " Do nothing
    call setreg('"','')
  elseif char =~ "[\"'`]"
    exe "norm! i \<Esc>d2i".char
    call setreg('"',substitute(getreg('"'),' ','',''))
  elseif char == '/'
    norm! "_x
    call setreg('"','/**/',"c")
    let keeper = substitute(substitute(keeper,'^/\*\s\=','',''),'\s\=\*$','','')
  elseif char =~# '[[:punct:][:space:]]' && char !~# '[][(){}<>]'
    exe 'norm! F'.char
    exe 'norm! df'.char
  else
    " One character backwards
    call search('\m.', 'bW')
    exe "norm! da".char
  endif
  let removed = getreg('"')
  let rem2 = substitute(removed,'\n.*','','')
  let oldhead = strpart(oldline,0,strlen(oldline)-strlen(rem2))
  let oldtail = strpart(oldline,  strlen(oldline)-strlen(rem2))
  let regtype = getregtype('"')
  if char =~# '[\[({<T]' || spc
    let keeper = substitute(keeper,'^\s\+','','')
    let keeper = substitute(keeper,'\s\+$','','')
  endif
  if col("']") == col("$") && virtcol('.') + 1 == virtcol('$')
    if oldhead =~# '^\s*$' && a:0 < 2
      let keeper = substitute(keeper,'\%^\n'.oldhead.'\(\s*.\{-\}\)\n\s*\%$','\1','')
    endif
    let pcmd = "p"
  else
    let pcmd = "P"
  endif
  if line('.') + 1 < oldlnum && regtype ==# "V"
    let pcmd = "p"
  endif
  call setreg('"',keeper,regtype)
  if newchar != ""
    let special = a:0 > 2 ? a:3 : 0
    call s:wrapreg('"',newchar,removed,special)
  endif
  silent exe 'norm! ""'.pcmd.'`['
  if removed =~ '\n' || okeeper =~ '\n' || getreg('"') =~ '\n'
    call s:reindent()
  endif
  if getline('.') =~ '^\s\+$' && keeper =~ '^\s*\n'
    silent norm! cc
  endif
  call setreg('"',original,otype)
  let s:lastdel = removed
  let &clipboard = cb_save
  if newchar == ""
    silent! call repeat#set("\<Plug>Dsurround".char,scount)
  else
    silent! call repeat#set("\<Plug>C".(a:0 > 2 && a:3 ? "S" : "s")."urround".char.newchar.s:input,scount)
  endif
  if !sol_save
    set nostartofline
  endif
endfunction " }}}1

function! s:changesurround(...) " {{{1
  let a = s:inputtarget()
  if a == ""
    return s:beep()
  endif
  let b = s:inputreplacement()
  if b == ""
    return s:beep()
  endif
  call s:dosurround(a,b,a:0 && a:1)
endfunction " }}}1

function! s:opfunc(type, ...) abort " {{{1
  if a:type ==# 'setup'
    let &opfunc = matchstr(expand('<sfile>'), '<SNR>\w\+$')
    return 'g@'
  endif
  let char = s:inputreplacement()
  if char == ""
    return s:beep()
  endif
  let reg = '"'
  let sel_save = &selection
  let &selection = "inclusive"
  let cb_save  = &clipboard
  set clipboard-=unnamed clipboard-=unnamedplus
  let reg_save = getreg(reg)
  let reg_type = getregtype(reg)
  let type = a:type
  if a:type == "char"
    silent exe 'norm! v`[o`]"'.reg.'y'
    let type = 'v'
  elseif a:type == "line"
    silent exe 'norm! `[V`]"'.reg.'y'
    let type = 'V'
  elseif a:type ==# "v" || a:type ==# "V" || a:type ==# "\<C-V>"
    let &selection = sel_save
    let ve = &virtualedit
    if !(a:0 && a:1)
      set virtualedit=
    endif
    silent exe 'norm! gv"'.reg.'y'
    let &virtualedit = ve
  elseif a:type =~ '^\d\+$'
    let type = 'v'
    silent exe 'norm! ^v'.a:type.'$h"'.reg.'y'
    if mode() ==# 'v'
      norm! v
      return s:beep()
    endif
  else
    let &selection = sel_save
    let &clipboard = cb_save
    return s:beep()
  endif
  let keeper = getreg(reg)
  if type ==# "v" && a:type !=# "v"
    let append = matchstr(keeper,'\_s\@<!\s*$')
    let keeper = substitute(keeper,'\_s\@<!\s*$','','')
  endif
  call setreg(reg,keeper,type)
  call s:wrapreg(reg,char,"",a:0 && a:1)
  if type ==# "v" && a:type !=# "v" && append != ""
    call setreg(reg,append,"ac")
  endif
  silent exe 'norm! gv'.(reg == '"' ? '' : '"' . reg).'p`['
  if type ==# 'V' || (getreg(reg) =~ '\n' && type ==# 'v')
    call s:reindent()
  endif
  call setreg(reg,reg_save,reg_type)
  let &selection = sel_save
  let &clipboard = cb_save
  if a:type =~ '^\d\+$'
    silent! call repeat#set("\<Plug>Y".(a:0 && a:1 ? "S" : "s")."surround".char.s:input,a:type)
  else
    silent! call repeat#set("\<Plug>SurroundRepeat".char.s:input)
  endif
endfunction

function! s:opfunc2(...) abort
  if !a:0 || a:1 ==# 'setup'
    let &opfunc = matchstr(expand('<sfile>'), '<SNR>\w\+$')
    return 'g@'
  endif
  call s:opfunc(a:1, 1)
endfunction " }}}1

function! s:closematch(str) " {{{1
  " Close an open (, {, [, or < on the command line.
  let tail = matchstr(a:str,'.[^\[\](){}<>]*$')
  if tail =~ '^\[.\+'
    return "]"
  elseif tail =~ '^(.\+'
    return ")"
  elseif tail =~ '^{.\+'
    return "}"
  elseif tail =~ '^<.+'
    return ">"
  else
    return ""
  endif
endfunction " }}}1

nnoremap <silent> <Plug>SurroundRepeat .
nnoremap <silent> <Plug>Dsurround  :<C-U>call <SID>dosurround(<SID>inputtarget())<CR>
nnoremap <silent> <Plug>Csurround  :<C-U>call <SID>changesurround()<CR>
nnoremap <silent> <Plug>CSurround  :<C-U>call <SID>changesurround(1)<CR>
nnoremap <expr>   <Plug>Yssurround '^'.v:count1.<SID>opfunc('setup').'g_'
nnoremap <expr>   <Plug>YSsurround <SID>opfunc2('setup').'_'
nnoremap <expr>   <Plug>Ysurround  <SID>opfunc('setup')
nnoremap <expr>   <Plug>YSurround  <SID>opfunc2('setup')
vnoremap <silent> <Plug>VSurround  :<C-U>call <SID>opfunc(visualmode(),visualmode() ==# 'V' ? 1 : 0)<CR>
vnoremap <silent> <Plug>VgSurround :<C-U>call <SID>opfunc(visualmode(),visualmode() ==# 'V' ? 0 : 1)<CR>
inoremap <silent> <Plug>Isurround  <C-R>=<SID>insert()<CR>
inoremap <silent> <Plug>ISurround  <C-R>=<SID>insert(1)<CR>

if !exists("g:surround_no_mappings") || ! g:surround_no_mappings
  nmap ds  <Plug>Dsurround
  nmap cs  <Plug>Csurround
  nmap cS  <Plug>CSurround
  nmap ys  <Plug>Ysurround
  nmap yS  <Plug>YSurround
  nmap yss <Plug>Yssurround
  nmap ySs <Plug>YSsurround
  nmap ySS <Plug>YSsurround
  xmap S   <Plug>VSurround
  xmap gS  <Plug>VgSurround
  if !exists("g:surround_no_insert_mappings") || ! g:surround_no_insert_mappings
    if !hasmapto("<Plug>Isurround","i") && "" == mapcheck("<C-S>","i")
      imap    <C-S> <Plug>Isurround
    endif
    imap      <C-G>s <Plug>Isurround
    imap      <C-G>S <Plug>ISurround
  endif
endif

" vim:set ft=vim sw=2 sts=2 et:

" ------------------------------------------------------------------------------
" Copied buftabs.vim
" ------------------------------------------------------------------------------
" statbufline (C) 2014 b4b4r07

scriptencoding utf-8
if &diff | finish | endif

" Load Once {{{
if get(g:, 'g:loaded_buftabs', 0) || &cp
  finish
endif
let g:loaded_buftabs = 1
" }}}
" Saving 'cpoptions' {{{
let s:save_cpo = &cpo
set cpo&vim
" }}}

" Some variables {{{
let s:original_left_statusline = matchstr(&statusline, "%=.*")
let s:original_statusline      = &statusline
let g:buftabs_enabled          = get(g:, 'buftabs_enabled',          1)
let g:buftabs_in_statusline    = get(g:, 'buftabs_in_statusline',    1)
let g:buftabs_only_basename    = get(g:, 'buftabs_only_basename',    1)
let g:buftabs_marker_start     = get(g:, 'buftabs_marker_start',    '[')
let g:buftabs_marker_end       = get(g:, 'buftabs_marker_end',      ']')
let g:buftabs_marker_modified  = get(g:, 'buftabs_marker_modified', '+')
let g:buftabs_separator        = get(g:, 'buftabs_separator',       '#')
let g:buftabs_active_highlight_group     = get(g:, 'buftabs_active_highlight_group', 'Visual')
let g:buftabs_inactive_highlight_group   = get(g:, 'buftabs_inactive_highlight_group',     '')
let g:buftabs_statusline_highlight_group = get(g:, 'buftabs_statusline_highlight_group',   '')
"}}}
" Toggle buftabs {{{
function! s:buftabs_toggle(...)
  " Enable or Disable
  if a:0 == 1
    let g:buftabs_enabled = a:1 ? 1 : 0
  endif
  " Toggle enable and disable
  if a:0 == 0
    let g:buftabs_enabled = g:buftabs_enabled ? 0 : 1
  endif
  call s:buftabs()
endfunction
"}}}
" Buftabs {{{
function! s:buftabs()
  if g:buftabs_enabled == 1
    call s:buftabs_show(-1)
  endif

  if g:buftabs_enabled == 0
    for buf in range(1, bufnr('$'))
      if bufexists(buf) && buflisted(buf)
        let &statusline = s:original_statusline
        bprev
      endif
    endfor
  endif
endfunction "}}}
" Draw the buftabs {{{
function! s:buftabs_show(deleted_buf)
  if g:buftabs_enabled == 0
    return
  endif
  " Show original statusline
  let i = 1
  let s:list = ''
  let start = 0
  let end = 0
  let from = 0

  " Walk the list of buffers
  while(i <= bufnr('$'))
    " Only show buffers in the list, and omit help screens
    if buflisted(i) && getbufvar(i, "&modifiable") && a:deleted_buf != i
      " Get the name of the current buffer, and escape characters that might
      " mess up the statusline
      if g:buftabs_only_basename
        let name = fnamemodify(bufname(i), ':t')
      else
        let name = bufname(i)
      endif
      let name = substitute(name, "%", "%%", "g")
      let name = substitute(name, "-", "\x03", "g")

      " Append the current buffer number and name to the list. If the buffer
      " is the active buffer, enclose it in some magick characters which will
      " be replaced by markers later. If it is modified, it is appended with
      " an appropriate symbol (an exclamation mark by default)
      if winbufnr(winnr()) == i
        let start = strlen(s:list)
        let s:list = s:list . "\x01"
      else
        let s:list = s:list . ' '
      endif

      let s:list = s:list . i . g:buftabs_separator
      let s:list = s:list . name

      if getbufvar(i, "&modified") == 1
        let s:list = s:list . g:buftabs_marker_modified
      endif

      if winbufnr(winnr()) == i
        let s:list = s:list . "\x02"
        let end = strlen(s:list)
      else
        let s:list = s:list . ' '
      endif
    end

    let i = i + 1
  endwhile

  " If the resulting list is too long to fit on the screen, chop
  " out the appropriate part
  let width = winwidth(0) - 12

  if(start < from) 
    let from = start - 1
  endif
  if end > from + width
    let from = end - width 
  endif

  let s:list = strpart(s:list, from, width)

  " Replace the magic characters by visible markers for highlighting the
  " current buffer. The markers can be simple characters like square brackets,
  " but can also be special codes with highlight groups
  if exists("g:buftabs_in_cmdline") && g:buftabs_in_cmdline
    redraw
    let s:list2 = copy(s:list)
    let s:list2 = substitute(s:list2, "\x01", g:buftabs_marker_start, 'g')
    let s:list2 = substitute(s:list2, "\x02", g:buftabs_marker_end,   'g')
    ""call s:echo_buftabs(s:list2)
  end

  if exists("g:buftabs_active_highlight_group")
    if exists("g:buftabs_in_statusline")
      let buftabs_marker_start = "%#" . g:buftabs_active_highlight_group . "#" . g:buftabs_marker_start
      let buftabs_marker_end = g:buftabs_marker_end . "%##"
    end
  end

  if exists("g:buftabs_inactive_highlight_group")
    if exists("g:buftabs_in_statusline")
      let s:list = '%#' . g:buftabs_inactive_highlight_group . '#' . s:list
      let s:list .= '%##'
      let buftabs_marker_end = g:buftabs_marker_end . '%#' . g:buftabs_inactive_highlight_group . '#'
    end
  end

  let s:list = substitute(s:list, "\x01", buftabs_marker_start, 'g')
  let s:list = substitute(s:list, "\x02", buftabs_marker_end, 'g')

  " Show the list. The buftabs_in_statusline variable determines of the list
  " is displayed in the command line (volatile) or in the statusline
  " (persistent)
  if exists("g:buftabs_in_statusline") && g:buftabs_in_statusline
    "if match(&statusline, "%{buftabs#statusline()}") == -1
    if match(&statusline, s:list) == -1
      if exists("g:buftabs_statusline_highlight_group")
        let s:original_left_statusline = '%=' . '%#' . g:buftabs_statusline_highlight_group . '#' . 
              \ substitute(substitute(s:original_left_statusline, '^%=', '', ''), '%#.*#', '', '')
      endif
      "let &statusline = s:list . s:original_left_statusline
      let &statusline = substitute(s:list, "\x03", "-", 'g') . s:original_left_statusline
    end
  end

endfunction
"}}}
" Interface {{{
command! -nargs=0 BuftabsToggle  call s:buftabs_toggle()
command! -nargs=0 BuftabsEnable  call s:buftabs_toggle(1)
command! -nargs=0 BuftabsDisable call s:buftabs_toggle(0)

autocmd VimEnter * let g:buftabs_enabled = exists('g:buftabs_enabled') ? g:buftabs_enabled : 1
autocmd VimEnter,BufNew,BufEnter,BufWritePost * call s:buftabs_show(-1)
autocmd BufDelete * call s:buftabs_show(expand('<abuf>'))
if version >= 700
  autocmd InsertLeave,VimResized * call s:buftabs_show(-1)
endif
"}}}

" Restore 'cpoptions' {{{
let &cpo = s:save_cpo
" }}}
" vim:set et fdm=marker ft=vim ts=2 sw=2 sts=2:

