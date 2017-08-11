if exists( 'g:netrw_config' )
	finish
endif

let g:netrw_config = 1

" Netrw
" Show files in wide mode
let g:netrw_liststyle=2
" Disable the annoying banner at the top
let g:netrw_banner=0
" Open the file in a buffer where the cursor was before calling netrw
let g:netrw_browse_split=4
" Open netrw in a vertical split on the right side
let g:netrw_altv=1
" Take up 25%
let g:netrw_winsize=25

" Open netrw in vertical split
nnoremap <silent> <F7> :Lex<CR>
