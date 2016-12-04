" C/C++ plugin loading
augroup ccpp
	autocmd!
	autocmd FileType c,cpp packadd vebugger
				\ | packadd YouCompleteMe
				\ | packadd a.vim
	autocmd BufRead,BufNewFile *.h,*.c set filetype=c syntax=c.doxygen
augroup END
