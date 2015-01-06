" This file is managed by adlawson/dotfiles
"
" Copyright (c) 2014 Andrew Lawson <http://adlawson.com>
"
" For the full copyright and license information, please view the LICENSE
" file that was distributed with this source code.

"use Vim default settings
set nocompatible

"manage plugins with Vundle
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#begin()

"plugins
Plugin 'gmarik/Vundle.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'airblade/vim-gitgutter'
Plugin 'jnurmine/Zenburn'
Plugin 'derekwyatt/vim-scala'
Plugin 'editorconfig/editorconfig-vim'

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
set nonumber           "hide line numbers

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

"system settings
set hidden             "keep files open in buffer
set nobackup           "no backup files
set nowritebackup      "no backup files written
set noswapfile         "no ~ swap files
set history=10         "command history

"ignored patterns
set wildignore+=*~,*.pid,**/cache,**/log*,**/_build,*.beam,**/target
set wildignore+=**/test/report,**/vendor/**/test*,**/node_modules/**/test*

"colour scheme
augroup ColorSchemeGroup
    autocmd!
    autocmd ColorScheme * match ExtraWhitespace /\s\+$/
    autocmd ColorScheme * hi ExtraWhitespace ctermbg=197 guibg=#f92672
    autocmd ColorScheme * hi Normal ctermbg=none guibg=none
    autocmd ColorScheme * hi clear LineNr
    autocmd ColorScheme * hi clear SignColumn
augroup END
let g:zenburn_unified_CursorColumn = 1
silent! colorscheme zenburn

"disable arrow keys
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>
