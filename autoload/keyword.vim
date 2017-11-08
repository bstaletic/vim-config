function! keyword#SetHelpprg() abort
	if ( &ft == 'vim' || &ft == 'help' )
		let l:keywordprg=':vertical help'
	else
		let l:keywordprg='man'
	endif
	let &keywordprg= l:keywordprg
endfunction
