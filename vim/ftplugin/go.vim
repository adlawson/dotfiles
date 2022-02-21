" ----------------------------------------------------------------------------
" Editor
" ----------------------------------------------------------------------------

" Hard defaults
setlocal noexpandtab tabstop=4 shiftwidth=4

" ----------------------------------------------------------------------------
" vim-go
" ----------------------------------------------------------------------------

let b:go_highlight_structs = 1
let b:go_highlight_methods = 1
let b:go_highlight_functions = 1
let b:go_highlight_operators = 1
let b:go_def_mode = 'gopls'
let b:go_info_modei = 'gopls'
let b:go_imports_mode = "gopls"
let b:go_gopls_gofumpt = 1
let b:go_auto_type_info = 1
let b:go_imports_autosave = 1
let b:go_diagnostics_level = 2
let b:go_metalinter_autosave = 1
let b:go_gopls_complete_unimported = 1
let b:asyncomplete_auto_completeopt = 0

nmap <buffer> <leader>d :GoDef<CR>
nmap <buffer> <leader>t <Plug>(go-test)
nmap <buffer> <leader>b :<C-u>call <SID>build_go_files()<CR>

inoremap <buffer> . .<C-x><C-o>
setlocal omnifunc=go#complete#Complete

function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
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
