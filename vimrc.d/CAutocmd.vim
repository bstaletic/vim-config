" C/C++ plugin loading
aug ccpp
	au!
	au FileType c,cpp packadd YCM-Generator
				\ | packadd taglist
				\ | packadd YouCompleteMe
				\ | packadd a.vim
aug END
