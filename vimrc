" Misc

syntax on
colorscheme slate
nnoremap Y y$
nnoremap <F1> :set invnumber<CR>
nnoremap <F2> :set invrelativenumber<CR>
set pastetoggle=<F3>
set history=50
set nocp
filetype plugin indent on
set hlsearch
set ignorecase
set smartcase
set ruler
set suffixes=.bak,~,.swp,.o,.info,.obj
set incsearch
set exrc
set secure
"let mapleader=' '
vnoremap <Leader>y "*y
vnoremap <Leader>d "*d
nnoremap <Leader>p "*p
nnoremap <Leader>P "*P
vnoremap <Leader>p "*p
vnoremap <Leader>P "*P
" Allow saving of files aas sudo when I forget to start vim using sudo
"cnoremap w!! w !sudo tee > /dev/null %

" Conque-gdb
let g:ConqueGdb_Leader='\\'

" Status

set laststatus=2
"set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" Split windows

set splitright
set splitbelow

" Snippets - don't use <Tab> as it conflicts ycm
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" a.vim bindings
nnoremap <F4> :AV<CR>
nnoremap <F5> :AT<CR>

" easymotion trigger
let g:EasyMotion_leader_key='<Leader>'

" Python indentation workaround
aug puton
	au!
	au FileType python setl ts=4 expandtab
				\ | packadd YouCompleteMe
aug END

"  C/C++ plugin loading
aug ccpp
	au!
	au FileType c,cpp packadd YCM-Generator
				\ | packadd taglist
				\ | packadd YouCompleteMe
				\ | packadd a.vim
aug END

" YCM settings
let g:ycm_server_python_interpreter='/usr/bin/python3'
let g:ycm_collect_identifiers_from_comments_and_strings = 0
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_collect_identifiers_from_tags_files = 1

" Netrw
let g:netrw_liststyle='wide'

" Wildmode - first complete as much as you can, then show a list
set wildmenu
set wildchar=<Tab>
set wildmode=longest,full

" Disable arrow keys when in normal mode
"nnoremap <up> <nop>
"nnoremap <down> <nop>
"nnoremap <left> <nop>
"nnoremap <right> <nop>

" Gundo
nnoremap <F6> :GundoToggle<CR>
let g:gundo_return_on_revert=0

" Gitgutter
let g:gitgutter_enabled = 0

" Automatically remove trailing spaces just before writing the file
aug notrspaces
	au!
	au BufWritePre * %s/\s\+$//e
aug END

" make . work with visually selected lines
vnoremap . :norm.<CR>

" Only highlight the word under cursor, don't go to the next occurance
nnoremap * *N
nnoremap # #n

" Set omnicompletion function for vim type of files
aug vim
	au!
	au FileType vim packadd YouCompleteMe
				\ | set omnifunc=syntaxcomplete#Complete
aug END

" Warn about lines longer than 80
highlight ColorColumn ctermbg=red "set to whatever you like
call matchadd('ColorColumn', '\%81v', 100) "set column nr

" Autoclose - don't remap <Esc>
let g:AutoClosePreserveDotReg=0

"======[ Credits for HLNext and automagical mkdir go to Damian Conway ]=======
source $HOME/.vim/dcvimrc
