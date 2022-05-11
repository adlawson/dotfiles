set nocompatible
filetype plugin indent on

augroup vimrc
  autocmd!
augroup END

let s:darwin  = has('mac')
let s:windows = has('win32') || has('win64')
let mapleader      = ' '
let maplocalleader = ' '

" ============================================================================
" Plugins
" ============================================================================

silent! if plug#begin('~/.vim/plugged')

Plug 'editorconfig/editorconfig-vim'
Plug 'sheerun/vim-polyglot'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'

Plug 'preservim/nerdcommenter'

Plug 'prabirshrestha/asyncomplete.vim'
Plug 'yami-beta/asyncomplete-omni.vim'

Plug 'dense-analysis/ale'
Plug 'prettier/vim-prettier', {
  \ 'do': 'npm install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql'] }

" ----------------------------------------------------------------------------
" Language support
" ----------------------------------------------------------------------------

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

" ----------------------------------------------------------------------------
" Themes
" ----------------------------------------------------------------------------

" Solarized
Plug 'sainnhe/sonokai'
Plug 'lifepillar/vim-solarized8'
  let g:solarized_extra_hi_groups = 1

call plug#end()
endif

" ============================================================================
" Settings
" ============================================================================

set exrc                       " Use workspace .vimrc
set nowrap                     " Disable word wrap
set colorcolumn=80,120         " Columns
set scrolloff=8                " Display 8 lines above/below cursor
set showmatch                  " Show matching brace
set showmode                   " Show mode in status bar (insert/replace/...)
set showcmd                    " Show typed command in status bar
set ruler                      " Show cursor position in status bar
set hlsearch                   " Highlight search
set incsearch                  " Incremental search
set number                     " Show line numbers
set termguicolors              " Use theme gui colours rather than cterm
set ignorecase                 " Case insensitive search
set smartcase                  " Case sensitive if uppercase is used
set smartindent                " Auto indenting
set smarttab                   " Smart tab handling for indenting
set expandtab                  " Spaces rather than tabs
set tabstop=4                  " Tabs use 4 spaces
set shiftwidth=4               " Indents use 4 spaces
set wildmenu                   " Command autocomplete
set wildmode=longest:full,full " Command autocomplete mode
set backspace=indent,eol,start " Backspace erases previous inserts
set timeoutlen=500             " Length of time to wait before <ESC>
set ttimeoutlen=50             " Length of time to wait before <ESC>
set hidden                     " Keep files open in buffer
set nobackup                   " No backup files
set nowritebackup              " No backup files written
set noswapfile                 " No ~ swap files
set history=10                 " Command history
set mouse=nicr                 " Enable mouse support
set autochdir                  " Chdir to directory of current buffer
set encoding=UTF-8             " UTF-8
set lazyredraw                 " Only redraw if needed or on :redraw
set fillchars+=vert:\          " Set the vertical split character to <space>

" Clipboard
" http://stackoverflow.com/questions/20186975/vim-mac-how-to-copy-to-clipboard-without-pbcopy
set clipboard^=unnamed
set clipboard^=unnamedplus

" File type detection
augroup HelpFileType
  command! -nargs=* -complete=help Help vertical belowright help <args>
  autocmd FileType help wincmd L
augroup END

" ----------------------------------------------------------------------------
" Colours
" ----------------------------------------------------------------------------

" Syntax highlighting
syntax enable

" Set color scheme overrides
augroup ColorSchemeGroup
  autocmd!

  autocmd ColorScheme * hi Normal ctermbg=NONE guibg=NONE
  autocmd ColorScheme * hi NonText ctermbg=NONE guibg=NONE
  autocmd ColorScheme * hi clear LineNr
  autocmd ColorScheme * hi clear SignColumn
  autocmd ColorScheme * hi clear cursorLine
  autocmd ColorScheme * hi link ExtraWhitespace ErrorMsg

  autocmd ColorScheme * match ExtraWhitespace /\s\+$/
  autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
  autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  autocmd InsertLeave * match ExtraWhitespace /\s\+$/
  autocmd BufWinLeave * call clearmatches()
augroup END

" Light/Dark
set background=dark

" Solarized
"let g:solarized_termtrans = 1
"colorscheme solarized8_flat
"autocmd vimenter * ++nested colorscheme solarized8_flat
"autocmd ColorScheme * hi Terminal ctermbg=235 guibg=#002b36

" Sonokai
let g:sonokai_style = 'maia'
let g:sonokai_better_performance = 1
let g:sonokai_transparent_background = 1

colorscheme sonokai
autocmd vimenter * ++nested colorscheme sonokai
autocmd ColorScheme * hi Terminal ctermbg=235 guibg=#002b36

" ----------------------------------------------------------------------------
" Behaviour
" ----------------------------------------------------------------------------

" Enter into directory of the current file
autocmd BufEnter * silent! lcd %:p:h

" Resize the splits to be equal
autocmd VimResized * wincmd =

" Netrw
let g:netrw_banner = 0
let g:netrw_browse_split = 0 "reuse window

" Omnifunc
set completeopt=menuone,noinsert,noselect,popup
set completepopup=border:off,align:menu
inoremap <expr> <cr> pumvisible() ? (complete_info().selected == -1 ? '<C-y><CR>' : '<C-y>') : '<CR>'

" ----------------------------------------------------------------------------
" Helpers
" ----------------------------------------------------------------------------

function! s:cmdAlias(src, target)
  exec 'cnoreabbrev <expr> '.a:src
    \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:src.'")'
    \ .'? ("'.a:target.'") : ("'.a:src.'"))'
endfunction

" ============================================================================
" Plugin settings
" ============================================================================

" ----------------------------------------------------------------------------
" vim-polyglot
" ----------------------------------------------------------------------------
let g:polyglot_disabled = ['autoindent', 'sensible']

" ----------------------------------------------------------------------------
" vim-rooter
" ----------------------------------------------------------------------------

let g:rooter_patterns = ['.git']
let g:rooter_cd_cmd = 'lcd'
let g:rooter_silent_chdir = 1
let g:rooter_manual_only = 1

" ----------------------------------------------------------------------------
" vim-prettier
" ----------------------------------------------------------------------------

let g:prettier#exec_cmd_async = 1
let g:prettier#quickfix_auto_focus = 0
let g:prettier#autoformat_require_pragma = 0
let g:prettier#autoformat_config_present = 1

" ----------------------------------------------------------------------------
" ale
" ----------------------------------------------------------------------------

let g:ale_completion_autoimport = 1
let g:ale_linters_explicit = 1
let g:ale_linters = {
  \ 'javascript': ['eslint'] }

" ----------------------------------------------------------------------------
" fzf
" ----------------------------------------------------------------------------

let g:fzf_buffers_jump = 1
let g:fzf_layout = { 'down': '25%' }
let g:fzf_colors = {
  \ 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

if executable('fd')
  let $FZF_DEFAULT_COMMAND = 'fd --type f --hidden --follow --exclude .git'
endif

autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

command! -nargs=* -bang Files call <SID>fzfFiles(<q-args>, <bang>0)
command! -nargs=* -bang AllFiles call <SID>fzfAllFiles(<q-args>, <bang>0)
command! -nargs=* -bang Grep call <SID>fzfGrep(<q-args>, <bang>0)
command! -nargs=* -bang GitGrep call <SID>fzfGitGrep(<q-args>, <bang>0)
command! -nargs=* -bang GitFiles call <SID>fzfGitFiles(<q-args>, <bang>0)
call s:cmdAlias("All", "AllFiles")
call s:cmdAlias("Rg", "Grep")
call s:cmdAlias("GGrep", "GitGrep")
call s:cmdAlias("GFiles", "GitGrep")

" Files search with preview, from the root directory
function! s:fzfFiles(query, fullscreen)
  let options = { 'dir': FindRootDirectory() }
  let options = fzf#vim#with_preview(options, 'right', 'ctrl-/')
  call fzf#vim#files(a:query, options, a:fullscreen)
endfunction

" All files with a search preview, from the root directory
function! s:fzfAllFiles(query, fullscreen)
  let fd_command = 'fd --type f --hidden --follow --exclude .git --no-ignore . '.expand(a:query)
  let options = { 'dir': FindRootDirectory(), 'source': fd_command }
  let options = fzf#vim#with_preview(options, 'right', 'ctrl-/')
  call fzf#run(fzf#wrap(options, a:fullscreen))
endfunction

" RG with preview, from the root directory
function! s:fzfGrep(query, fullscreen)
  let rg_command = '
    \ rg --column --line-number --no-heading --fixed-strings --smart-case --no-ignore --hidden --color "always"
    \ -g "!{.git,node_modules,vendor,third_party}/*" %s
    \ || true'
  let initial_command = printf(rg_command, shellescape(a:query))
  let reload_command = printf(rg_command, '{q}')
  let options =
  \ { 'dir': FindRootDirectory(),
    \ 'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command] }
  let options  = fzf#vim#with_preview(options, 'right', 'ctrl-/')
  call fzf#vim#grep(initial_command, 1, options, a:fullscreen)
endfunction

" Git Grep with preview, from the root directory
function! s:fzfGitGrep(query, fullscreen)
  let git_grep = 'git grep --line-number -- '.shellescape(a:query)
  let options = { 'dir': FindRootDirectory() }
  let options = fzf#vim#with_preview(options, 'right', 'ctrl-/')
  call fzf#vim#grep(git_grep, 1, options, a:fullscreen)
endfunction

" Git tracked files search with preview, from the root directory
function! s:fzfGitFiles(query, fullscreen)
  let options = { 'dir': FindRootDirectory() }
  let options = fzf#vim#with_preview(options, 'right', 'ctrl-/')
  call fzf#vim#gitfiles(a:query, options, a:fullscreen)
endfunction

" ============================================================================
" Keybindings
" ============================================================================

" Leader should be set before other keybindings
let mapleader = ','

" Save a <SHIFT> and allow ; to be used as :
nnoremap ; :

" Movement in insert mode
inoremap <C-h> <C-o>h
inoremap <C-l> <C-o>a
inoremap <C-j> <C-o>j
inoremap <C-k> <C-o>k
inoremap <C-^> <C-o><C-^>

" Movement in omnicomplete
inoremap <expr> <C-j> ("\<C-n>")
inoremap <expr> <C-k> ("\<C-p>")

" Centre the cursor
nnoremap <space> zz

" Close all buffers besides the current one
nnoremap <leader>o :only<CR>

" Vertical split and move cursor to it
inoremap <leader>w <C-w>v<C-w>l
nnoremap <leader>w <C-w>v<C-w>l

" Clear search
nnoremap <silent> <leader><space> :nohlsearch<CR>

" Toggle soft line break in the current buffer
nnoremap <leader>b :setlocal wrap! linebreak<CR>

" Netrw
map <silent> <C-E> :Explore<CR>
cnoreabbrev E Explore

" FZF
nnoremap <C-p> :Files<CR>
nnoremap <C-g> :Grep<CR>

" Move a line up/down/left/right
" https://stackoverflow.com/questions/7501092/can-i-map-alt-key-in-vim
" https://stackoverflow.com/questions/5379837/is-it-possible-to-mapping-alt-hjkl-in-insert-mode
nnoremap <silent> <C-k> :move-2<cr>
nnoremap <silent> <C-j> :move+<cr>
nnoremap <silent> <C-h> <<
nnoremap <silent> <C-l> >>
xnoremap <silent> <C-k> :move-2<cr>gv
xnoremap <silent> <C-j> :move'>+<cr>gv
xnoremap <silent> <C-h> <gv
xnoremap <silent> <C-l> >gv
xnoremap < <gv
xnoremap > >gv
vnoremap ˚ :m '<-2<CR>gv=gv

