set guioptions-=m "remove menu bar"
set guioptions-=T
set guioptions-=r
set guioptions-=L

let mapleader=","
call pathogen#infect()
syntax on
filetype plugin indent on

function! InsertTabWrapper(direction)
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  elseif "backward" == a:direction
    return "\<c-p>"
  else
    return "\<c-n>"
  endif
endfunction

inoremap <tab> <c-r>=InsertTabWrapper ("forward")<CR>
inoremap <s-tab> <c-r>=InsertTabWrapper ("backward")<CR>

set tabstop=2
set shiftwidth=2
set expandtab

" enable eclipse style moving of lines
nmap <C-j> mz:m+<CR>`z==
nmap <C-k> mz:m-2<CR>`z==
imap <C-j> <Esc>:m+<CR>==gi
imap <C-k> <Esc>:m-2<CR>==gi
vmap <C-j> :m'>+<CR>gv=`<my`>mzgv`yo`z
vmap <C-k> :m'<-2<CR>gv=`>my`<mzgv`yo`z

" Edit another file in the same directory as the current file
" uses expression to extract path from current file's path
" (thanks Douglas Potts)
if has("unix")
  map ,e :e <C-R>=expand("%:p:h") . '/'<CR>
else
  map ,e :e <C-R>=expand("%:p:h") . '\'<CR>
endif

" So that Shift 0 is to the end of the line.
map ) $

fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()
autocmd BufWritePre * :%s/\($\n\s*\)\+\%$//e

"set guifont=Inconsolata-dz\ for\ Powerline:h14.00
set guifont=monofur\ 18
"Envy\ Code\ R:h14

set nowrap
set number

set ruler
set rulerformat=%15(%c%V\ %p%%%)
set virtualedit=block

function! DeleteFile(...)
  if(exists('a:1'))
    let theFile=a:1
  elseif ( &ft == 'help' )
    echohl Error
    echo "Cannot delete a help buffer!"
    echohl None
    return -1
  else
    let theFile=expand('%:p')
  endif
  let delStatus=delete(theFile)
  if(delStatus == 0)
    echo "Deleted " . theFile
  else
    echohl WarningMsg
    echo "Failed to delete " . theFile
    echohl None
  endif
  return delStatus
endfunction
"delete the current file
com! Rm call DeleteFile()
"delete the file and quit the buffer (quits vim if this was the last file)
com! RM call DeleteFile() <Bar> q!

set smartindent


color mustang
"color rootwater
"color slate
"color hemisu
"color desert

set background=dark
set ai

set cursorline
au Bufread,BufNewFile *.jhaml set filetype=haml
au Bufread,BufNewFile *.ractive set filetype=mustache
au Bufread,BufNewFile *.rac set filetype=mustache

" So you can run commands in buffers.
command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
  echo a:cmdline
  let expanded_cmdline = a:cmdline
  for part in split(a:cmdline, ' ')
    if part[0] =~ '\v[%#<]'
      let expanded_part = fnameescape(expand(part))
      let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
    endif
  endfor
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, 'You entered:    ' . a:cmdline)
  call setline(2, 'Expanded Form:  ' .expanded_cmdline)
  call setline(3,substitute(getline(2),'.','=','g'))
  execute '$read !'. expanded_cmdline
  setlocal nomodifiable
  1
endfunction

vmap ,t :!tidy -q -i --show-errors 0<CR>

set runtimepath^=~/.vim/bundle/ctrlp.vim

nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
autocmd BufRead,BufNewFile *.cljs setlocal filetype=clojure
autocmd BufRead,BufNewFile *.cljx setlocal filetype=clojure

set runtimepath^=~/.vim/bundle/vim-erlang-runtime

nmap <Leader>aa :CodeClimateAnalyzeProject<CR>
nmap <Leader>ao :CodeClimateAnalyzeOpenFiles<CR>
nmap <Leader>af :CodeClimateAnalyzeCurrentFile<CR>

" Simple re-format for minified Javascript
command! UnMinify call UnMinify()
function! UnMinify()
    %s/{\ze[^\r\n]/{\r/g
    %s/){/) {/g
    %s/};\?\ze[^\r\n]/\0\r/g
    %s/;\ze[^\r\n]/;\r/g
    %s/[^\s]\zs[=&|]\+\ze[^\s]/ \0 /g
    normal ggVG=
endfunction
