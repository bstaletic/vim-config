" Warn about lines longer than 80
function! highlight#colorcolumn() abort
	highlight ColorColumn ctermbg=red "Set the colour of highlight
	call matchadd('ColorColumn', '\%81v', 100) "set column nr
endfunction
