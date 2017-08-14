function! keyword#SetHelpprg() abort
	if ( &ft == "vim" )
		let l:keywordprg=":help"
	else
		let l:keywordprg="man"
	endif
	let &keywordprg= l:keywordprg
endfunction
