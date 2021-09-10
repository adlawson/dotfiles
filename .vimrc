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

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'

Plug 'preservim/nerdcommenter'

Plug 'prabirshrestha/asyncomplete.vim'
Plug 'yami-beta/asyncomplete-omni.vim'

" ----------------------------------------------------------------------------
" Language support
" ----------------------------------------------------------------------------

Plug 'fatih/vim-go'

" ----------------------------------------------------------------------------
" Themes
" ----------------------------------------------------------------------------

" Solarized
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

" File type detection and hard defaults
augroup FileTypeDetect
  command! -nargs=* -complete=help Help vertical belowright help <args>
  autocmd FileType help wincmd L

  autocmd BufNewFile,BufRead *.hcl setf conf
  autocmd BufRead,BufNewFile *.gotmpl set filetype=gotexttmpl
  autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4
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
let g:solarized_termtrans = 1
colorscheme solarized8_flat
autocmd vimenter * ++nested colorscheme solarized8_flat
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
" vim-rooter
" ----------------------------------------------------------------------------

let g:rooter_patterns = ['.git']
let g:rooter_cd_cmd = 'lcd'
let g:rooter_silent_chdir = 1
let g:rooter_manual_only = 1

" ----------------------------------------------------------------------------
" vim-go
" ----------------------------------------------------------------------------

let g:go_highlight_structs = 1
let g:go_highlight_methods = 1
let g:go_highlight_functions = 1
let g:go_highlight_operators = 1
let g:go_def_mode = 'gopls'
let g:go_info_modei = 'gopls'
let g:go_imports_mode = "gopls"
let g:go_gopls_gofumpt = 1
let g:go_auto_type_info = 1
let g:go_imports_autosave = 1
let g:go_diagnostics_level = 2
let g:go_metalinter_autosave = 1
let g:go_gopls_complete_unimported = 1
let g:asyncomplete_auto_completeopt = 0

augroup Golang
  autocmd FileType go setlocal omnifunc=go#complete#Complete
  autocmd Filetype go inoremap <buffer> . .<C-x><C-o>
  autocmd FileType go nmap <leader>t <Plug>(go-test)
  autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
augroup END

function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

" ----------------------------------------------------------------------------
" fzf
" ----------------------------------------------------------------------------

let g:fzf_buffers_jump = 1
let g:fzf_layout = { 'down': '25%' }
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
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

autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

command! -nargs=* -bang Files call <SID>fzfFiles(<q-args>, <bang>0)
command! -nargs=* -bang Grep call <SID>fzfGrep(<q-args>, <bang>0)
command! -nargs=* -bang GitGrep call <SID>fzfGitGrep(<q-args>, <bang>0)
command! -nargs=* -bang GitFiles call <SID>fzfGitFiles(<q-args>, <bang>0)
call s:cmdAlias("Rg", "Grep")
call s:cmdAlias("GGrep", "GitGrep")
call s:cmdAlias("GFiles", "GitGrep")

" Files search with preview, from the root directory
function! s:fzfFiles(query, fullscreen)
  let options = { 'dir': FindRootDirectory() }
  let options = fzf#vim#with_preview(options, 'right', 'ctrl-/')
  call fzf#vim#files(a:query, options, a:fullscreen)
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

" ----------------------------------------------------------------------------
" asyncomplete
" ----------------------------------------------------------------------------

autocmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#omni#get_source_options({
  \ 'name': 'omni',
  \ 'allowlist': ['go'],
  \ 'blocklist': [],
  \ 'completor': function('asyncomplete#sources#omni#completor'),
  \ 'config': {
  \   'show_source_kind': 1,
  \ },
\ }))

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

" Netrw
map <silent> <C-E> :Explore<CR>
cnoreabbrev E Explore

" FZF
nnoremap <C-p> :Files<CR>
nnoremap <C-g> :Grep<CR>
nnoremap <ESC>p :Buffers<CR>

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

