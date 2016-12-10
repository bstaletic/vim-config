" Vim global plugin for aligning assignments and other similar symbols
" Last change:  Sat Apr 19 21:55:26 EST 2008
" Maintainer:	Damian Conway
" License:	This file is placed in the public domain.

" If already loaded, we're done...
if exists('g:loaded_eqalignsimple')
    finish
endif
let g:loaded_eqalignsimple = 1

" Preserve external compatibility options, then enable full vim compatibility...
let s:save_cpo = &cpoptions
set cpoptions&vim

" Align lines with an = in them,
" such as:

"        $x            = 1
"        $longer_var   = 1
"        $longer_var  += 1
"        $longer_var   = 1
"        $mid_var    //= 1
"        $var          = 1

" Or:

"        cat => 'feline',
"        leo => 'leonine',
"        cow => 'bovine',
"        elephant => 'elephantine',

let s:QUOTELIKE
\   = '''\%(\\.\|[^''\\]\)*''\|'
\   . '"\%(\\.\|[^"\\]\)*"'

let s:LINE_WITH_EQ_ARROW
\    = '^\(\%('.s:QUOTELIKE.'\|[^''"]\)\{-}\)\s*'
\    . '\(<==\|==\?>\|\%([~.*/%+-]\|||\?\|&&\?\|//\?\)\?=\@<!=[=~]\@!\)'
\    . '\s*\(.*\)$'

let s:LINE_WITH_EQ_VIM
\    = '^\(\%(\s*"\)\?\%('.s:QUOTELIKE.'\|[^''"]\)\{-}\)\s*'
\    . '\(\%([~.*/%+-]\|||\?\|&&\?\|//\?\)\?=\@<!=[=~]\@!\)'
\    . '\s*\(.*\)$'

let s:LINE_WITH_EQ_TXT
\    = '^\(\s*\%('.s:QUOTELIKE.'\|[^''"]\)\{-}\%(\S:\|=\@=\)\)'
\    . '\(:\@<=\s\|=\)'
\    . '\s*\(.*\)$'

function EQAS_Align (mode, ...) range
    let l:option = a:0 ? a:1 : {}

    "What symbol to align (defaults to '=' variants)...
    if &filetype =~# '^\%(perl6\?\|ruby\|php\)'
        let l:search_pat = s:LINE_WITH_EQ_ARROW
    elseif &filetype ==# 'vim'
        let l:search_pat = s:LINE_WITH_EQ_VIM
    else
        let l:search_pat = s:LINE_WITH_EQ_TXT
    endif

    "Handle config options on search...
    if strlen(get(l:option,'pattern',''))
        let l:search_pat = '^\(.\{-}\)\s*\(' . get(l:option,'pattern') . '\)\s*\(.*\)$'

    elseif get(l:option,'cursor')
        " If requested, work out what symbol is under cursor and align to that...
        let [l:bufnum, l:line_num, l:start_pos, l:offset] = getpos('.')
        let l:start_pos -= 1
        let l:end_pos = l:start_pos
        let l:curr_line = getline(l:line_num)
        let l:curr_char = l:curr_line[l:start_pos]

        "Classify the char under the cursor as space or keyword or other
        let l:sym_type = l:curr_char =~# '\s' ? '\s'
        \            : l:curr_char =~# '\k' ? '\k'
        \            :                     '\k\@!\S'

        "Walk back and forth from under cursor as long as chars are of same type...
        while l:start_pos > 0 && l:curr_line[l:start_pos-1] =~ l:sym_type
            let l:start_pos -= 1
        endwhile
        while l:end_pos < strlen(l:curr_line)-1 && l:curr_line[l:end_pos+1] =~ l:sym_type
            let l:end_pos += 1
        endwhile

        "The resulting sequence becomes the alignment symbol...
        let l:search_pat = '^\(.\{-}\)\s*\(\V' . l:curr_line[l:start_pos : l:end_pos] . '\m\)\s*\(.*\)$'
    endif

    "Locate block of code to be considered (same indentation, no blanks)
    if a:mode ==# 'vmap'
        let l:firstline = a:firstline
        let l:lastline  = a:lastline

    elseif get(l:option, 'paragraph')
        let l:firstline  = search('^\s*$','bnW') + 1
        let l:lastline   = search('^\s*$', 'nW') - 1
        if l:lastline < 0
            let l:lastline = line('$')
        endif

    else
        let l:indent_pat = '^' . matchstr(getline('.'), '^\s*') . '\S'
        let l:firstline  = search('^\%('. l:indent_pat . '\)\@!\|^\s*$','bnW') + 1
        let l:lastline   = search('^\%('. l:indent_pat . '\)\@!\|^\s*$', 'nW') - 1
        if l:lastline < 0
            let l:lastline = line('$')
        endif
    endif

    " Decompose lines at assignment operators...
    let l:lines = []
    let l:visible_op_offset = 0
    for l:linetext in getline(l:firstline, l:lastline)
        let l:field = matchlist(l:linetext, l:search_pat)
        if len(l:field)
            call add(l:lines, { 'lval' : substitute(l:field[1],'\s*$','',''),
            \                   'op' :            l:field[2],
            \                 'rval' : substitute(l:field[3],'^\s*','','')
            \               })
            if l:field[2] =~# '\S'
                let l:visible_op_offset = 1
            endif
        else
            call add(l:lines, {'text':l:linetext, 'op':''})
        endif
    endfor

    " Determine maximal lengths of lvalue and operator...
    let l:op_lines = filter(copy(l:lines),'!empty(v:val.op)')
    let l:max_lval = max( map(copy(l:op_lines), 'strlen(v:val.lval)') ) + l:visible_op_offset
    let l:max_op   = max( map(copy(l:op_lines), 'strlen(v:val.op)'  ) )

    " Recompose lines with operators at the maximum length...
    let l:linenum = l:firstline
    for l:line in l:lines
        let l:newline = empty(l:line.op)
        \ ? l:line.text
        \ : printf('%-*s%*s %s', l:max_lval, l:line.lval, l:max_op, l:line.op, l:line.rval)

        call setline(l:linenum, l:newline)
        let l:linenum += 1
    endfor
endfunction


nmap <silent> =     :call EQAS_Align('nmap')<CR>
nmap <silent> +     :call EQAS_Align('nmap', {'cursor':1} )<CR>
map <silent> ++    :call EQAS_Align('nmap', {'cursor':1, 'paragraph':1} )<CR>
vmap <silent> =     :call EQAS_Align('vmap')<CR>
vmap <silent> +     :call EQAS_Align('vmap', {'cursor':1} )<CR>

" Restore previous external compatibility options
let &cpoptions = s:save_cpo
