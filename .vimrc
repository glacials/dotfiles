""""'
" Call Pathogen
""""'
	
	call pathogen#runtime_append_all_bundles()
	call pathogen#helptags()
	
""""'
" General Settings
""""'

	" use vim settings over vi
	set nocompatible
	
	" auto-indent newlines based on current line's indentation;
	" guess when to increase/decrease indenations
	set autoindent
	set smartindent
	
	" live search (i.e. search while typing the search query);
	" ignore case when searching
	set incsearch
	set ignorecase
	
	" don't wrap lines
	set nowrap
	
""""'
" Indentation Settings
""""'
	
	" leave whitespace on blank lines alone
	inoremap <CR> <CR>x<BS>
	
	set tabstop=2
	set softtabstop=2
	set shiftwidth=2
	set noexpandtab
	
	set list

  " display tab characters as >>
	set listchars=tab:»\ ,trail:·
	
""""'
" Visual Settings
""""'
	
	" use 256 colors
	set t_Co=256

	" turn on syntax highlighting
	syntax enable
	
	set background=dark
	colorscheme solarized
	
	set number
	
	" highlight current line
	set cursorline
	
	" if supported, highlight the 80th column
	if exists('+colorcolumn')
		set colorcolumn=80
	endif
	
""""'
" Shortcuts
""""'

	" set 'jj' as an alternate escape from insert mode
	inoremap jj <Esc>
	
	" set ',,' as an alternate auto-complete caller
	inoremap ,, <C-x><C-o>
	
""""'
" Tab Stuff
""""'
	
	" set ctrl+h to move one tab left; ctrl+l to move one tab right
	map <C-h> :tabp<CR>
	map <C-l> :tabn<CR>
	
	" set ctrl+j to move one vsplit left; ctrl+k to move one vsplit right
	map <C-j> <C-w>h
	map <C-k> <C-w>l
	
	" allow many tabs to be opened at startup
	set tabpagemax=20
	
""""'
" Code-Specific Stuff
""""'
	
	" syntax highlighting for SQL and HTML inside PHP strings
	"let php_sql_query=1
	let php_htmlInStrings=1
	
	" syntax highlighting for gpl
	au BufRead,BufNewFile *.gpl set filetype=gpl
	
	" turn on omni-complete
	setlocal omnifunc=syntaxcomplete#Complete
	au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
	
	" auto-complete these languages
	au FileType php  set omnifunc=phpcomplete#CompletePHP
	au FileType xml  set omnifunc=xmlcomplete#CompleteTags
	au FileType html set omnifunc=htmlcomplete#CompleteTags
	au FileType css  set omnifunc=csscomplete#CompleteCSS
	
	filetype plugin indent on
	
