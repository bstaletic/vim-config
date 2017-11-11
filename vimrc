" Misc autocommands {{{
augroup msicAutocmd
	autocmd!
	" Maintain custom highlighting
	autocmd ColorScheme * call highlight#colorcolumn()
	autocmd BufNewFile * call dcmkdir#EnsureDirExists()
	autocmd insertenter * set timeoutlen=200
	autocmd insertleave * set timeoutlen=700
augroup END
" }}}

" Random settings I want on by default {{{
if !exists("g:syntax_on")
    syntax enable  " Enable syntax highlighting
endif
colorscheme distinguished " Set colorscheme
set history=5000 " Number of history commands remembered
filetype plugin indent on " Detect filetype and load appropriate file
set hlsearch " Highlight words matching search patterns
set ignorecase " Make searches case insensitive
set smartcase " Unless upper case is typed don't honor case
set incsearch " Move as search pattern is typed
set exrc " Allow loading of user defined extra config
set secure " Disable :au, shell and :w from exrc
set hidden " Hide buffers instead of requiring the user to save and quit
set signcolumn=yes " Always enable sign column, otherwise it can be distracting
set cpoptions+=>
set path+=**
set backspace=indent,eol,start      "BS past autoindents, line boundaries,
                                    "     and even the start of insertion
set nrformats+=alpha " Make <C-a> and <C-x> work on letters too
set tildeop " Make ~ work like an operator

packadd! matchit
packadd! termdebug

" Status
set laststatus=2 "Make the buffer always have a status line
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" Wildmode - first complete as much as you can, then show a list
set wildmenu
set wildmode=longest,full

" Split windows
set splitright
set splitbelow

" Folding method
set foldmethod=manual

" Enable line numbers by default
set relativenumber number

" Undo files and dirs
set undofile
set undodir=~/.vim/.undo
" Swap dir
set directory=~/.vim/.swap

" Use ag as grepprg when available
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor\ --column
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif
" }}}

" Useful mappings {{{
nnoremap Y y$
nnoremap <F2> :set invrelativenumber invnumber<CR>

" Easier <Leader> binding
let g:mapleader=' '

" make . work with visually selected lines
vnoremap . :norm.<CR>

" Paste mapping
set pastetoggle=<F3>

" Map escape to any combination for easier access in insert mode
inoremap jk <esc>

" Open help in a vertical split
cnoreabbrev h vert h

" Quicker :marks :regs and :buffers commands
nnoremap <Leader>b :ls<CR>:b
nnoremap <Leader>r :reg<CR>
nnoremap <Leader>m :marks<CR>

" Next match blink hightligh
nnoremap <silent> n n:call slash#blink(3, 100)<CR>
nnoremap <silent> N N:call slash#blink(3, 100)<CR>
nnoremap <silent> # #:call slash#blink(3, 100)<CR>
nnoremap <silent> * *:call slash#blink(3, 100)<CR>
cnoremap <silent> <expr> <enter> slash#callBlink()

" }}}
