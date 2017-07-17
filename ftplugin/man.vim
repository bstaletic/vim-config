if exists( "b:custom_man" )
	finish
endif

let b:custom_man = 1

" Make vim behave more like a pager
nnoremap <Down> <C-e>
nnoremap <Up> <C-y>
nnoremap j <C-e>
nnoremap k <C-y>
