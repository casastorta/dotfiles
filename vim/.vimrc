if !exists("PIDA_EMBEDDED")

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

      "set guioptions-=T
      set mouse=a

      let g:miniBufExplMapWindowNavVim = 1
      let g:miniBufExplMapWindowNavArrows = 1
      let g:miniBufExplMapCTabSwitchBufs = 1
      let g:miniBufExplModSelTarget = 1

      let Tlist_Ctags_Cmd='/usr/local/bin/ctags'

   endif

   "map T :TaskList<CR>
   "map P :TlistToggle<CR>

endif

if exists("PIDA_EMBEDDED")

   set nocompatible
   set number
   map <F1> :bp<CR>
   " map F1 to open previous buffer
   map <F2> :bn<CR>
   " map F2 to open next buffer
   "set gfn=Consolas\ 11
   set gfn=Inconsolata\ 11
   set tabstop=4
   set shiftwidth=4
   set expandtab
   set ai 
   " autoindenting

   let g:zenburn_high_Contrast = 1
   colorscheme zenburn

   set history=5000
   filetype plugin on
   " Highlight searches
   sy on
   " Automatically refresh opened files
   set autoread 
   set showtabline=0
   set mouse=a

   " Mark current line
   autocmd VimEnter * setlocal cursorline
   autocmd WinEnter * setlocal cursorline
   autocmd WinLeave * setlocal nocursorline

endif

" Auto-indent for Python
autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class 
" Strip trailing spaces on save for Python
autocmd BufWritePre *.py normal m`:%s/\s\+$//e ``
" Python formatting stuff
autocmd FileType python setlocal tabstop=4 shiftwidth=4 smarttab expandtab softtabstop=4 autoindent
" Python autocomplete
let g:pydiction_location = '/usr/share/pydiction/complete-dict'
" Use the below highlight group when displaying bad whitespace is desired.
highlight BadWhitespace ctermbg=red guibg=red
" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
" Wrap text after a certain number of characters
" Python: 79
" C: 79
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h set textwidth=79
" Use UNIX (\n) line endings.
au BufNewFile *.py,*.pyw,*.c,*.h set fileformat=unix

let python_highlight_all=1
"set foldmethod=indent
