" Set errorformat for C/C++ files
let fts = ['c', 'cpp']
if index(fts, &filetype) == -1
	set errorformat=%f:%l:%c:\ %trror:\ %m,%f:%l:%c:\ %tarning:\ %m,%I%f:%l:%c:\ note:\ %m,%f:%l:%c:\ %m,%f:%l:\ %trror:\ %m,%f:%l:\ %tarning:\ %m,%I%f:%l:\ note:\ %m,%f:%l:\ %m,%-G%f:%s:
endif
