syntax on "Enable syntax highlighting
colorscheme slate "Set colorscheme
set history=500 "Number of history commands remembered
set nocp "Nocompatibe => be improved
filetype plugin indent on "Detect filetype and load appropriate file
set hlsearch "Highlight words matching search patterns
set ignorecase "Make searches case insensitive
set smartcase "Unless upper case is typed don't honor case
set ruler "Show position in a file on the status line
set incsearch "Move as search pattern is typed
set exrc "Allow loading of user defined extra config
set secure "Disable :au, shell and :w from exrc

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
