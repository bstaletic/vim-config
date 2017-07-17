if exists( "g:minibufexplorer_config" )
	finish
endif

let g:minibufexplorer_config = 1

" Open MBE on the top
let g:miniBufExplBRSplit=0
" Toggle its buffer on <F9>
nnoremap <silent> <F8> :MBEToggle<CR>
nnoremap <silent> <F9> :MBEOpen<CR>:MBEFocus<CR>
