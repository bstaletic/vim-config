augroup notrspaces
	autocmd!
	autocmd BufWritePre * %s/\s\+$//e
augroup END
