"use Vim default settings
set nocompatible

"manage plugins with Vundle
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

"plugins
Bundle 'gmarik/vundle'
Bundle 'kien/ctrlp.vim'
Bundle 'sickill/vim-monokai'
Bundle 'scrooloose/nerdcommenter'
Bundle 'airblade/vim-gitgutter'

"reenable filetype hinting
filetype plugin indent on

"display settings
syntax on
set background=dark    "dark terminal
set nowrap             "disable word wrap
set textwidth=120      "text width
set colorcolumn=+0,-40 "columns
set scrolloff=8        "display 8 lines above/below cursor
set showmatch          "show matching brace
set showmode           "show mode in status bar (insert/replace/...)
set showcmd            "show typed command in status bar
set ruler              "show cursor position in status bar
set hlsearch           "highlight search
set incsearch          "incremental search
set number             "show line numbers

"editor settings
set ignorecase         "case insensitive search
set smartcase          "case sensitive if uppercase is used
set smartindent        "auto indenting
set smarttab           "smart tab handling for indenting
set expandtab          "spaces rather than tabs
set tabstop=4          "tabs use 4 spaces
set shiftwidth=4       "indents use 4 spaces
set autoread           "reload files changed outside session
set wildmenu           "command autocomplete
set wildmode=longest:full,full "command autocomplete mode

"system settings
set hidden             "remember undo after quit
set nobackup           "no backup ~ files
set noswapfile         "no swapfile
set history=1000       "command history

"colour scheme
autocmd ColorScheme * hi NonText ctermbg=none guibg=none
autocmd ColorScheme * hi LineNr ctermbg=none guibg=none
autocmd ColorScheme * hi Normal ctermbg=none guibg=none
autocmd ColorScheme * hi clear SignColumn
autocmd ColorScheme * hi ExtraWhitespace ctermbg=197 guibg=#f92672
autocmd ColorScheme * match ExtraWhitespace /\s\+$/ "highlight trailing whitespace
colorscheme Monokai "set colour scheme

"persistent undo across sessions
silent !mkdir ~/.vim/backups > /dev/null 2>&1
set undodir=~/.vim/backups
set undofile

"disable arrow keys
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>
