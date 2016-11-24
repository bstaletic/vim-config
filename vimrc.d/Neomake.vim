" Use only gcc maker for c type files
let g:neomake_c_enabled_makers=['gcc',]

" The default is nice, so use that
let g:neomake_error_sign = {'text': 'E>', 'texthl': 'NeomakeErrorSign'}

" The default is not playing nice on my colorscheme so set a new one
" Make foreground yellow and background black
highlight MyWarningMsg ctermfg=yellow ctermbg=black
let g:neomake_warning_sign = {
 \   'text': 'W>',
 \   'texthl': 'MyWarningMsg',
 \ }

" Message I have yet to see!
let g:neomake_message_sign = {
  \   'text': 'M>',
  \   'texthl': 'NeomakeMessageSign',
  \ }

" Make foreground cyan and background black
highlight MyInfoMsg ctermfg=cyan ctermbg=black
let g:neomake_info_sign = {'text': 'I>', 'texthl': 'MyInfoMsg'}

" Example of a useful maker for a specific language, overrides a default one
" and differentiates between errors and warnings. That errorformat currently
" seems like pure magic!
"let g:neomake_c_gcc_maker={
"	\ 'exe': 'arm-none-eabi-gcc',
"	\ 'args': [ '-Os', '-g', '-Wall', '-Wextra', '-Wno-main', '-pedantic', '-x', 'c', '-std=c99', '-DSTM32F4', '-DSTM32F407VG', '-DSTM32F4CCM', '-I.', '-Ilibopencm3/include', '-c', ],
"	\ 'errorformat':
"			\ '%-G%f:%s:,' .
"            \ '%f:%l:%c: %trror: %m,' .
"            \ '%f:%l:%c: %tarning: %m,' .
"            \ '%I%f:%l:%c: note: %m,' .
"            \ '%f:%l:%c: %m,'.
"            \ '%f:%l: %trror: %m,'.
"            \ '%f:%l: %tarning: %m,'.
"            \ '%I%f:%l: note: %m,'.
"            \ '%f:%l: %m',
"	\ }
"


augroup neomake
	autocmd!
	autocmd BufWritePost * :Neomake
augroup END
