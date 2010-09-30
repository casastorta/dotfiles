set nocompatible
set number
map <F1> :bp<CR>
  " map F1 to open previous buffer
map <F2> :bn<CR>
  " map F2 to open next buffer
"set gfn=Consolas\ 11
set gfn=Inconsolata\ 11
map <F5> :popup Bookmarks<CR>

set rulerformat=%15(%c%V\ %p%%%)

set tabstop=3
set shiftwidth=3
set expandtab
set ai 
  " autoindenting
set history=5000
filetype plugin on

set showtabline=2 

"imap <S-Tab> <C-o><<

"set mouse=a

let g:zenburn_high_Contrast = 1
colorscheme zenburn

" Highlight searches
sy on

" Automatically refresh opened files
set autoread 

" Mark current line
autocmd VimEnter * setlocal cursorline
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline

if has("gui_running")
  if exists("+lines")
    set lines=46
  endif
  if exists("+columns")
    set columns=164
  endif
  set guioptions-=T
  set mouse=a
endif
