if exists( "b:custom_python" )
	finish
endif

let b:custom_python = 1

" In python, use two spaces for indentation
setl sw=2 sts=2 ts=2 expandtab
let g:neomake_python_pylint_exe='pylint'
let g:neomake_python_flake8_exe='flake8'
let g:neomake_python_python_exe = 'python3'
