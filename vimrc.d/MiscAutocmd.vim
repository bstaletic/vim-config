" Automatically remove trailing spaces just before writing the file
aug notrspaces
	au!
	au BufWritePre * %s/\s\+$//e
aug END
