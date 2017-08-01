if exists( 'g:ultisnips_config' )
	finish
endif

let g:ultisnips_config = 1

" Snippets - don't use <Tab> as it conflicts ycm
let g:UltiSnipsExpandTrigger='<c-j>'
let g:UltiSnipsJumpForwardTrigger='<c-j>'
let g:UltiSnipsJumpBackwardTrigger='<c-k>'
