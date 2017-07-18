if exists( "b:custom_python" )
	finish
endif

let b:custom_python = 1

" In python, use two spaces for indentation
setlocal sw=2 sts=2 ts=2 expandtab
