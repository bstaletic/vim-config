if exists( "b:custom_vim" )
	finish
endif

let b:custom_vim = 1

" Convenience options for vim filetype
set omnifunc=syntaxcomplete#Complete keywordprg=":help"
set foldmethod=marker
