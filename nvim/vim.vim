" ============================================================================
" Plugins
" ============================================================================

silent! if plug#begin(g:home.'/.vim/plugged')

Plug 'editorconfig/editorconfig-vim'
Plug 'preservim/nerdcommenter'

" ----------------------------------------------------------------------------
" Themes
" ----------------------------------------------------------------------------

Plug 'dracula/vim', { 'as': 'dracula' }

" ----------------------------------------------------------------------------
" END
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
