function! slash#blink(times, delay)
  let s:blink = { 'ticks': 2 * a:times, 'delay': a:delay }
  highlight default HLNext ctermfg=white ctermbg=red

  function! s:blink.tick(_)
    let self.ticks -= 1
    let active = self == s:blink && self.ticks > 0

    if !self.clear() && active
      let [line, col] = [line('.'), col('.')]
      let w:blink_id = matchadd('HLNext', '\c\%#'.@/)
    endif
    if active
      call timer_start(self.delay, self.tick)
    endif
  endfunction

  function! s:blink.clear()
    if exists('w:blink_id')
      call matchdelete(w:blink_id)
      unlet w:blink_id
      return 1
    endif
  endfunction

  call s:blink.clear()
  call s:blink.tick(0)
  return ''
endfunction

function! slash#callBlink() abort
	if getcmdtype() == '/' || getcmdtype() == '?'
		return "\<cr>:call slash#blink(3, 100)\<cr>"
	else
		return "\<cr>"
	endif
endfunction
