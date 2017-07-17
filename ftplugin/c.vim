if exists( "b:custom_c" )
	finish
endif

let b:custom_c = 1

packadd a.vim
packadd vebugger
let &syntax .= ".doxygen"
silent! iunmap <Space>is
