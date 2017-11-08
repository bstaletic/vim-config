if exists( 'b:custom_c' )
	finish
endif

let b:custom_c = 1

packadd a.vim
silent! iunmap <Space>is
