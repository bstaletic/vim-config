" Warn about lines longer than 80
function! highlight#colorcolumn() abort
	highlight ColorColumn ctermbg=red guibg=#ff0000
	highlight NMWarn ctermfg=yellow ctermbg=black guifg=#ffff00 guifg=#000000
	highlight NMInfo ctermfg=cyan ctermbg=black guifg=#00ffff guibg=#000000
	call matchadd('ColorColumn', '\%81v', 100) "set column nr
endfunction
