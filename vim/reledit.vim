" Explore
nnoremap <silent> <Leader>ed :Explore<CR>
" Quickly input the directory of the current file on the command line
cnoremap <expr> %% reledit#command_dir('%%')
" Need 'recursive' mapping here for %%
nmap <Leader>e :e %%
"nmap <Leader>ew :e %%
"nmap <Leader>ev :vs %%
"nmap <Leader>es :sp %%
"nmap <Leader>et :tabe %%

" Get the directory of a file
" - On Ex command lines, returns the directory of the file ('./' for new files)
" - On other command lines (/,?) returns the keymap used to trigger it
function! reledit#command_dir(keymap) abort
  let l:command_type = getcmdtype()
  if l:command_type isnot# ':'
    return a:keymap
  endif
  let l:dir = expand('%:h')
  if empty(l:dir)
    let l:dir = '.'
  endif
  return l:dir . '/'
endfunction
