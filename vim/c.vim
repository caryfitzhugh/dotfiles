" Enable C/C++ support through CoC and clangd.
if index(get(g:, 'coc_global_extensions', []), 'coc-clangd') < 0
  let g:coc_global_extensions =
        \ get(g:, 'coc_global_extensions', []) + ['coc-clangd']
endif

packadd! termdebug

augroup coc_c
  autocmd!

  " Keep CoC mappings local to C and C++ buffers.
  autocmd FileType c,cpp nmap <silent><buffer> [g <Plug>(coc-diagnostic-prev)
  autocmd FileType c,cpp nmap <silent><buffer> ]g <Plug>(coc-diagnostic-next)
  autocmd FileType c,cpp nmap <silent><buffer> gd <Plug>(coc-definition)
  autocmd FileType c,cpp nmap <silent><buffer> gy <Plug>(coc-type-definition)
  autocmd FileType c,cpp nmap <silent><buffer> gi <Plug>(coc-implementation)
  autocmd FileType c,cpp nmap <silent><buffer> gr <Plug>(coc-references)
  autocmd FileType c,cpp nmap <silent><buffer> <leader>rn <Plug>(coc-rename)

  autocmd FileType c,cpp nnoremap <silent><buffer> K
        \ :call CocActionAsync('doHover')<CR>
  autocmd FileType c,cpp nnoremap <silent><buffer> <leader>e
        \ :call CocActionAsync('diagnosticInfo')<CR>
augroup END
