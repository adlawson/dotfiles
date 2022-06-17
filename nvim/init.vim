set nocompatible
filetype off
filetype plugin indent on

augroup vimrc
  autocmd!
augroup END

let mapleader      = ' '
let maplocalleader = ' '

" ============================================================================
" Plugins
" ============================================================================

silent! if plug#begin('~/.vim/plugged')

let g:polyglot_disabled = ['autoindent', 'sensible'] " before plugin

Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'editorconfig/editorconfig-vim'
Plug 'folke/trouble.nvim'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim' " required by null-ls.vim
Plug 'preservim/nerdcommenter'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'vim-test/vim-test'

" ----------------------------------------------------------------------------
" Themes
" ----------------------------------------------------------------------------

Plug 'sainnhe/sonokai'

" ----------------------------------------------------------------------------
" End
" ----------------------------------------------------------------------------

call plug#end()
endif

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
" Colors
" ----------------------------------------------------------------------------

syntax enable
set background=dark

augroup ExtraWhitespaceGroup
  autocmd!
  autocmd ColorScheme * hi link ExtraWhitespace TSDanger "ErrorMsg
  autocmd ColorScheme * match ExtraWhitespace /\s\+$/
  autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
  autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  autocmd InsertLeave * match ExtraWhitespace /\s\+$/
  autocmd BufWinLeave * call clearmatches()
augroup END

let g:sonokai_style = 'maia'
let g:sonokai_better_performance = 1
let g:sonokai_transparent_background = 1
let g:sonokai_colors_override = {'bg0': ['#002b36', '235'] }
colorscheme sonokai
autocmd VimEnter * ++nested colorscheme sonokai
autocmd ColorScheme * hi Terminal ctermbg=235 guibg=#002b36

" ----------------------------------------------------------------------------
" Editor behaviour
" ----------------------------------------------------------------------------

autocmd BufEnter * silent! lcd %:p:h " chdir to current file
autocmd VimResized * wincmd =        " equal splits
autocmd FileType help wincmd L       " help splits vertically
autocmd FileType qf setlocal wrap    " quickfix soft wrap

let g:netrw_banner = 0
let g:netrw_browse_split = 0 "reuse window

" autocomplete popup menu completes on <cr>
set completeopt=menuone,noinsert,noselect
let g:float_preview#docked = 0
inoremap <expr> <cr> pumvisible() ? (complete_info().selected == -1 ? '<c-y><cr>' : '<c-y>') : '<cr>'

" ============================================================================
" Plugin settings
" ============================================================================

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

autocmd! FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

command! -nargs=* -bang Files call <sid>fzf_files(<q-args>, <bang>0)
command! -nargs=* -bang FilesAll call <sid>fzf_filesAll(<q-args>, <bang>0)
command! -nargs=* -bang Grep call <sid>fzf_ripGrep(<q-args>, <bang>0)
command! -nargs=* -bang GitGrep call <sid>fzf_gitGrep(<q-args>, <bang>0)
command! -nargs=* -bang GitFiles call <sid>fzf_gitFiles(<q-args>, <bang>0)

" ----------------------------------------------------------------------------
" nvim-cmp
" ----------------------------------------------------------------------------

if has('nvim')
lua <<EOF
  local cmp = require "cmp"
  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  cmp.setup({
    sources = {
      { name = 'nvim_lsp' },
      { name = 'buffer' },
    },
    completion = {
      completeopt = 'menu,menuone,noinsert',
    },
    mapping = {
      ['<down>'] = cmp.mapping.scroll_docs(-4),
      ['<up>'] = cmp.mapping.scroll_docs(4),
      ['<c-k>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
      ['<c-j>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
      ["<tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),
      ['<esc>'] = cmp.mapping.close(),
      ['<cr>'] = cmp.mapping.confirm({ select = false }),
    },
  })

  vim.api.nvim_create_autocmd({"TextChangedI", "TextChangedP"}, {
    callback = function()
      local _, col = vim.api.nvim_win_get_cursor(0)
      local cursor = vim.api.nvim_get_current_line()[col]
      if foo and not string.match(cursor, '^\\w$') and cmp.visible() then
        cmp.close()
      end
    end,
    pattern = "*",
  })
EOF
endif

" ----------------------------------------------------------------------------
" trouble
" ----------------------------------------------------------------------------

if has('nvim')
lua << EOF
  require("trouble").setup {
    auto_open = true,
    auto_close = true,
    icons = false,
  }
EOF
endif

" ----------------------------------------------------------------------------
" vim-rooter
" ----------------------------------------------------------------------------

let g:rooter_patterns = ['.git', '.editorconfig', 'go.work']
let g:rooter_cd_cmd = 'lcd'
let g:rooter_silent_chdir = 1
let g:rooter_manual_only = 1

" ============================================================================
" Key bindings
" ============================================================================

" leader needs to be set before other bindings
let mapleader = ','

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

" vertical split and move cursor to it
" inoremap <leader>w <c-w>v<c-w>l
" nnoremap <leader>w <c-w>v<c-w>l
" vertical split without moving cursor to it
inoremap <leader>w <c-w>v
nnoremap <leader>w <c-w>v

" clear search
nnoremap <silent> <leader><space> :nohlsearch<cr>

" netrw
cnoreabbrev E Explore

" fzf
nnoremap <c-g> :Grep<cr>
nnoremap <c-p> :Files<cr>
nnoremap <c-t> :Buffers<cr>

" move a line up/down/left/right
" https://stackoverflow.com/questions/7501092/can-i-map-alt-key-in-vim
" https://stackoverflow.com/questions/5379837/is-it-possible-to-mapping-alt-hjkl-in-insert-mode
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

" http://stackoverflow.com/questions/20186975/vim-mac-how-to-copy-to-clipboard-without-pbcopy
" https://github.com/pazams/d-is-for-delete
nnoremap x "_x
nnoremap X "_X
nnoremap c "_c
nnoremap d "_d
nnoremap D "_D
vnoremap d "_d

if has('unnamedplus')
  set clipboard^=unnamed
  set clipboard^=unnamedplus
  nnoremap <leader>d "+d
  nnoremap <leader>D "+D
  vnoremap <leader>d "+d
else
  set clipboard=unnamed
  nnoremap <leader>d "*d
  nnoremap <leader>D "*D
  vnoremap <leader>d "*d
endif

" ============================================================================
" Languages
" ============================================================================

" ----------------------------------------------------------------------------
" go
" ----------------------------------------------------------------------------

lua <<EOF
  lspconfig = require "lspconfig"
  util = require "lspconfig/util"

  lspconfig.gopls.setup {
    cmd = {"gopls", "serve"},
    filetypes = {"go", "gomod", "gohtmltmpl", "gotexttmpl"},
    root_dir = util.root_pattern("go.work", "go.mod", ".git"),
    memoryMode = "DegradeClosed",
    settings = {
      gopls = {
        analyses = {
          fieldalignment = true,
          nilness = true,
          unusedparams = true,
          unusedwrite = true,
        },
        staticcheck = true,
        expandWorkspaceToModule = false,
      },
    },
    init_options = {
      codelenses = {
        generate = true,
        gc_details = true,
        test = true,
        tidy = true,
      },
    },
  }

  vim.diagnostic.config({
    update_in_insert = false,
  })

  function OrgImports(wait_ms)
    local params = vim.lsp.util.make_range_params()
    params.context = {only = {"source.organizeImports"}}
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
    for _, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          vim.lsp.util.apply_workspace_edit(r.edit, "UTF-8")
        else
          vim.lsp.buf.execute_command(r.command)
        end
      end
    end
  end

  local nullls = require "null-ls"
  nullls.setup({
    sources = {
      nullls.builtins.diagnostics.golangci_lint,
    },
})
EOF

autocmd BufWritePre *.go lua OrgImports(1000)
autocmd BufWritePre *.go lua vim.lsp.buf.formatting_sync(nil, 1000)
autocmd FileType go setlocal omnifunc=v:lua.vim.lsp.omnifunc

" ============================================================================
" Functions
" ============================================================================

" ----------------------------------------------------------------------------
" fzf
" ----------------------------------------------------------------------------

" fzf files with preview
function! s:fzf_files(query, fullscreen)
  call fzf#vim#files(a:query, s:fzf_withPreview({}), a:fullscreen)
endfunction

" fzf all files with preview
function! s:fzf_filesAll(query, fullscreen)
  let opts = { 'source': 'fd --type f --hidden --follow --exclude .git --no-ignore . '.expand(a:query) }
  call fzf#run(fzf#wrap(s:fzf_withPreview(opts), a:fullscreen))
endfunction

" fzf git grep with preview
function! s:fzf_gitGrep(query, fullscreen)
  if !s:fzf_gitRepo()
    echohl WarningMsg
    echom 'Not in git repo'
    echohl None
    return
  endif
  call s:fzf_wrapGrep('git grep --line-number -- '.shellescape(a:query), {}, a:fullscreen)
endfunction

" fzf git files with preview
function! s:fzf_gitFiles(query, fullscreen)
  call fzf#vim#gitfiles(a:query, s:fzf_withPreview({}), a:fullscreen)
endfunction

" fzf rip grep with preview
function! s:fzf_ripGrep(query, fullscreen)
  let rg = '
    \ rg --column --line-number --no-heading --fixed-strings --smart-case --no-ignore --hidden --color "always"
    \ -g "!{.git,node_modules,vendor,third_party}/*" %s
    \ || true'
  let cmd = printf(rg, shellescape(a:query))
  let opts = { 'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.printf(rg, '{q}')] }
  call s:fzf_wrapGrep(cmd, opts, a:fullscreen)
endfunction

function! s:fzf_gitRepo()
  let root = split(system('git rev-parse --show-toplevel'), '\n')[0]
  return v:shell_error ? v:false : v:true
endfunction

function! s:fzf_wrapGrep(cmd, opts, fullscreen)
  call fzf#vim#grep(a:cmd, v:true, s:fzf_withPreview(a:opts), a:fullscreen)
endfunction

function! s:fzf_withPreview(opts)
  let a:opts.dir = FindRootDirectory()
  return fzf#vim#with_preview(a:opts, 'right', 'ctrl-/')
endfunction
