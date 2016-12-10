" Vim global plugin for restricting colon commands to visual blocks
" Last change:  blockwise
" Maintainer:	Damian Conway
" License:	This file is placed in the public domain.

" If already loaded, we're done...
if exists('g:loaded_blockwise')
    finish
endif
let g:loaded_blockwise = 1

" Preserve external compatibility options, then enable full vim compatibility...
let s:save_cpo = &cpoptions
set cpoptions&vim


"=====[ Interface ]===================

vmap  B  :Blockwise<SPACE>

command! -range -nargs=+ -com=command   Blockwise    silent call VBCexec(<q-args>)
command! -range -nargs=* -bang          SortByBlock  silent call VBCsort('<bang>', <q-args>)


"=====[ Implementation ]===================

function! VBCexec(cmd) range
    " Remember the length of the buffer...
    let l:orig_buflen = line('$')

    " Locate and record block being shifted...
    let [l:buf_left,  l:line_left,  l:col_left,  l:offset_left ] = getpos("'<")
    let [l:buf_right, l:line_right, l:col_right, l:offset_right] = getpos("'>")

    let l:lines_left  = getline(l:line_left, l:line_right)
    let l:lines_right = copy(l:lines_left)

    " Keep the before and aft...
    for l:n in range(len(l:lines_left))
        let l:lines_left[l:n]  = l:col_left > 1 ? l:lines_left[l:n][0 : l:col_left-2] : ''
        let l:lines_right[l:n] = l:lines_right[l:n][l:col_right : ]
    endfor

    " Work around a mysterious bug!
    let l:tmp = string(l:lines_left).string(l:lines_right)

    " Remove the before and aft...
    if visualmode() ==# 'v'
        exec '''<,''>s/\%<'. l:col_left .'v.\|\%>'. l:col_right .'v.//g'
    endif

    " Execute the commands...
    exec '''<,''>' . a:cmd

    " Adjust the line count...
    let l:bufdiff = l:orig_buflen - line('$')
    if l:bufdiff > 0
        " Fewer lines left, so insert sufficient empty lines...
        call append(l:line_right - l:bufdiff, repeat([repeat(' ', l:col_right-l:col_left+1)], l:bufdiff))

    elseif l:bufdiff < 0
        " More lines left, so add extras...
        let l:lines_left  += repeat([repeat(' ', l:col_left-1)], -l:bufdiff)
        let l:lines_right += repeat([''], -l:bufdiff)
    endif

    " Reconstruct the lines...
    for l:n in range(len(l:lines_left))
        call setline(l:line_left + l:n, l:lines_left[l:n] . getline(l:line_left + l:n) . l:lines_right[l:n])
    endfor

    " Restore the selection...
    normal gv

endfunction


function! VBCsort(bang, options) range
    " Locate and record block being shifted...
    let [l:buf_left,  l:line_left,  l:col_left,  l:offset_left ] = getpos("'<")
    let [l:buf_right, l:line_right, l:col_right, l:offset_right] = getpos("'>")

    " If no options given, detect the type of sort required...
    if !len(a:options)
        let l:lines   = getline(l:line_left, l:line_right)
        let l:matches = filter(copy(l:lines), 'match(v:val['.(l:col_left-1).':'.(l:col_right-1).'], "^\\s*\\d") >= 0')
        let l:numeric = (len(l:lines) == len(l:matches)) ? 'n' : ''
        let l:options = ' '. l:numeric .' /.*\%' . l:col_left . 'v/'
    else
        let l:options = ' '. a:options .' /\%>'. (l:col_left-1) .'v.\{-}\%<'. (l:col_right+1) .'v./ r'
    endif

    " Remove the before and aft...
    exec l:line_left .','. l:line_right .' sort' . a:bang . ' ' . l:options

    " Restore the selection...
    normal gv

endfunction


" Restore previous external compatibility options
let &cpoptions = s:save_cpo
