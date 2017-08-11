if exists( 'g:ycm_config' )
	finish
endif

let g:ycm_config = 1

" YCM settings
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
"let g:ycm_log_level = 'debug'

imap <expr> l pumvisible() &&
            \ exists( 'v:completed_item' ) &&
            \ !empty( v:completed_item ) &&
            \ v:completed_item.word != '' &&
            \ ( v:completed_item.kind == 'f' \|\|
              \ v:completed_item.kind == 'm' )?
                \ "\<C-R>=ycm#onCompleteDone()\<CR>" : "l"
