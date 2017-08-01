if exists( 'b:custom_python' )
	finish
endif

let b:custom_python = 1

" In python, use two spaces for indentation
setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab
