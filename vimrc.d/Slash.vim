function! s:blink(times, delay)
	let s:blink = { 'ticks': 2 * a:times, 'delay': a:delay }

	function! s:blink.tick(_)
		highlight WhiteOnRed ctermfg=white ctermbg=red
		let l:target_pat = '\c\%#\%('.@/.'\)'
		let l:self.ticks -= 1
		let l:active = l:self == s:blink && l:self.ticks > 0

		if !l:self.clear() && l:active && &hlsearch
			let [l:line, l:col] = [line('.'), col('.')]
			let w:blink_id = matchadd('WhiteOnRed', l:target_pat, 101)
		endif
		if l:active
			call timer_start(l:self.delay, l:self.tick)
		endif
	endfunction

	function! s:blink.clear()
		if exists('w:blink_id')
			call matchdelete(w:blink_id)
			unlet w:blink_id
			return 1
		endif
	endfunction

	call s:blink.tick(0)
	call s:blink.clear()
	return ''
endfunction

noremap <expr> <plug>(slash-after) <sid>blink(3, 100)
