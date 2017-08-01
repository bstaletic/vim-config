" Completing functions using UltiSnips
function! Ycm#onCompleteDone() abort
	let l:abbr = v:completed_item.abbr
	let l:startIdx = stridx(l:abbr,'(')
	let l:endIdx = strridx(l:abbr,')')
	if l:endIdx - l:startIdx > 1
		let l:argsStr = strpart(l:abbr, l:startIdx+1, l:endIdx - l:startIdx -1)
		"let argsList = split(argsStr, ",")

		let l:argsList = []
		let l:arg = ''
		let l:countParen = 0
		for l:i in range(strlen(l:argsStr))
			if l:argsStr[l:i] ==# ',' && l:countParen == 0
				call add(l:argsList, l:arg)
				let l:arg = ''
			elseif l:argsStr[l:i] ==# '('
				let l:countParen += 1
				let l:arg = l:arg . l:argsStr[l:i]
			elseif l:argsStr[l:i] ==# ')'
				let l:countParen -= 1
				let l:arg = l:arg . l:argsStr[l:i]
			else
				let l:arg = l:arg . l:argsStr[l:i]
			endif
		endfor
		if l:arg !=# '' && l:countParen ==# 0
			call add(l:argsList, l:arg)
		endif
	else
		let l:argsList = []
	endif

	let l:snippet = '('
	let l:c = 1
	for l:i in l:argsList
		if l:c > 1
			let l:snippet = l:snippet . ', '
		endif
		" strip space
		let l:arg = substitute(l:i, '^\s*\(.\{-}\)\s*$', '\1', '')
		let l:snippet = l:snippet . '${' . l:c . ':' . l:arg . '}'
		let l:c += 1
	endfor
	let l:snippet = l:snippet . ')' . '$0'
	return UltiSnips#Anon(l:snippet)
endfunction
