"map            recursive mapping
"noremap        non recursive mapping
":map j gg
":map Q j  (Q is gg i.e recursive mapping)
"vmap and vnoremap are for visual mode
"nmap and nnoremap are for normal mode
"imap and inoremap are for insert mode

" "add          - deletes current line and store in register a
" :.,$j         - operation j i.e join line from current line to last line
" :.,$v/bar/d   - from current line to last line delete all lines not containing bar
" :.,+21g/foo/d - delete any lines containing the string foo" from the current one through the next 21 lines
" :g/re/p       - (grep)  for regular expression and print it
"

"first entry for incompatability
set nocompatible

let mapleader="\<Space>"

" PlugInstall
" PlugUpdate    Update all plugins
" PlugUpgrade   Upgrade vim plug itself
" PlugClean[!p]     Remove unused directories
call plug#begin('~/.vim/plugged')

Plug 'christoomey/vim-tmux-navigator'
"syntax files for different languages
Plug 'sheerun/vim-polyglot'
" adjusts 'shiftwidth' and 'expandtab' heuristically based on the current file
Plug 'tpope/vim-sleuth'
Plug 'junegunn/goyo.vim'
"Plug 'reedes/vim-pencil'
Plug 'vim-scripts/gitignore'
"Plug 'tpope/vim-surround'
"Plug 'tpope/vim-scriptease'
" :Tab /:
Plug 'godlygeek/tabular'
Plug 'morhetz/gruvbox'
"Plug 'w0ng/vim-hybrid'
Plug 'altercation/vim-colors-solarized'
"Plug 'jeaye/color_coded'
Plug 'mhinz/vim-startify'

Plug 'vasconcelloslf/vim-interestingwords'


Plug 'bling/vim-airline'
"let g:airline_theme='powerlineish'
"let g:airline_theme='solarized'
" ----- airblade/vim-gitgutter settings -----
" Required after having changed the colorscheme
hi clear SignColumn
" In vim-airline, only display "hunks" if the diff is non-zero
let g:airline#extensions#hunks#non_zero_only = 1
" Show PASTE if in paste mode
let g:airline_detect_paste=1
" Show airline for tabs too
let g:airline#extensions#tabline#enabled = 1

" Enable below only for patched font.
" Menlo-for-Powerline
let g:airline_powerline_fonts = 1


" Git Ninja; Use :Gblame
":Git add %             :Gwrite Stage the current file to the index
":Git checkout %        :Gread  Revert current file to last checked in version
":git commit            :Gcommit
":git status            :Gstatus ctrl-n and ctrl-p for moving b/w files
"       -               add/reset file (works in visual mode too)
"       <Enter>         open current file in the window below
"       p               run `git add –patch` for current file
"       C               invoke :Gcommit
":git edit index files  :Gedit  Edit index file which is to be commited
":git diff              :Gdiff  compare b/w index and working copy
"       On conflicted file - <target branch> <working copy> <merge branch>
"       Use diffget <buffer> at heap location or diffput from target/merge
"       branch file
"       c] and c[ can be used to move b/w heaps
"       :diffupdate can be used to update coloring
"       :only can be used to close all windows except working copy
Plug 'tpope/vim-fugitive'

"augroup pencil
"  autocmd!
"  autocmd FileType markdown,mkd call pencil#init()
"  autocmd FileType text         call pencil#init()
"augroup END

Plug 'Shougo/neocomplete.vim'
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
"" Disable AutoComplPop.
let g:acp_enableAtStartup=0
" Use neocomplete.
let g:neocomplete#enable_at_startup=1
" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

"Need already present tag file for first time
" :TagsGenerate!        force tag generation first time
"Plug 'szw/vim-tags'

""easytag is crap. slowed system as hell
"Plug 'xolox/vim-misc' | Plug 'xolox/vim-easytags'
"let g:easytags_async=1
"let g:easytags_dynamic_files = 2
"let g:easytags_resolve_links = 1
"let g:easytags_suppress_ctags_warning = 1
set tags=./tags,tags;/local/mnt/workspace/sbhal
"Forward traversal of the same name tag
nmap <Leader>tn :tnext<CR>
""Reverse traversal of the same name tag
nmap <Leader>tp :tprevious<CR>

"Plug 'mbbill/undotree'
"Plug 'scrooloose/nerdtree'

" leader leader <alphabet key>
"Plug 'Lokaltog/vim-easymotion'
Plug 'rking/ag.vim' | Plug 'Shougo/vimproc.vim', { 'do': 'make' } | Plug 'Shougo/neomru.vim' | Plug 'Shougo/unite.vim'
"Plug 'tsukkee/unite-tag'
Plug 'Shougo/unite-outline'
Plug 'hewes/unite-gtags'
"Plug 'junkblocker/codesearch' | Plug 'junkblocker/unite-codesearch'
"let g:unite_codesearch_command="$HOME/gocode/bin/csearch -m %d '%s'"

" leader a to search for word under cursor
noremap <Leader>a :Ag <cword> --ignore tags <cr>
vnoremap <Leader>a y:Ag <C-r>=fnameescape(@")<CR><CR>
" F11 and F12 to browse through results
"noremap <F11> :cpfile<cr>
"noremap <F12> :cnfile<cr>
"noremap <F11> :cprev<cr>
noremap <F12> :cnext<cr>


"Plug 'kien/ctrlp.vim'
"nnoremap <Leader>o :CtrlP<CR>
"" Now prefer git search for ctrlp completions
"let g:ctrlp_use_caching=0
"let g:ctrlp_working_path_mode='ra'
"if executable('ag')
"    set grepprg=ag\ --nogroup\ --nocolor
"
"    let g:ctrlp_user_command='ag %s -l --nocolor -g ""'
"else
"  let g:ctrlp_user_command=['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
"  let g:ctrlp_prompt_mappings={
"    \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
"    \ }
"endif



"Plug 'scrooloose/syntastic'
"" scrooloose/syntastic
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"let g:syntastic_always_populate_loc_list=1
"let g:syntastic_auto_loc_list=1
"let g:syntastic_check_on_open=1
"let g:syntastic_check_on_wq=0
"let g:syntastic_c_check_header=1
""let g:syntastic_c_include_dirs="../inc"
"let g:syntastic_c_no_include_search=1
"let g:syntastic_c_check_header=1

"Plug 'terryma/vim-multiple-cursors'

Plug 'Yggdroot/indentLine'
let g:indentLine_leadingSpaceEnabled=1
"Plug 'nathanaelkane/vim-indent-guides'
let g:indent_guides_enable_on_vim_startup=1
""From the second layer begins to visualize indented
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1
"Shortcuts i On / Off indent Visualization
:nmap <silent> <Leader>i <Plug>IndentGuidesToggle


" Group dependencies, vim-snippets depends on ultisnips
" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" " On-demand loading
" Code to execute when the plugin is loaded on demand
"Plug 'Valloric/YouCompleteMe', { 'for': ['cpp', 'c'] }
"autocmd! User YouCompleteMe call youcompleteme#Enable()

"Plug 'terryma/vim-expand-region'
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)


"jump to next hunk (change): ]c
"jump to previous hunk (change): [c
Plug 'airblade/vim-gitgutter'
let g:gitgutter_enabled=1
"let g:gitgutter_highlight_lines = 1
nmap <Leader>ha <Plug>GitGutterStageHunk
nmap <Leader>hu <Plug>GitGutterRevertHunk
nmap <Leader>hv <Plug>GitGutterPreviewHunk

" mx    marks current line with x
" 'x    goes to mark location
" m,    marks current line with next marker
" ']    next marker
" m/    search for markers in current buffer
" m<BS> delete all markers in all buffers
Plug 'kshenoy/vim-signature'

call plug#end()



"Copy & paste to system clipboard with <Space>p and <Space>y:
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

"Define shortcuts to close the current split window
nmap <Leader>q :q<CR>
"Enter visual line mode with <Space><Space>:
nmap <Leader><Leader> V

"Type <Space>w to save file (a lot faster than :w<Enter>):
nnoremap <Leader>w :w<CR>

"Without saving, exit vim
nmap <Leader>Q :qa<CR>!
"Write all files and exit
nmap <Leader>WQ :wa<CR>:q<CR>

"Quickly select text you just pasted:
noremap gV `[v`]

" za, open or close the current fold;
" zM, close all folds; zR, open all folds
"Based on code folding indentation or syntax
"Set foldmethod=indent
"set foldmethod=syntax
"Close collapsed code when you start vim
"set nofoldenable



"set spell spelllang=en_us

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

" st the search scan to wrap lines
set wrapscan
" otherwise
"set nowrap
set wrap

"set paste

set cursorline

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

filetype plugin on       " may already be in your .vimrc
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
"set tabstop=4
"set expandtab

">> or << will make move 2 spaces OR visual selection + >/<
"set shiftwidth=4

"when expandtab is set, backspace will delete all 4 spaces
"Softtabstop takes precedence over tabstop; all new tabs are dictated 
"by softtabstop but previous tabs will be by tabstop
"set softtabstop=4

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
"map <up> <nop>
"map <down> <nop>
"map <left> <nop>
"map <right> <nop>
"imap <up> <nop>
"imap <down> <nop>
"imap <left> <nop>
"imap <right> <nop>

"make utility
"map cn <esc>:cn<cr>
"map cp <esc>:cp<cr>
" tell Vim to always put a status line in, even if there is only one window
set laststatus=2

" Keep some stuff in the history
set history=100


if has('gui_running')
    set background=dark
    colorscheme solarized
else
    set background=dark
    colorscheme solarized
    "colorscheme gruvbox
endif

"colorscheme desert
"colorscheme molokai

"set gfn=Inconsolata:h11:cANSI
"set gfn=Consolas:h10:cANSI

nmap <Leader>d :bd<CR>


"Mark script
let g:mwDefaultHighlightingPalette='maximum'

""" <F5> calls make
"function Myscope() 

"if has('cscope')
"    set cscopetag cscopeverbose
"endif 
"command -nargs=0 Cscope cs add $VIMSRC/cscope.out $VIMSRC<CR>

"endfunction
"map <F9> :Cscope

"map <F9> :call Myscope()<CR>

"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"autocmd BufNewFile,BufRead *.c match OverLength /\%81v.\+/
set colorcolumn=81

"set timeoutlen=1500

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

"highlight ExtraWhitespace ctermbg=darkgreen guibg=lightgreen

set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

" Enter the middle-dot by pressing Ctrl-k then .M
set list listchars=tab:\|_,trail:.
set list lcs=trail:·,tab:»·
"set list

source ~/.vimrc_unity
