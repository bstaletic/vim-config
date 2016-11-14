" Automatically remove trailing spaces just before writing the file
augroup notrspaces
	autocmd!
	autocmd BufWritePre * %s/\s\+$//e
augroup END

augroup dkogutentags
	autocmd!
	autocmd User GutentagsUpdated redraw!
augroup END
