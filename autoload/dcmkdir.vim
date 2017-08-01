function! dcmkdir#EnsureDirExists() abort
    let l:required_dir = expand('%:h')
    if !isdirectory(l:required_dir)
        call s:AskQuit("Parent directory '" . l:required_dir . "' doesn't exist.",
             \       "&Create it\nor &Quit?", 2)

        try
            call mkdir( l:required_dir, 'p' )
        catch
            call s:AskQuit("Can't create '" . l:required_dir . "'",
            \            "&Quit\nor &Continue anyway?", 1)
        endtry
    endif
endfunction

function! s:AskQuit (msg, options, quit_option) abort
    if confirm(a:msg, a:options) == a:quit_option
        exit
    endif
endfunction
