""""'
" Call vim-plug & plugins
""""'

  " Install vim-plug if it's not installed (helps with first-time machine setup)
  if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif

  " To install these plugins, open Vim and use :PlugInstall
  " To update, use :PlugUpgrade
  call plug#begin('~/.local/share/nvim/plugged')
  let g:plug_url_format = 'git@github.com:%s.git'

  Plug 'ap/vim-css-color'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'fholgado/minibufexpl.vim'
  Plug 'gregsexton/gitv'
  Plug 'junegunn/vim-easy-align'
  Plug 'mileszs/ack.vim'
  Plug 'monkoose/boa.vim'
  Plug 'nathanaelkane/vim-indent-guides'
  Plug 'rstacruz/vim-closer'
  Plug 'Shougo/deoplete.nvim'
  Plug 'skwp/greplace.vim'
  Plug 'terryma/vim-multiple-cursors'
  Plug 'tlhr/anderson.vim'
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-eunuch'
  Plug 'vim-scripts/ChocolateLiquor'
  Plug 'vim-scripts/nxc.vim'
  Plug 'vimwiki/vimwiki'

  " NERDTree
  Plug 'scrooloose/nerdtree'
  Plug 'xuyuanp/nerdtree-git-plugin'

  " Language-specific plugins (syntax highlighting, etc.)

  " Color schemes
  Plug 'rakr/vim-two-firewatch'

  call plug#end()

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
  set formatoptions-=t

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

  " use macOS's clipboard register for yanks by default
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
  colorscheme two-firewatch

  " show line numbers
  set number

  " auto-load file changes
  set autoread

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

  " when we use a wrap command like `gqj`, wrap to 120 columns
  set textwidth=120

  " when we use a wrap command like `gqj`, join sentences using one space between them, not two
  :set nojoinspaces

  " always show the tab bar, even with just one tab open
  set showtabline=2

  " enable vim-indent-guides plugin on startup
  let g:indent_guides_enable_on_vim_startup = 0

  " boot up a NERDTree window at launch (then switch back to main window)
  autocmd vimenter * NERDTree
  autocmd vimenter * wincmd p

  " close Vim if NERDTree is the only window open
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

""""'
" Shortcuts
""""'

  " set 'jk' as an alternate escape from insert mode
  inoremap jk <Esc>

  " set ',,' as an alternate auto-complete caller
  inoremap ,, <C-x><C-o>

  " keybindings for ctrlp (fuzzy file search plugin)
  let g:ctrlp_map = '<c-p>'
  let g:ctrlp_cmd = 'CtrlP'

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

  " start interactive EasyAlign in visual mode (e.g. vipga)
  xmap ga <Plug>(EasyAlign)
  " start interactive EasyAlign for a motion/text object (e.g. gaip)
  nmap ga <Plug>(EasyAlign)

""""'
" Language-specific stuff
""""'

  " assume xml for these extensions
  au BufRead,BufNewFile *.lss setfiletype xml " livesplit
  au BufRead,BufNewFile *.lsl setfiletype xml " livesplit layout
  au BufRead,BufNewFile *.lfs setfiletype xml " llanfair (gerad's fork)

  filetype plugin indent on

  " have vim-go run gofmt with -s (simplify code)
  let g:go_fmt_options = '-s'
