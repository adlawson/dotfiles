" ============================================================================
" Plugins
" ============================================================================

silent! if plug#begin(g:vimroot.'/plugged')

Plug 'tpope/vim-commentary'

" ----------------------------------------------------------------------------
" End
" ----------------------------------------------------------------------------

call plug#end()
endif

" ----------------------------------------------------------------------------
" Key bindings
" ----------------------------------------------------------------------------

" window
nnoremap <leader>we <cmd>call VSCodeNotify('workbench.action.splitEditorRight')<cr>
xnoremap <leader>we <cmd>call VSCodeNotift('workbench.action.splitEditorRight')<cr>
nnoremap <leader>wq <cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<cr>
xnoremap <leader>wq <cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<cr>
nnoremap <leader>ww <cmd>call VSCodeNotify('workbench.action.focusNextGroup')<cr>
xnoremap <leader>ww <cmd>call VSCodeNotift('workbench.action.focusNextGroup')<cr>
nnoremap <leader>wj <cmd>call VSCodeNotify('workbench.action.focusBelowGroup')<cr>
xnoremap <leader>wj <cmd>call VSCodeNotify('workbench.action.focusBelowGroup')<cr>
nnoremap <leader>wk <cmd>call VSCodeNotify('workbench.action.focusAfterGroup')<cr>
xnoremap <leader>wk <cmd>call VSCodeNotify('workbench.action.focusAfterGroup')<cr>
nnoremap <leader>wh <cmd>call VSCodeNotify('workbench.action.focusLeftGroup')<cr>
xnoremap <leader>wh <cmd>call VSCodeNotify('workbench.action.focusLeftGroup')<cr>
nnoremap <leader>wl <cmd>call VSCodeNotify('workbench.action.focusRightGroup')<cr>
xnoremap <leader>wl <cmd>call VSCodeNotify('workbench.action.focusRightGroup')<cr>
nnoremap <leader>wo <cmd>call VSCodeNotify('workbench.action.joinAllGroups')<cr>
xnoremap <leader>wo <cmd>call VSCodeNotify('workbench.action.joinAllGroups')<cr>

" finder
nnoremap <leader>p <cmd>call VSCodeNotify('workbench.action.quickOpen')<cr>

" vim-commentary
xnoremap <leader>ci <Plug>Commentary
nnoremap <leader>ci <plug>Commentary
onoremap <leader>ci <plug>Commentary
nnoremap <leader>ci <plug>CommentaryLine
nnoremap <leader>cu <plug>Commentary<plug>Commentary

" vsnetrw
command! E call VSCodeNotify('vsnetrw.open')
AlterCommand e[xplore] E
xnoremap <leader>e <cmd>call VSCodeNotify('vsnetrw.open')<cr>
nnoremap <leader>e <cmd>call VSCodeNotify('vsnetrw.open')<cr>

