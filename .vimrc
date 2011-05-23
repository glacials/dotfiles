""""'
" General Settings
""""'

  set nocompatible        " use vim settings over vi

  set autoindent          " auto-indent newlines based on current line's indentation
  set smartindent         " guess when to increase/decrease indentations (e.g. curly braces)

  set tabstop=2           " set tab display width to 2
  set softtabstop=2       " set tab insert width to 2
  set shiftwidth=2        " set auto-indent width to 2
  set expandtab           " use spaces in place of tabs

  set tabstop=2           " set tab display width to 4
  set softtabstop=2       " set tab insert width to 4
  set shiftwidth=2        " set auto-indent width to 4
  set expandtab           " do NOT use spaces in place of tabs

  set incsearch           " live search (i.e. search while typing the search query)
  set ignorecase          " ignore case when searching

"  set mouse=a             " allow the mouse to be used

  set nowrap              " don't wrap lines
  set showbreak=>>        " prefix line wraps (only matters if above line is commented)

""""'
" Visual Settings
""""'

  set t_Co=256            " use 256 colors

  set background=dark     " adjust colors for dark backgrounds
  color solarized         " change colorscheme

  syntax on               " turn on syntax highlighting
  set number              " display line numbers

""""'
" Shortcuts
""""'

  inoremap jj <Esc>       " set 'jj' as an alternate escape from insert mode

  inoremap ,, <C-x><C-o>  " set ',,' as a shortcut to code auto-complete

""""'
" Tab Stuff
""""'

  map <C-h> :tabp<CR>     " set ctrl+h to move one tab left
  map <C-l> :tabn<CR>     " set ctrl+l to move one tab right

  map <C-j> <C-w>h        " set ctrl+j to move one vsplit left
  map <C-k> <C-w>l        " set ctrl+k to move one vsplit right

  set tabpagemax=30       " allow 30 tabs to be opened at once

""""'
" Code-Specific Stuff
""""'

  " syntax highlighting for SQL and HTML inside PHP strings
" let php_sql_query=1
  let php_htmlInStrings=1

  " turn on omni-complete
  setlocal omnifunc=syntaxcomplete#Complete
  au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif

  " auto-complete these languages
  au FileType php        set omnifunc=phpcomplete#CompletePHP
  au FileType xml        set omnifunc=xmlcomplete#CompleteTags
  au FileType html       set omnifunc=htmlcomplete#CompleteTags
  au FileType css        set omnifunc=csscomplete#CompleteCSS
  au FileType javascript set omnifunc=javascriptcomplete#CompleteJS

" load plugins with vundle
  filetype off
  set rtp+=~/.vim/bundle/vundle/
  call vundle#rc()

  " let vundle manage itself
  Bundle 'gmarik/vundle'

  " list bundles
  Bundle 'L9'
  Bundle 'skammer/vim-css-color'

  filetype plugin indent on
