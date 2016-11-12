" C/C++ plugin loading
aug ccpp
	au!
	au FileType c,cpp packadd a.vim | set omnifunc=ccomplete#Complete
	au BufWritePost *.c execute 'Neomake gcc'
	au BufWritePost *.h execute 'Neomake gcc'
aug END
