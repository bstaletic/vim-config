nnoremap Y y$
nnoremap <F2> :set invrelativenumber invnumber<CR>

" Easier <Leader> binding
let g:mapleader=' '

" Easier clipboard access
vnoremap <Leader>y "*y
vnoremap <Leader>d "*d
nnoremap <Leader>p "*p
nnoremap <Leader>P "*P
vnoremap <Leader>p "*p
vnoremap <Leader>P "*P

" Allow saving of files aas sudo when I forget to start vim using sudo
"cnoremap w!! w !sudo tee > /dev/null %

" make . work with visually selected lines
vnoremap . :norm.<CR>

" Disable arrow keys when in normal mode
"nnoremap <up> <nop>
"nnoremap <down> <nop>
"nnoremap <left> <nop>
"nnoremap <right> <nop>

" Paste mapping
set pastetoggle=<F3>

" Make space open and close folds
nnoremap <Leader><space> za

" Map escape to any combination for easier access in insert mode
inoremap jk <esc>

" Use <Tab> and <S-Tab> to traverse the completion menu and <C-C> to close it
inoremap <expr> <C-C> pumvisible() ? "\<C-Y>" : "\<C-C>"
inoremap <expr> <Tab> pumvisible() ? "\<C-N>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-P>" : "\<S-Tab>"
