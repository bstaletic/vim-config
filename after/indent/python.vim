if exists( 'b:indent_python' )
	finish
endif

let b:indent_python = 1

" In python, use two spaces for indentation
setlocal softtabstop=2 shiftwidth=2 expandtab
