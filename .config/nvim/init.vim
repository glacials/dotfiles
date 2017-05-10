""""'
" Call pathogen
""""'
  runtime bundle/vim-pathogen/autoload/pathogen.vim
  execute pathogen#infect()

""""'
" General settings
""""'

  " guess when to increase/decrease indenations
  set smartindent

  " live search (i.e. search while typing the search query);
  " ignore case when searching
  set incsearch
  set ignorecase

  " pretend certain files aren't there (for rails)
  set wildignore=coverage/*,log/*,public/*,tmp/*,Godeps/*

  " don't wrap lines
  set nowrap

  " make :w!! force a write as root
  ca w!! w !sudo tee > /dev/null "%"

  " store swapfiles elsewhere
  set backupdir=/tmp
  set directory=/tmp

  " allow using the mouse to set cursor position, highlight, etc.
  set mouse=a

  let g:hardtime_default_on=1

""""'
" Operating system behavior settings
""""'

  " use OS X's clipboard register for yanks by default
  set clipboard=unnamed

""""'
" Indentation settings
""""'

  " leave whitespace on blank lines alone
  "inoremap <CR> <CR>x<BS>

  set tabstop=2
  set softtabstop=2
  set shiftwidth=2

  " noexpandtab for tabs, expandtab for spaces. make your choice
  set expandtab

  set list

  " display tab characters as » and trailing spaces as ·
  "set listchars=tab:»\ ,trail:·

  " don't display tab characters or trailing spaces differently
  set listchars=tab:\ \ ,trail:\ "

""""'
" Visual settings
""""'

  " turn on syntax highlighting
  syntax enable

  set termguicolors
  set background=dark
  colorscheme sidonia

  set number

  if has('gui_running')
    set guifont=Source\ Code\ Pro\ ExtraLight:h9
    "set noantialias
  endif

  " highlight current line
  set cursorline

  " if supported, highlight the 121st column (the column after the last column we want to wrap at)
  if exists('+colorcolumn')
    set colorcolumn=121
  endif

  " when we use a wrap command like `gq`, wrap to 120 columns
  set textwidth=120

  " always show the tab bar, even with just one tab open
  set showtabline=2

  " enable vim-indent-guides plugin on startup
  let g:indent_guides_enable_on_vim_startup = 0

  " powerline
  "python from powerline.vim import setup as powerline_setup
  "python powerline_setup()
  "python del powerline_setup

  " boot up NERDTree at launch
  autocmd vimenter * NERDTree

  " close Vim if NERDTree is the only window open
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

""""'
" Shortcuts
""""'

  " set 'jj' as an alternate escape from insert mode
  inoremap jj <Esc>

  " set ',,' as an alternate auto-complete caller
  inoremap ,, <C-x><C-o>

  " keybindings for ctrlp (fuzzy file search plugin)
  let g:ctrlp_map = '<c-p>'
  let g:ctrlp_cmd = 'CtrlP'

  " ag.vim's `:Ag` opens the first result automatically, which I don't like; however its `:Ag!` doesn't, so make that
  " the default
  ca Ag Ag!

  " default to most-recently-used order for Command-T
  :nnoremap <silent> <leader>b :CommandTMRU<CR>

  " allow Alt+{h,j,k,l} to navigate between windows no matter if they are displaying a normal buffer or a terminal
  " buffer in terminal mode
  :tnoremap <A-h> <C-\><C-n><C-w>h
  :tnoremap <A-j> <C-\><C-n><C-w>j
  :tnoremap <A-k> <C-\><C-n><C-w>k
  :tnoremap <A-l> <C-\><C-n><C-w>l
  :nnoremap <A-h> <C-w>h
  :nnoremap <A-j> <C-w>j
  :nnoremap <A-k> <C-w>k
  :nnoremap <A-l> <C-w>l

""""'
" Language-specific stuff
""""'

  " syntax highlighting for SQL and HTML inside PHP strings
  "let php_sql_query=1
  let php_htmlInStrings=1

  " syntax highlighting for gpl
  au BufRead,BufNewFile *.gpl set filetype=gpl

  " syntax highlighting for rabl
  au BufRead,BufNewFile *.rabl set filetype=ruby

  " turn on omni-complete
  setlocal omnifunc=syntaxcomplete#Complete
  au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif

  " auto-complete these languages
  au FileType php  set omnifunc=phpcomplete#CompletePHP
  au FileType xml  set omnifunc=xmlcomplete#CompleteTags
  au FileType html set omnifunc=htmlcomplete#CompleteTags
  au FileType css  set omnifunc=csscomplete#CompleteCSS

  " assume xml for these extensions
  au BufRead,BufNewFile *.lss setfiletype xml " livesplit
  au BufRead,BufNewFile *.lsl setfiletype xml " livesplit layout
  au BufRead,BufNewFile *.lfs setfiletype xml " llanfair (gerad's fork)

  filetype plugin indent on

  " have vim-go run gofmt with -s (simplify code)
  let g:go_fmt_options = '-s'
