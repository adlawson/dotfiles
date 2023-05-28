set nocompatible
filetype off
filetype plugin indent on

augroup vimrc
  autocmd!
augroup END

let mapleader      = ' '
let maplocalleader = ' '

let g:home = get(g:, 'home', expand('~'))
let g:vimroot = get(g:, 'vimroot', g:home.'/.config/nvim')

" ============================================================================
" Settings
" ============================================================================

set autochdir                   " chdir to directory of current buffer
set autoread                    " reload file if changed outside of vim
set backspace=indent,eol,start  " backspace erases previous inserts
set colorcolumn=80,120          " columns
set directory^=$HOME/.vim/tmp// " swap files under home directory
set encoding=UTF-8              " UTF-8 encoding
set expandtab                   " spaces rather than tabs
set exrc                        " use workspace .vimrc
set fillchars+=vert:\           " set the vertical split character to <space>
set hidden                      " keep files open in buffer
set history=10                  " command history
set hlsearch                    " highlight search
set ignorecase                  " case insensitive search
set incsearch                   " incremental search
set lazyredraw                  " only redraw if needed or on :redraw
set mouse=nicr                  " enable mouse support
set nobackup                    " no backup files
set noswapfile                  " no ~ swap files
set nowrap                      " disable word wrap
set nowritebackup               " no backup files written
set number                      " show line numbers
set ruler                       " show cursor position in status bar
set scrolloff=8                 " display 8 lines above/below cursor
set secure                      " secure exrc
set shiftwidth=4                " indents use 4 spaces
set showmatch                   " show matching brace
set showmode                    " show mode in status bar (insert/replace/...)
set showcmd                     " show typed command in status bar
set smartcase                   " case sensitive if uppercase is used
set smartindent                 " auto indenting
set smarttab                    " smart tab handling for indenting
set tabstop=4                   " tabs use 4 spaces
set termguicolors               " use theme gui colours rather than cterm
set timeoutlen=500              " length of time to wait before <esc>
set ttimeoutlen=50              " length of time to wait before <esc>
set wildmenu                    " command autocomplete
set wildmode=longest:full,full  " command autocomplete mode

" ----------------------------------------------------------------------------
" Runtime
" ----------------------------------------------------------------------------

if exists('g:vscode')
  exec 'source' g:vimroot.'/vscode.vim'
elseif has('nvim')
  exec 'source' g:vimroot.'/nvim.vim'
else
  exec 'source' g:vimroot.'/vim.vim'
endif

" ----------------------------------------------------------------------------
" Editor behaviour
" ----------------------------------------------------------------------------

autocmd BufEnter * silent! lcd %:p:h " chdir to current file
autocmd VimResized * wincmd =        " equal splits
autocmd FileType help wincmd L       " help splits vertically
autocmd FileType qf setlocal wrap    " quickfix soft wrap
autocmd FileType qf nnoremap <silent> <buffer> <cr> <cr>:cclose<cr>

let g:netrw_banner = 0
let g:netrw_browse_split = 0 "reuse window

set completeopt=menuone,noinsert,noselect
inoremap <expr> <cr> pumvisible() ? (complete_info().selected == -1 ? '<c-y><cr>' : '<c-y>') : '<cr>'

" ============================================================================
" Key bindings
" ============================================================================

" leader needs to be set before other bindings
let mapleader = ','
let maplocalleader = ','

" save a <shift> and allow ; to be used as :
nnoremap ; :

" movement in insert mode
inoremap <c-h> <c-o>h
inoremap <c-l> <c-o>a
inoremap <c-j> <c-o>j
inoremap <c-k> <c-o>k
inoremap <c-^> <c-o><c-^>

" movement in omnicomplete
inoremap <expr> <c-j> ("\<c-n>")
inoremap <expr> <c-k> ("\<c-p>")

" centre the cursor
nnoremap <space> zz

" close all buffers besides the current one
nnoremap <leader>o :only<cr>

" vertical split
inoremap <leader>w  <c-w>v
nnoremap <leader>w  <c-w>v
inoremap <leader>ww <c-w>v<c-w>l
nnoremap <leader>ww <c-w>v<c-w>l

" clear search
nnoremap <silent> <leader><space> :nohlsearch<cr>

" netrw
cnoreabbrev E Explore

" move a line up/down/left/right
" https://stackoverflow.com/questions/7501092/can-i-map-alt-key-in-vim
" https://stackoverflow.com/questions/5379837/mapping-alt-hjkl-in-insert-mode
nnoremap <silent> <c-k> :move-2<cr>
nnoremap <silent> <c-j> :move+<cr>
nnoremap <silent> <c-h> <<
nnoremap <silent> <c-l> >>
xnoremap <silent> <c-k> :move-2<cr>gv
xnoremap <silent> <c-j> :move'>+<cr>gv
xnoremap <silent> <c-h> <gv
xnoremap <silent> <c-l> >gv
xnoremap < <gv
xnoremap > >gv
vnoremap ˚ :m '<-2<cr>gv=gv

" ----------------------------------------------------------------------------
" Clipboard
" ----------------------------------------------------------------------------

" http://stackoverflow.com/questions/20186975/vim-mac-how-to-copy-to-clipboard
" https://github.com/pazams/d-is-for-delete
nnoremap x "_x
nnoremap X "_X
nnoremap c "_c
nnoremap C "_C
nnoremap d "_d
nnoremap D "_D
vnoremap d "_d
vnoremap D "_D
nnoremap s "_s
nnoremap S "_S

set clipboard^=unnamed
set clipboard^=unnamedplus
nnoremap <leader>d "+d
nnoremap <leader>D "+D
vnoremap <leader>d "+d
vnoremap <leader>D "+D
