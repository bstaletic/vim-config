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
	syntax enable
endif
colorscheme apprentice
set history=5000
filetype plugin indent on
set hlsearch
set ignorecase " Make searches case insensitive
set smartcase " Unless upper case is typed don't honor case
set incsearch
set exrc
set secure " Disable :au, shell and :w from exrc
set hidden
set cpoptions+=>
set path+=**
set backspace=indent,eol,start
set softtabstop=-1 " Make softtabstop have the same value as shiftwidth

packadd! matchit
packadd! termdebug

" Status
set laststatus=2 "Make the buffer always have a status line
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" Allow vim to use gui colours in terminal too
if has('termguicolors')
	set termguicolors
endif

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
if isdirectory('$MYVIMRC/.undo')
	set undodir=$MYVIMRC/.undo
endif
" Swap dir
if isdirectory('$MYVIMRC/.swap')
	set directory=$MYVIMRC/.swap
endif

if executable('rg')
	set grepprg=rg\ --vimgrep
	set grepformat=%f:%l:%c:%m,%f:%l:%m
elseif executable('ag')
	set grepprg=ag\ --vimgrep
	set grepformat=%f:%l:%c:%m,%f:%l:%m
endif
" }}}

" Useful mappings {{{
nnoremap Y y$
nnoremap <F2> :set invrelativenumber invnumber<CR>

" Easier <Leader> binding
let g:mapleader=' '

" make . work with visually selected lines
xnoremap . :norm.<CR>
xnoremap > >gv
xnoremap < <gv

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
