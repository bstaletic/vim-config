if exists( "g:undotree_config" )
	finish
endif

let g:undotree_config = 1

nnoremap <silent> <F6> :UndotreeToggle<CR>

let g:undotree_DiffpanelHeight=20
let g:undotree_SetFocusWhenToggle=1
