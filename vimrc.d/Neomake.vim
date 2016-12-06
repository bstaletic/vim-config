" Enable gcc as a c/cpp linter only
let g:neomake_c_enabled_makers=['gcc',]
let g:neomake_cpp_enabled_makers=['gcc',]

" Vimscript linters
let g:neomake_vim_enabled_makers = [ 'vint', ]
let g:neomake_vim_vint_maker = {
	\ 'exe': 'vint',
	\ 'args': [ '-w', '-f', '{file_path}:{line_number}:{column_number}:{severity}:{description} ({policy_name})', ],
	\ 'errorformat': '%f:%l:%c:%trror:%m,%f:%l:%c:%tarning:%m',
	\ }
let g:neomake_vim_vintall_maker = {
	\ 'exe': 'vint',
	\ 'args': [ '-s', '-f', '{file_path}:{line_number}:{column_number}:{severity}:{description} ({policy_name})', ],
	\ 'errorformat': '%I%f:%l:%c:style_problem:%m,%f:%l:%c:%t%*[^:]:%m',
	\ }

" The default is nice, so use that
let g:neomake_error_sign = {'text': 'E>', 'texthl': 'NeomakeErrorSign'}

" The default is not playing nice on my colorscheme so set a new one
" Make foreground yellow and background black
highlight MyWarningMsg ctermfg=yellow ctermbg=black
let g:neomake_warning_sign = { 'text': 'W>', 'texthl': 'MyWarningMsg', }

" Message I have yet to see!
let g:neomake_message_sign = { 'text': 'M>', 'texthl': 'NeomakeMessageSign', }

" Make foreground cyan and background black
highlight MyInfoMsg ctermfg=cyan ctermbg=black
let g:neomake_info_sign = {'text': 'I>', 'texthl': 'MyInfoMsg'}
