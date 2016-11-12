" Set omnicompletion function for vim type of files
aug vim
	au!
	au FileType vim set omnifunc=syntaxcomplete#Complete
aug END
