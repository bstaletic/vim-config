" Vim global plugin for aligning columns
" Last change:  Sat Apr 19 21:55:26 EST 2008
" Maintainer:   Damian Conway
" License:  This file is placed in the public domain.

" If already loaded, we're done...
if exists('g:loaded_colalignsimple')
    finish
endif
let g:loaded_colalignsimple = 1

" Preserve external compatibility options, then enable full vim compatibility...
let s:save_cpo = &cpoptions
set cpoptions&vim

" Align lines with an column in them,
" such as:

 "   The Shoveller | Eddie Stevens     King Arthur's singing shovel | M
"    Blue Raja     | Geoffrey Smith   Master of cutlery | M
 "   Mr Furious  | Roy Orson    Ticking time bomb of fury | M
    "   The Bowler| Carol Pinnsler    Haunted bowling ball | F

function! s:AlignWhitespaceCols (first_line, last_line)
    let l:lines = getline(a:first_line, a:last_line)
    let l:lines = map(copy(l:lines), 'split(''  '' . v:val,''\ze|\|\s\{2,}\zs'')')

    let l:aligned_lines = repeat([''], len(l:lines))
    let l:aligned = 0
    let l:colnum = 0
    while 1
        " Get next column to be added, if any...
        let l:column = map(copy(l:lines), 'get(v:val,l:colnum,"")')
        if max(map(copy(l:column), 'strlen(v:val)')) == 0
            break
        endif

        " Work out alignment...
        let l:colpos = map(copy(l:aligned_lines), 'strlen(v:val)')
        let l:maxpos = max(l:colpos)
        let l:minpos = min(l:colpos)

        " Misaligned? Then align...
        if !l:aligned && l:minpos != l:maxpos
            for l:linenum in range(len(l:column))
                let l:aligned_lines[l:linenum]
                \   = printf('%-*s%s',
                 \           l:maxpos, l:aligned_lines[l:linenum], l:column[l:linenum])
            endfor
            let l:aligned = 1
        else
            for l:linenum in range(len(l:column))
                let l:aligned_lines[l:linenum] .= l:column[l:linenum]
            endfor
        endif
        let l:colnum += 1
    endwhile

    call setline(a:first_line, map(l:aligned_lines, 'strpart(v:val,2)'))
endfunction

function! s:AlignPatternCols (first_line, last_line, separator, pattern)
    let l:lines = getline(a:first_line, a:last_line)
    let l:lines = map(copy(l:lines), 'split('' '' . v:val,a:pattern)')

    let l:aligned_lines = repeat([''], len(l:lines))
    let l:aligned = 0
    let l:colnum = 0
    while 1
        " Get next column to be added, if any...
        let l:column = map(copy(l:lines), 'get(v:val,l:colnum,"")')
        if max(map(copy(l:column), 'strlen(v:val)')) == 0
            break
        endif

        " Work out alignment...
        let l:colpos = map(copy(l:aligned_lines), 'strlen(v:val)')
        let l:maxpos = max(l:colpos)
        let l:minpos = min(l:colpos)

        " Misaligned? Then align...
        if !l:aligned && l:minpos != l:maxpos
            for l:linenum in range(len(l:column))
                let l:aligned_lines[l:linenum]
                \   = printf('%-*s%s%s',
                 \           l:maxpos, l:aligned_lines[l:linenum],
                  \          a:separator, l:column[l:linenum])
            endfor
            let l:aligned = 1
        else
            for l:linenum in range(len(l:column))
                let l:aligned_lines[l:linenum] .= a:separator . l:column[l:linenum]
            endfor
        endif
        let l:colnum += 1
    endwhile

    call setline(a:first_line, map(l:aligned_lines, 'strpart(v:val,1)'))
endfunction

function! s:Align ()
    "Locate block of code to be considered (same indentation, no blanks)
    let l:indent_pat = '^' . matchstr(getline('.'), '^\s*') . '\S'
    let l:first_line  = search('^\%('. l:indent_pat . '\)\@!\|^\s*$','bnW') + 1
    let l:last_line   = search('^\%('. l:indent_pat . '\)\@!\|^\s*$', 'nW') - 1
    if l:last_line < 0
        let l:last_line = line('$')
    endif

    "If no consistent indent, use the current block
    if l:first_line == l:last_line
        let l:first_line  = search('^\s*$','bnW') + 1
        let l:last_line   = search('^\s*$', 'nW') - 1
        if l:last_line < 0
            let l:last_line = line('$')
        endif
    endif

    " Convert char under cursor to pattern
    let l:target_char = getline('.')[col('.') - 1]
    if l:target_char =~# '\s\|\k'
        call <SID>AlignWhitespaceCols(l:first_line, l:last_line)
        return
    elseif l:target_char =~# '\\'
        let l:target_pat = '\\\\'
        call <SID>AlignPatternCols(l:first_line, l:last_line, l:target_char, l:target_pat)
        return
    else
        let l:target_pat = '\V' . l:target_char
        call <SID>AlignPatternCols(l:first_line, l:last_line, l:target_char, l:target_pat)
        return
    endif

endfunction

nmap <silent> ]     :call <SID>Align()<CR>

" Restore previous external compatibility options
let &cpoptions = s:save_cpo
