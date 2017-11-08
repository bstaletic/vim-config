if exists( 'b:custom_man' )
	finish
endif

let b:custom_man = 1

" Make vim behave more like a pager
nnoremap <buffer> <Down> <C-e>
nnoremap <buffer> <Up> <C-y>
nnoremap <buffer> j <C-e>
nnoremap <buffer> k <C-y>
nnoremap <buffer> <Space> <C-f>
