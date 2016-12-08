" Enable gcc as a c/cpp linter only
let g:neomake_c_enabled_makers=['gcc',]
let g:neomake_cpp_enabled_makers=['gcc',]

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
