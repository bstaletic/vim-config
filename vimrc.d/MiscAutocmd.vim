augroup notrspaces
	autocmd!
	autocmd BufWritePre * %s/\s\+$//e
augroup END

augroup timeout
	autocmd!
	autocmd insertenter * set timeoutlen=50
	autocmd insertleave * set timeoutlen=500
augroup END
