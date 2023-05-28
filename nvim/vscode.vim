" ============================================================================
" VSCode
" ============================================================================

" ----------------------------------------------------------------------------
" Key bindings
" ----------------------------------------------------------------------------

" window
nnoremap <leader>ww <Cmd>call VSCodeNotify('workbench.action.splitEditorRight')<CR>
xnoremap <leader>ww <Cmd>call VSCodeNotift('workbench.action.splitEditorRight')<CR>
nnoremap <leader>wq <Cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>
xnoremap <leader>wq <Cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>
nnoremap <leader>wj <Cmd>call VSCodeNotify('workbench.action.focusBelowGroup')<CR>
xnoremap <leader>wj <Cmd>call VSCodeNotify('workbench.action.focusBelowGroup')<CR>
nnoremap <leader>wk <Cmd>call VSCodeNotify('workbench.action.focusAfterGroup')<CR>
xnoremap <leader>wk <Cmd>call VSCodeNotify('workbench.action.focusAfterGroup')<CR>
nnoremap <leader>wh <Cmd>call VSCodeNotify('workbench.action.focusLeftGroup')<CR>
xnoremap <leader>wh <Cmd>call VSCodeNotify('workbench.action.focusLeftGroup')<CR>
nnoremap <leader>wl <Cmd>call VSCodeNotify('workbench.action.focusRightGroup')<CR>
xnoremap <leader>wl <Cmd>call VSCodeNotify('workbench.action.focusRightGroup')<CR>
nnoremap <leader>wo <Cmd>call VSCodeNotify('workbench.action.joinAllGroups')<CR>
xnoremap <leader>wo <Cmd>call VSCodeNotift('workbench.action.joinAllGroups')<CR>

" vsnetrw
command! E call VSCodeNotify('vsnetrw.open')
AlterCommand e[xplore] E
xnoremap e <Cmd>call VSCodeNotify('vsnetrw.open')<CR>
nnoremap e <Cmd>call VSCodeNotify('vsnetrw.open')<CR>

