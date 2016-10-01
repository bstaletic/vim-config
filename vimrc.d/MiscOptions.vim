syntax on
colorscheme slate
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

" Status
set laststatus=2
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" Wildmode - first complete as much as you can, then show a list
set wildmenu
set wildchar=<Tab>
set wildmode=longest,full

" Warn about lines longer than 80
highlight ColorColumn ctermbg=red "set to whatever you like
call matchadd('ColorColumn', '\%81v', 100) "set column nr

" Split windows
set splitright
set splitbelow
