" Vim global plugin for dragging virtual blocks
" Last change: Tue Jul 24 07:19:35 EST 2012
" Maintainer:	Damian Conway
" License:	This file is placed in the public domain.

"#########################################################################
"##                                                                     ##
"##  Add the following (uncommented) to your .vimrc...                  ##
"##                                                                     ##
"##     runtime plugin/dragvisuals.vim                                  ##
"##                                                                     ##
"##     vmap  <expr>  <LEFT>   DVB_Drag('left')                         ##
"##     vmap  <expr>  <RIGHT>  DVB_Drag('right')                        ##
"##     vmap  <expr>  <DOWN>   DVB_Drag('down')                         ##
"##     vmap  <expr>  <UP>     DVB_Drag('up')                           ##
"##     vmap  <expr>  D        DVB_Duplicate()                          ##
"##                                                                     ##
"##     " Remove any introduced trailing whitespace after moving...     ##
"##     let g:DVB_TrimWS = 1                                            ##
"##                                                                     ##
"##  Or, if you use the arrow keys for normal motions, choose           ##
"##  four other keys for block dragging. For example:                   ##
"##                                                                     ##
"##     vmap  <expr>  h        DVB_Drag('left')                         ##
"##     vmap  <expr>  l        DVB_Drag('right')                        ##
"##     vmap  <expr>  j        DVB_Drag('down')                         ##
"##     vmap  <expr>  k        DVB_Drag('up')                           ##
"##                                                                     ##
"##  Or:                                                                ##
"##                                                                     ##
"##     vmap  <expr>  <S-LEFT>   DVB_Drag('left')                       ##
"##     vmap  <expr>  <S-RIGHT>  DVB_Drag('right')                      ##
"##     vmap  <expr>  <S-DOWN>   DVB_Drag('down')                       ##
"##     vmap  <expr>  <S-UP>     DVB_Drag('up')                         ##
"##                                                                     ##
"##  Or even:                                                           ##
"##                                                                     ##
"##     vmap  <expr>   <LEFT><LEFT>   DVB_Drag('left')                  ##
"##     vmap  <expr>  <RIGHT><RIGHT>  DVB_Drag('right')                 ##
"##     vmap  <expr>   <DOWN><DOWN>   DVB_Drag('down')                  ##
"##     vmap  <expr>     <UP><UP>     DVB_Drag('up')                    ##
"##                                                                     ##
"#########################################################################


" If already loaded, we're done...
if exists('loaded_dragvirtualblocks')
    finish
endif
let g:loaded_dragvirtualblocks = 1

" Preserve external compatibility options, then enable full vim compatibility...
let s:save_cpo = &cpoptions
set cpoptions&vim

"====[ Implementation ]====================================

" Toggle this to stop trimming on drags...
if !exists('g:DVB_TrimWS')
    let g:DVB_TrimWS = 1
endif

function! DVB_Drag (dir)
    " No-op in Visual mode...
    if mode() ==# 'v'
        return "\<ESC>gv"

    " Do Visual Line drag indirectly via temporary nmap
    " (to ensure we have access to block position data)...
    elseif mode() ==# 'V'
        " Set up a temporary convenience...
        exec "nnoremap <silent><expr><buffer>  M  \<SID>Drag_Lines('".a:dir."')"

        " Return instructions to implement the move and reset selection...
        return '"vyM'

    " Otherwise do Visual Block drag indirectly via temporary nmap
    " (to ensure we have access to block position data)...
    else
        " Set up a temporary convenience...
        exec "nnoremap <silent><expr><buffer>  M  \<SID>Drag_Block('".a:dir."')"

        " Return instructions to implement the move and reset selection...
        return '"vyM'
    endif
endfunction

function! DVB_Float (dir)
    " No-op in Visual mode...
    if mode() ==# 'v'
        return "\<ESC>gv"

    " Do Visual Line drag indirectly via temporary nmap
    " (to ensure we have access to block position data)...
    elseif mode() ==# 'V'
        " Set up a temporary convenience...
        exec "nnoremap <silent><expr><buffer>  M  \<SID>Float_Lines('".a:dir."')"

        " Return instructions to implement the move and reset selection...
        return '"vyM'

    " Otherwise do Visual Block drag indirectly via temporary nmap
    " (to ensure we have access to block position data)...
    else
        " Set up a temporary convenience...
        exec "nnoremap <silent><expr><buffer>  M  \<SID>Float_Block('".a:dir."')"

        " Return instructions to implement the move and reset selection...
        return '"vyM'
    endif
endfunction

" Duplicate selected block and place to the right...
function! DVB_Duplicate ()
    exec "nnoremap <silent><expr><buffer>  M  \<SID>DuplicateBlock()"
    return '"vyM'
endfunction

function! s:DuplicateBlock ()
    nunmap <buffer>  M
    " Locate block boundaries...
    let [l:buf_left,  l:line_left,  l:col_left,  l:offset_left ] = getpos("'<")
    let [l:buf_right, l:line_right, l:col_right, l:offset_right] = getpos("'>")

    " Identify special '$' blocks...
    let l:dollar_block = 0
    let l:start_col    = min([l:col_left+l:offset_left, l:col_right+l:offset_right])
    let l:end_col      = max([l:col_left+l:offset_left, l:col_right+l:offset_right])
    let l:visual_width = l:end_col - l:start_col + 1
    for l:visual_line in split(getreg('v'),'\n')
        if strlen(l:visual_line) > l:visual_width
            let l:dollar_block = 1
            let l:visual_width = strlen(l:visual_line)
        endif
    endfor
    let l:square_up = (l:dollar_block ? (l:start_col+l:visual_width-2).'|' : '')

    set virtualedit=all
    return 'gv'.l:square_up.'yPgv'
        \. (l:visual_width-l:dollar_block) . 'lo' . (l:visual_width-l:dollar_block) . 'l'
        \. "y:set virtualedit=block\<CR>gv"
        \. (l:dollar_block ? 'o$' : '')
endfunction


" Kludge to hide change reporting inside implementation...
let s:NO_REPORT   = ":let b:DVB_report=&report\<CR>:let &report=1000000000\<CR>"
let s:PREV_REPORT = ":let &report = b:DVB_report\<CR>"


" Drag in specified direction in Visual Line mode...
function! s:Drag_Lines (dir)
    " Clean up the temporary convenience...
    nunmap <buffer>  M

    " Locate block being shifted...
    let [l:buf_left,  l:line_left,  l:col_left,  l:offset_left ] = getpos("'<")
    let [l:buf_right, l:line_right, l:col_right, l:offset_right] = getpos("'>")

    " Drag entire lines left if possible...
    if a:dir ==# 'left'
        " Are all lines indented at least one space???
        let l:lines        = getline(l:line_left, l:line_right)
        let l:all_indented = match(l:lines, '^[^ ]') == -1

        " If can't trim one space from start of each line, be a no-op...
        if !l:all_indented
            return 'gv'

        " Otherwise drag left by removing one space from start of each line...
        else
            return    s:NO_REPORT
                  \ . "gv:s/^ //\<CR>:nohlsearch\<CR>"
                  \ . s:PREV_REPORT
                  \ . 'gv'
        endif

    " To drag entire lines right, add a space in column 1...
    elseif a:dir ==# 'right'
        return   s:NO_REPORT
             \ . "gv:s/^/ /\<CR>:nohlsearch\<CR>"
             \ . s:PREV_REPORT
             \ . 'gv'

    " To drag entire lines upwards...
    elseif a:dir ==# 'up'
        let l:EOF = line('$')

        " Can't drag up if at first line...
        if l:line_left == 1 || l:line_right == 1
            return 'gv'

        " Needs special handling at EOF (because cursor moves up on delete)...
        elseif l:line_left == l:EOF || l:line_right == l:EOF
            let l:height = l:line_right - l:line_left
            let l:select_extra = l:height ? l:height . 'j' : ''
            return   s:NO_REPORT
                 \ . 'gvxP'
                 \ . s:PREV_REPORT
                 \ . 'V' . l:select_extra

        " Otherwise just cut-move-paste-reselect...
        else
            let l:height = l:line_right - l:line_left
            let l:select_extra = l:height ? l:height . 'j' : ''
            return   s:NO_REPORT
                 \ . 'gvxkP'
                 \ . s:PREV_REPORT
                 \ . 'V' . l:select_extra
        endif

    " To drag entire lines downwards...
    elseif a:dir ==# 'down'
        let l:EOF = line('$')

        " This is how much extra we're going to have to reselect...
        let l:height = l:line_right - l:line_left
        let l:select_extra = l:height ? l:height . 'j' : ''

        " Needs special handling at EOF (to push selection down into new space)...
        if l:line_left == l:EOF || l:line_right == l:EOF
            return   "O\<ESC>gv"

        " Otherwise, just cut-move-paste-reselect...
        else
            return   s:NO_REPORT
                 \ . 'gvxp'
                 \ . s:PREV_REPORT
                 \ . 'V' . l:select_extra
        endif

    endif
endfunction

" Drag in specified direction in Visual Block mode...
function! s:Drag_Block (dir)
    " Clean up the temporary convenience...
    nunmap <buffer>  M

    " Locate block being shifted...
    let [l:buf_left,  l:line_left,  l:col_left,  l:offset_left ] = getpos("'<")
    let [l:buf_right, l:line_right, l:col_right, l:offset_right] = getpos("'>")

    " Identify special '$' blocks...
    let l:dollar_block = 0
    let l:start_col    = min([l:col_left+l:offset_left, l:col_right+l:offset_right])
    let l:end_col      = max([l:col_left+l:offset_left, l:col_right+l:offset_right])
    let l:visual_width = l:end_col - l:start_col + 1
    for l:visual_line in split(getreg('v'),'\n')
        if strlen(l:visual_line) > l:visual_width
            let l:dollar_block = 1
            let l:visual_width = strlen(l:visual_line)
        endif
    endfor
    let l:square_up = (l:dollar_block ? (l:start_col+l:visual_width-2).'|' : '')

    " Drag left...
    if a:dir ==# 'left'
        "Can't drag left at left margin...
        if l:col_left == 1 || l:col_right == 1
            return 'gv'

        " Otherwise reposition one column left (and optionally trim any whitespace)...
        elseif g:DVB_TrimWS
            " May need to be able to temporarily step past EOL...
            let l:prev_ve = &virtualedit
            set virtualedit=all

            " Are we moving past other text???
            let l:square_up_final = ''
            if l:dollar_block
                let l:lines = getline(l:line_left, l:line_right)
                if match(l:lines, '^.\{'.(l:start_col-2).'}\S') >= 0
                    let l:dollar_block = 0
                    let l:square_up_final = (l:start_col+l:visual_width-3).'|'
                endif
            endif

            let l:vcol = l:start_col - 2
            return   'gv'.l:square_up.'xhP'
                 \ . s:NO_REPORT
                 \ . "gvhoho:s/\\s\\+$//e\<CR>gv\<ESC>"
                 \ . ':set virtualedit=' . l:prev_ve . "\<CR>"
                 \ . s:PREV_REPORT
                 \ . ":nohlsearch\<CR>gv"
                 \ . (l:dollar_block ? '$' : l:square_up_final )
        else
            return 'gv'.l:square_up.'xhPgvhoho'
        endif

    " Drag right...
    elseif a:dir ==# 'right'
        " May need to be able to temporarily step past EOL...
        let l:prev_ve = &virtualedit
        set virtualedit=all

        " Reposition block one column to the right...
        if g:DVB_TrimWS
            let l:vcol = l:start_col
            return   'gv'.l:square_up.'xp'
                 \ . s:NO_REPORT
                 \ . 'gvlolo'
                 \ . ":s/\\s\\+$//e\<CR>gv\<ESC>"
                 \ . ":nohlsearch\<CR>:set virtualedit=" . l:prev_ve . "\<CR>"
                 \ . s:PREV_REPORT
                 \ . (l:dollar_block ? 'gv$' : 'gv')
        else
            return 'gv'.l:square_up.'xp:set virtualedit=' . l:prev_ve . "\<CR>gvlolo"
        endif

    " Drag upwards...
    elseif a:dir ==# 'up'
        " Can't drag upwards at top margin...
        if l:line_left == 1 || l:line_right == 1
            return 'gv'
        endif

        " May need to be able to temporarily step past EOL...
        let l:prev_ve = &virtualedit
        set virtualedit=all

        " If trimming whitespace, jump to just below block to do it...
        if g:DVB_TrimWS
            let l:height = l:line_right - l:line_left + 1
            return  'gv'.l:square_up.'xkPgvkoko"vy'
                    \ . l:height
                    \ . 'j:s/\s\+$//e'
                    \ . "\<CR>:nohlsearch\<CR>:set virtualedit="
                    \ . l:prev_ve
                    \ . "\<CR>gv"
                    \ . (l:dollar_block ? '$' : '')

        " Otherwise just move and reselect...
        else
            return   'gv'.l:square_up.'xkPgvkoko"vy:set virtualedit='
                    \ . l:prev_ve
                    \ . "\<CR>gv"
                    \ . (l:dollar_block ? '$' : '')
        endif

    " Drag downwards...
    elseif a:dir ==# 'down'
        " May need to be able to temporarily step past EOL...
        let l:prev_ve = &virtualedit
        set virtualedit=all

        " If trimming whitespace, move to just above block to do it...
        if g:DVB_TrimWS
            return   'gv'.l:square_up.'xjPgvjojo"vyk:s/\s\+$//e'
                    \ . "\<CR>:nohlsearch\<CR>:set virtualedit="
                    \ . l:prev_ve
                    \ . "\<CR>gv"
                    \ . (l:dollar_block ? '$' : '')

        " Otherwise just move and reselect...
        else
            return   'gv'.l:square_up.'xjPgvjojo"vy'
                    \ . "\<CR>:set virtualedit="
                    \ . l:prev_ve
                    \ . "\<CR>gv"
                    \ . (l:dollar_block ? '$' : '')
        endif
    endif
endfunction

let &cpoptions = s:save_cpo
let g:DVB_TrimWS = 1
vmap  <expr>  <LEFT>   DVB_Drag('left')
vmap  <expr>  <RIGHT>  DVB_Drag('right')
vmap  <expr>  <DOWN>   DVB_Drag('down')
vmap  <expr>  D        DVB_Duplicate()
vmap  <expr>  <UP>     DVB_Drag('up')
