" C/C++ plugin loading
aug ccpp
	au!
	au FileType c,cpp packadd packadd taglist
				\ | packadd YouCompleteMe
				\ | packadd a.vim
aug END
