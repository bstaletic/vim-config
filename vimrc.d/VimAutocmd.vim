" Set omnicompletion function for vim type of files
augroup vim
	autocmd!
	autocmd FileType vim packadd YouCompleteMe
				\ | set omnifunc=syntaxcomplete#Complete
				\ | set keywordprg=":help"
augroup END
