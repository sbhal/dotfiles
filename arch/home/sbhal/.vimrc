execute pathogen#infect()
"call pathogen#helptags()

"first entry for incompatability
set nocompatible

"syntax support on
syntax on
syntax enable
filetype plugin on
set number

"set vim to use 256 colors
"set t_Co=256

"This uses indentation from the ftplugin filetype.vim
filetype plugin indent on

" Necessary to show Unicode glymphs
set encoding=utf-8

" set the search scan to wrap lines
set wrapscan
" otherwise
"set nowrap
set wrap

"set paste

"highlight search
set hlsearch

"search results shows in realtime; partial serach results are displayed
set incsearch

"showcmd shows no of lines selected in visual mode and partial commands
set showcmd

"shows matching braces for some time when inserting a brace
set showmatch

"shows line and column in lower right of screen
set ruler

"buffers become hidden when some changes are done to it
"when you try to move to next buffer, vim will throw an error askin you to
"save changes, this can be avoided by set hidden
set hidden

"c file indent
"set cindent

"indents and unindents after { and }
"set smartindent

"Indents next line based on previous line indentation
"set autoindent

"command set above 2 lines
"set ch=2

"No swap file will be crated and maintained
set noswapfile

set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar

"to make gvim enter fulscreen (for windows only)
"au GUIEnter * simalt ~x

" When the page starts to scroll, keep the cursor 8 lines from the top and 4
" from the bottom

set scrolloff=4

"tab is equal to 4 spaces
set tabstop=4
set expandtab

">> or << will make move 2 spaces OR visual selection + >/<        
set shiftwidth=4

"when expandtab is set, backspace will delete all 4 spaces
"Softtabstop takes precedence over tabstop; all new tabs are dictated 
"by softtabstop but previous tabs will be by tabstop
set softtabstop=4

"you can go anywhere
set virtualedit=all

" At least let yourself know what mode you're in
set showmode

" Enable enhanced command-line completion. Presumes you have compiled with +wildmenu.  See :help 'wildmenu'
set wildmenu

"smartcase will have insensitive search in case of all lower and sensitive in
"case of any capital letter && ignorecase is req for smartcase to work
set smartcase
set ignorecase

" cd to the directory containing the file in the buffer
"nmap ,f :echo expand('%:p') <CR>
 
" disable arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

"make utility
map cn <esc>:cn<cr>
map cp <esc>:cp<cr>
" tell Vim to always put a status line in, even if there is only one window
"set laststatus=2

" Keep some stuff in the history
set history=100


"if has('gui_running')
"    set background=light
"else
"    set background=dark
"endif

"=====colorscheme desert=====
"set background=dark
"colorscheme desert
"colorscheme molokai


"=====colorscheme solarized=====
"let g:solarized_termtrans = 1
"let g:solarized_termcolors = 256
"let g:solarized_visibility = "high"
"let g:solarized_constrast = "high"
"let g:solarized_termcolors=16
"set background=dark
"colorscheme solarized

"=====colorscheme pyte=====
"set background=dark
"colorscheme pyte

"=====colorscheme moria=====
"set background=dark
"set background=light
"colorscheme moria

"set gfn=Inconsolata:h11:cANSI
"set gfn=Consolas:h10:cANSI


au FileType mail call FT_mail()

function FT_mail()
    set nocindent
    set noautoindent
    set textwidth=68
    " reformat for 72 char lines
    " normal gggqGgg
    " settings
    setlocal spell spelllang=en
    " setlocal fileencoding=iso8859-1,utf-8
    set fileencodings=iso8859-1,utf-8
    " abbreviations
    iabbr  gd Good Day!
endfunction

" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
" filetype plugin on

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
" set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: This enables automatic indentation as you type.
" filetype indent on

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_CompileRule_pdf = 'xelatex -interaction=nonstopmode $*'


" Allow saving of files as sudo when I forgot to start vim using sudo
" tee sends the output to both standard output and file also.
cmap w!! w !sudo tee > /dev/null %
