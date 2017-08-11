if exists( 'b:syntax_c' )
	finish
endif

let b:syntax_c = 1

let &l:syntax .= ".doxygen"
