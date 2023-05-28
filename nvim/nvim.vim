" ============================================================================
" Plugins
" ============================================================================

silent! if plug#begin(g:vimroot.'/git/plugged')

let g:polyglot_disabled = ['autoindent', 'sensible'] " before plugin

Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'editorconfig/editorconfig-vim'
Plug 'embear/vim-localvimrc'
Plug 'folke/trouble.nvim'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim' " required by null-ls.vim and telescope.nvim
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'preservim/nerdcommenter'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'vim-test/vim-test'

" ----------------------------------------------------------------------------
" Themes
" ----------------------------------------------------------------------------

Plug 'dracula/vim', { 'as': 'dracula' }

" ----------------------------------------------------------------------------
" End
" ----------------------------------------------------------------------------

call plug#end()
endif

" ============================================================================
" Settings
" ============================================================================

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

colorscheme dracula
autocmd VimEnter * ++nested colorscheme dracula
autocmd ColorScheme * hi Terminal ctermbg=235 guibg=#002b36

" ============================================================================
" Key bindings
" ============================================================================

" ----------------------------------------------------------------------------
" telescope
" ----------------------------------------------------------------------------

nnoremap <silent> <expr> <c-p> ':Telescope find_files cwd='.FindRootDirectory().'/<cr>'
nnoremap <silent> <expr> <leader>pf ':Telescope find_files cwd='.FindRootDirectory().'/<cr>'
nnoremap <silent> <expr> <leader>pg ':Telescope live_grep cwd='.FindRootDirectory().'/<cr>'
nnoremap <silent> <leader>pb :Telescope buffers<cr>

" ============================================================================
" Plugin settings
" ============================================================================

" ----------------------------------------------------------------------------
" localvimrc
" ----------------------------------------------------------------------------

let g:localvimrc_name = ['.vimrc', '.nvimrc']
let g:localvimrc_file_directory_only = 1

" ----------------------------------------------------------------------------
" rooter
" ----------------------------------------------------------------------------

let g:rooter_patterns = ['.git', '.editorconfig', 'go.work']
let g:rooter_cd_cmd = 'lcd'
let g:rooter_silent_chdir = 1
let g:rooter_manual_only = 1

" ----------------------------------------------------------------------------
" lua
" ----------------------------------------------------------------------------

lua require('cmp-config')
lua require('lsp-config')
lua require('telescope-config')
lua require('treesitter-config')
lua require('trouble-config')
