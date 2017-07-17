" Completing functions using UltiSnips
function! Ycm#onCompleteDone()
	let abbr = v:completed_item.abbr
	let startIdx = stridx(abbr,"(")
	let endIdx = strridx(abbr,")")
	if endIdx - startIdx > 1
		let argsStr = strpart(abbr, startIdx+1, endIdx - startIdx -1)
		"let argsList = split(argsStr, ",")

		let argsList = []
		let arg = ''
		let countParen = 0
		for i in range(strlen(argsStr))
			if argsStr[i] == ',' && countParen == 0
				call add(argsList, arg)
				let arg = ''
			elseif argsStr[i] == '('
				let countParen += 1
				let arg = arg . argsStr[i]
			elseif argsStr[i] == ')'
				let countParen -= 1
				let arg = arg . argsStr[i]
			else
				let arg = arg . argsStr[i]
			endif
		endfor
		if arg != '' && countParen == 0
			call add(argsList, arg)
		endif
	else
		let argsList = []
	endif

	let snippet = '('
	let c = 1
	for i in argsList
		if c > 1
			let snippet = snippet . ", "
		endif
		" strip space
		let arg = substitute(i, '^\s*\(.\{-}\)\s*$', '\1', '')
		let snippet = snippet . '${' . c . ":" . arg . '}'
		let c += 1
	endfor
	let snippet = snippet . ')' . "$0"
	return UltiSnips#Anon(snippet)
endfunction
