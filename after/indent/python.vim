if exists( 'b:indent_python' )
	finish
endif

let b:indent_python = 1

" In python, use two spaces for indentation
setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab
