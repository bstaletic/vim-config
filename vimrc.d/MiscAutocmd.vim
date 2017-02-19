augroup notrspaces
	autocmd!
	autocmd BufWritePre * %s/\s\+$//e
augroup END

augroup timeout
	autocmd!
	autocmd insertenter * set timeoutlen=200
	autocmd insertleave * set timeoutlen=700
augroup END
