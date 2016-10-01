" Set omnicompletion function for vim type of files
aug vim
	au!
	au FileType vim packadd YouCompleteMe
				\ | set omnifunc=syntaxcomplete#Complete
aug END
