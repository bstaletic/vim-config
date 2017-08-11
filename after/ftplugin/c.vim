if exists( 'b:custom_c' )
	finish
endif

let b:custom_c = 1

packadd a.vim
packadd vebugger
silent! iunmap <Space>is
