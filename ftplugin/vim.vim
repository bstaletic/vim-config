if exists( "b:custom_vim" )
	finish
endif

let b:custom_vim = 1

" Convenience options for vim filetype
setlocal omnifunc=syntaxcomplete#Complete keywordprg=":help"
setlocal foldmethod=marker
