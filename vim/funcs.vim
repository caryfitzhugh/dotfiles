let s:term_winid = -1

function! RunCmdAsyncInVsplit(cmd_list)
    " 1. Check whether the saved window still exists, even in another tab.
    if s:term_winid != -1 && win_gotoid(s:term_winid)

        " Keep the terminal window itself alive.  Wiping its current buffer
        " can make Vim close/rearrange that window, which may discard splits.
        let l:oldbuf = bufnr('%')

        " Stop any lingering job running in this terminal
        if &buftype ==# 'terminal'
            let l:job = term_getjob(bufnr('%'))
            if type(l:job) == v:t_job && job_status(l:job) ==# 'run'
                call job_stop(l:job)
            endif
        endif

        " Switch this split to a normal buffer before removing the old
        " terminal buffer, so :bwipeout! cannot close the split.
        enew
        execute 'silent! bwipeout! ' . l:oldbuf
    else
        " Window was closed by you previously, so open a fresh vertical split
        vsplit
    endif

    " 2. Run the new command with ANSI colors in the current window
    call term_start(a:cmd_list, {'curwin': 1})

    " 3. Save the window ID for the next call
    let s:term_winid = win_getid()
endfunction
