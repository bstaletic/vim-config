if exists( 'b:custom_c' )
	finish
endif

let b:custom_c = 1

packadd a.vim
packadd vebugger
let s:syntax = &syntax . '.doxygen'
exec 'setlocal syntax=' . expand( s:syntax )
unlet s:syntax
silent! iunmap <Space>is
