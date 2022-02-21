" ----------------------------------------------------------------------------
" ale
" ----------------------------------------------------------------------------

let b:ale_fix_on_save = 1
let b:ale_linters = ['prettier', 'eslint']
let b:ale_fixers = ['prettier', 'eslint']

nmap <buffer> <leader>d :ALEGoToDefinition<CR>
nmap <buffer> <leader>f :ALEFix<CR>

setlocal omnifunc=ale#completion#OmniFunc
