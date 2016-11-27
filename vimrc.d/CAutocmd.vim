" C/C++ plugin loading
augroup ccpp
	autocmd!
	autocmd FileType c,cpp packadd a.vim | packadd vebugger
	autocmd BufRead,BufNewFile *.h,*.c set filetype=c.doxygen
augroup END
