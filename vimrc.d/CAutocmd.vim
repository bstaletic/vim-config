" C/C++ plugin loading
aug ccpp
	au!
	au FileType c,cpp packadd vebugger
				\ | packadd YouCompleteMe
				\ | packadd a.vim
	autocmd BufRead,BufNewFile *.h,*.c set filetype=c syntax=c.doxygen
aug END
