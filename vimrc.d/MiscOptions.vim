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
set path+=**

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
set foldlevel=1

" Enable line numbers by default
set number

" Set tabline
function! Tabline()
  let l:s = ''
  for l:i in range(tabpagenr('$'))
    let l:tab = l:i + 1
    let l:winnr = tabpagewinnr(l:tab)
    let l:buflist = tabpagebuflist(l:tab)
    let l:bufnr = l:buflist[l:winnr - 1]
    let l:bufname = bufname(l:bufnr)
    let l:bufmodified = getbufvar(l:bufnr, '&mod')

    let l:s .= '%' . l:tab . 'T'
    let l:s .= (l:tab == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')
    let l:s .= ' ' . l:tab .':'
    let l:s .= (l:bufname !=# '' ? ''. fnamemodify(l:bufname, ':t') . ' ' : &buftype ==# 'quickfix' ? '[Qickfix] ' : '[No name] ' )
    let l:s .= '[' . l:winnr . ']'

    if l:bufmodified
      let l:s .= '[+]'
    endif
  endfor

  let l:s .= '%#TabLineFill#'
  return l:s
endfunction
set tabline=%!Tabline()

" Undo files and dirs
set undofile
set undodir=~/.vim/.undo
" Swap dir
set directory=~/.vim/.swap
