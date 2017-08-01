if exists( 'g:slash_config' )
	finish
endif

let g:slash_config = 1

noremap <expr> <plug>(slash-after) slash#blink(3, 100)
