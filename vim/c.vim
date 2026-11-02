" Enable C/C++ support through CoC and clangd.
if index(get(g:, 'coc_global_extensions', []), 'coc-clangd') < 0
  let g:coc_global_extensions =
        \ get(g:, 'coc_global_extensions', []) + ['coc-clangd']
endif

packadd! termdebug

" Build and debug one GoogleTest from a Trident test or source buffer.
" With no argument, use the nearest TEST/TEST_F above the cursor.
" From a non-test buffer, pass the test name as Suite.Test.
function! s:debug_trident_test(...) abort
  if exists(':Break') == 2
    echoerr 'A Termdebug session is already running; quit GDB before starting another'
    return
  endif

  let l:file = expand('%:p')
  let l:git_dir = finddir('.git', fnamemodify(l:file, ':h') . ';')
  if empty(l:git_dir)
    echoerr 'Could not find the project root'
    return
  endif
  let l:root = fnamemodify(l:git_dir, ':p:h:h')

  if l:file =~# '/service/shared/'
    let l:binary = l:root . '/service/.build/Debug/shared/test/trident_shared_tests'
    let l:work_dir = l:root . '/service/.build/Debug/shared/test'
  elseif l:file =~# '/service/service/'
    let l:binary = l:root . '/service/.build/Debug/service/test/trident_service_tests'
    let l:work_dir = l:root . '/service/.build/Debug/service/test'
  else
    echoerr 'Cannot select a Trident test binary for ' . l:file
    return
  endif

  if a:0
    let l:filter = a:1
    let l:parts = split(l:filter, '\.')
    if len(l:parts) != 2 || l:parts[0] !~# '^\h\w*$' || l:parts[1] !~# '^\h\w*$'
      echoerr 'Expected one exact GoogleTest name: Suite.Test'
      return
    endif
    let [l:suite, l:test] = l:parts
  else
    let l:test_line = search('^\s*TEST\%(_F\)\?\s*(', 'bnWc')
    if !l:test_line
      echoerr 'No TEST or TEST_F found above the cursor'
      return
    endif

    " Join a few lines so split TEST(...) declarations are supported too.
    let l:declaration = join(
          \ getline(l:test_line, min([l:test_line + 5, line('$')])), ' ')
    let l:match = matchlist(
          \ l:declaration,
          \ '^\s*TEST\%(_F\)\?\s*(\s*\(\h\w*\)\s*,\s*\(\h\w*\)\s*)')
    if empty(l:match)
      echoerr 'Could not parse the GoogleTest declaration near line ' . l:test_line
      return
    endif
    let [l:suite, l:test] = [l:match[1], l:match[2]]
    let l:filter = l:suite . '.' . l:test
  endif

  " Save this buffer so the incremental build contains what is on screen.
  update
  echo 'Building Debug tests...'
  let l:build_output = systemlist(
        \ 'make -C ' . shellescape(l:root) . ' build-service-dev BUILD_TYPE=Debug')
  if v:shell_error
    call setqflist([], 'r', {
          \ 'title': 'Debug test build',
          \ 'lines': l:build_output,
          \ })
    copen
    echoerr 'The test build failed; see the quickfix window'
    return
  endif

  if !executable(l:binary)
    echoerr 'Test executable was not produced: ' . l:binary
    return
  endif

  echom 'Debugging ' . l:filter
  execute 'TermdebugCommand ' . fnameescape(l:binary)
        \ . ' --gtest_filter=' . l:filter
  call TermDebugSendCommand('cd ' . shellescape(l:work_dir))

  " GoogleTest expands TEST(Suite, Name) to Suite_Name_Test::TestBody().
  " Breaking on that symbol stops at the beginning of this test only.
  execute 'Break ' . l:suite . '_' . l:test . '_Test::TestBody()'
  Run
endfunction

command! -nargs=? Debug call <SID>debug_trident_test(<f-args>)
nnoremap <silent> <leader>dt :Debug<CR>

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
  " autocmd FileType c,cpp nnoremap <silent><buffer> <leader>e :call CocActionAsync('diagnosticInfo')<CR>
augroup END
