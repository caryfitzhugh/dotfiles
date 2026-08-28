" JavaScript and TypeScript support through CoC.
for s:extension in ['coc-tsserver', 'coc-eslint']
  if index(get(g:, 'coc_global_extensions', []), s:extension) < 0
    let g:coc_global_extensions =
          \ get(g:, 'coc_global_extensions', []) + [s:extension]
  endif
endfor
unlet s:extension

" Show diagnostics beside the affected JS/TS line when Vim supports it.
let s:languages = '[javascript][javascriptreact][typescript][typescriptreact]'
let g:coc_user_config = get(g:, 'coc_user_config', {})
if !has_key(g:coc_user_config, s:languages)
  let g:coc_user_config[s:languages] = {}
endif
if !has_key(g:coc_user_config[s:languages], 'diagnostic.virtualText')
  let g:coc_user_config[s:languages]['diagnostic.virtualText'] = v:true
endif
unlet s:languages

augroup coc_javascript_typescript
  autocmd!

  " Language-server navigation and diagnostics.
  autocmd FileType javascript,javascriptreact,typescript,typescriptreact nmap <silent><buffer> [g <Plug>(coc-diagnostic-prev)
  autocmd FileType javascript,javascriptreact,typescript,typescriptreact nmap <silent><buffer> ]g <Plug>(coc-diagnostic-next)
  autocmd FileType javascript,javascriptreact,typescript,typescriptreact nmap <silent><buffer> gd <Plug>(coc-definition)
  autocmd FileType javascript,javascriptreact,typescript,typescriptreact nmap <silent><buffer> gy <Plug>(coc-type-definition)
  autocmd FileType javascript,javascriptreact,typescript,typescriptreact nmap <silent><buffer> gi <Plug>(coc-implementation)
  autocmd FileType javascript,javascriptreact,typescript,typescriptreact nmap <silent><buffer> gr <Plug>(coc-references)

  " Refactoring, fixes, hover documentation, and diagnostic details.
  autocmd FileType javascript,javascriptreact,typescript,typescriptreact nmap <silent><buffer> <leader>rn <Plug>(coc-rename)
  autocmd FileType javascript,javascriptreact,typescript,typescriptreact nmap <silent><buffer> <leader>ac <Plug>(coc-codeaction-cursor)
  autocmd FileType javascript,javascriptreact,typescript,typescriptreact nmap <silent><buffer> <leader>qf <Plug>(coc-fix-current)
  autocmd FileType javascript,javascriptreact,typescript,typescriptreact nnoremap <silent><buffer> K :call CocActionAsync('doHover')<CR>
  " autocmd FileType javascript,javascriptreact,typescript,typescriptreact nnoremap <silent><buffer> <leader>e :call CocActionAsync('diagnosticInfo')<CR>
  autocmd FileType javascript,javascriptreact,typescript,typescriptreact nnoremap <silent><buffer> <leader>oi :call CocActionAsync('runCommand', 'editor.action.organizeImport')<CR>

  " Trigger completion manually and format through the active language server.
  autocmd FileType javascript,javascriptreact,typescript,typescriptreact inoremap <silent><expr><buffer> <C-@> coc#refresh()
  autocmd FileType javascript,javascriptreact,typescript,typescriptreact nmap <silent><buffer> <leader>f <Plug>(coc-format-selected)
  autocmd FileType javascript,javascriptreact,typescript,typescriptreact xmap <silent><buffer> <leader>f <Plug>(coc-format-selected)
augroup END
