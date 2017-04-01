syntax on " Enable syntax highlighting
colorscheme boris " Set colorscheme
set history=5000 " Number of history commands remembered
filetype plugin indent on " Detect filetype and load appropriate file
set hlsearch " Highlight words matching search patterns
set ignorecase " Make searches case insensitive
set smartcase " Unless upper case is typed don't honor case
set ruler " Show position in a file on the status line
set incsearch " Move as search pattern is typed
set exrc " Allow loading of user defined extra config
set secure " Disable :au, shell and :w from exrc
set hidden " Hide buffers instead of requiring the user to save and quit
set matchpairs+=<:> " Make % match angle brackets
set signcolumn=yes " Always enable sign column, otherwise it can be distracting
set cpoptions+=>
set path+=**
set backspace=indent,eol,start      "BS past autoindents, line boundaries,
                                    "     and even the start of insertion

set fileformats=unix,mac,dos        "Handle Mac and DOS line-endings
                                    "but prefer Unix endings

" Status
set laststatus=2 "Make the buffer always have a status line
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" Wildmode - first complete as much as you can, then show a list
set wildmenu
set wildchar=<Tab>
set wildmode=longest,full

" Warn about lines longer than 80
highlight ColorColumn ctermbg=red "Set the colour of highlight
call matchadd('ColorColumn', '\%81v', 100) "set column nr

" Split windows
set splitright
set splitbelow

" Folding method
set foldmethod=syntax
set foldlevel=999

" Enable line numbers by default
set number

" Undo files and dirs
set undofile
set undodir=~/.vim/.undo
" Swap dir
set directory=~/.vim/.swap

" Use ag as grepprg when available
if executable("ag")
    set grepprg=ag\ --nogroup\ --nocolor\ --column
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif
