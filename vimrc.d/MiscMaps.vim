nnoremap Y y$
"nnoremap <F1> :set invnumber<CR>
nnoremap <F2> :set invrelativenumber<CR> :set invnumber<CR>
"let mapleader=' '

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

" Only highlight the word under cursor, don't go to the next occurance
nnoremap * *N
nnoremap # #n

" Disable arrow keys when in normal mode
"nnoremap <up> <nop>
"nnoremap <down> <nop>
"nnoremap <left> <nop>

" Paste mapping
set pastetoggle=<F3>

" Make space open and close folds
nnoremap <space> za
