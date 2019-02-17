"use Vim default settings
set nocompatible

"manage plugins with Vundle
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"plugins
Plugin 'airblade/vim-gitgutter'
Plugin 'derekwyatt/vim-scala'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'fatih/vim-go'
Plugin 'gmarik/Vundle.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'vim-scripts/desertEx'

"reenable filetype hinting
call vundle#end()
filetype plugin indent on

"display settings
syntax on
set nowrap             "disable word wrap
set colorcolumn=80,120 "columns
set scrolloff=8        "display 8 lines above/below cursor
set showmatch          "show matching brace
set showmode           "show mode in status bar (insert/replace/...)
set showcmd            "show typed command in status bar
set ruler              "show cursor position in status bar
set hlsearch           "highlight search
set incsearch          "incremental search
set number             "show line numbers
set termguicolors      "use theme hex colours rather than xterm

"editor settings
set ignorecase         "case insensitive search
set smartcase          "case sensitive if uppercase is used
set smartindent        "auto indenting
set smarttab           "smart tab handling for indenting
set expandtab          "spaces rather than tabs
set tabstop=4          "tabs use 4 spaces
set shiftwidth=4       "indents use 4 spaces
set wildmenu           "command autocomplete
set wildmode=longest:full,full "command autocomplete mode
set backspace=indent,eol,start "backspace erases previous inserts and autoindent
set timeoutlen=500     "length of time to wait before <Esc>
set ttimeoutlen=50     "length of time to wait before <Esc>

"system settings
set hidden             "keep files open in buffer
set nobackup           "no backup files
set nowritebackup      "no backup files written
set noswapfile         "no ~ swap files
set history=10         "command history
set mouse=nicr         "enable mouse support

"ignored patterns
set wildignore+=*~,*.pid,**/cache/*,**/log/*,**/_build/*,*.beam,**/target/*
set wildignore+=**/test/report/*,**/vendor/**/test*,**/node_modules/**/test*

"netrw
let g:netrw_banner = 0
let g:netrw_winsize = 25

"vim-go
let g:go_highlight_structs = 1
let g:go_highlight_methods = 1
let g:go_highlight_functions = 1
let g:go_highlight_operators = 1

"colour scheme
augroup ColorSchemeGroup
    autocmd!
    autocmd ColorScheme * hi Normal ctermbg=NONE guibg=NONE
    autocmd ColorScheme * hi NonText ctermbg=NONE guibg=NONE
    autocmd ColorScheme * hi LineNr cterm=NONE gui=NONE
    autocmd ColorScheme * hi colorcolumn ctermbg=237 guibg=#15212e
    autocmd ColorScheme * hi Type guifg=#87afaf gui=bold ctermfg=109 cterm=bold
    autocmd ColorScheme * hi clear SignColumn
    autocmd ColorScheme * hi ExtraWhitespace ctermbg=210 guibg=salmon
    autocmd ColorScheme * hi cursorLine ctermbg=NONE guibg=NONE
    autocmd ColorScheme * match ExtraWhitespace /\s\+$/
    autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
    autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
    autocmd InsertLeave * match ExtraWhitespace /\s\+$/
    autocmd BufWinLeave * call clearmatches()
augroup END
silent! colorscheme desertEx

"command & leader shortcuts and alternatives
map , <leader>
nnoremap ; :
nnoremap \ ,

"netrw
cnoreabbrev E Explore
cnoreabbrev e Explore

"clear search
nmap <silent> <leader>/ :nohlsearch<CR>

"save with sudo
command! -nargs=0 WriteWithSudo :w !sudo tee % >/dev/null
nnoremap <leader>ww :WriteWithSudo<CR>

"create current directory
command! -nargs=0 Mkdir !mkdir -p %:h
cnoreabbrev mkdir Mkdir

"trailing whitespace
command! -nargs=0 RemoveExtraWhitespace :%s/\s\+$//
nnoremap <leader>rw :RemoveExtraWhitespace<CR>

"vim-go abbreviations
cnoreabbrev gobuild GoBuild
cnoreabbrev godef GoDef
cnoreabbrev godrop GoDrop
cnoreabbrev goimport GoImport
cnoreabbrev gotest GoTest
cnoreabbrev gotestfunc GoTestFunc
cnoreabbrev build GoBuild
cnoreabbrev def GoDef
cnoreabbrev drop GoDrop
cnoreabbrev import GoImport
cnoreabbrev test GoTest
cnoreabbrev testfunc GoTestFunc

"move a line of text using ALT+[jk]
"https://stackoverflow.com/questions/7501092/can-i-map-alt-key-in-vim
"https://stackoverflow.com/questions/5379837/is-it-possible-to-mapping-alt-hjkl-in-insert-mode
nnoremap ∆ :m .+1<CR>==
nnoremap ˚ :m .-2<CR>==
inoremap ∆ <Esc>:m .+1<CR>==gi
inoremap ˚ <Esc>:m .-2<CR>==gi
vnoremap ∆ :m '>+1<CR>gv=gv
vnoremap ˚ :m '<-2<CR>gv=gv
