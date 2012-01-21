""""'
" Call Pathogen
""""'
	
	call pathogen#runtime_append_all_bundles()
	call pathogen#helptags()
	
""""'
" General Settings
""""'
	
	set nocompatible               " use vim settings over vi
	
	set autoindent                 " auto-indent newlines based on current line's indentation
	set smartindent                " guess when to increase/decrease indentations (e.g. curly braces)
	
	set incsearch                  " live search (i.e. search while typing the search query)
	set ignorecase                 " ignore case when searching
	
	set nowrap                     " don't wrap lines
	set showbreak=>>               " prefix line wraps (only matters if above line is commented)
	
	
""""'
" Indentation Settings
""""'
	
	" leave whitespace on blank lines alone
	inoremap <CR> <CR>x<BS>
	
	set tabstop=2                  " set tab display width to 2
	set softtabstop=2              " set tab insert width to 2
	set shiftwidth=2               " set auto-indent width to 2
	set noexpandtab                " do not use spaces in place of tabs
	
	set list
	set listchars=tab:»\ ,trail:·  " display tab characters as >>
""""'
" Visual Settings
""""'
	
	set t_Co=256                  " use 256 colors
	syntax enable                 " turn on syntax highlighting
	
	set background=dark           " adjust colors for dark backgrounds
	colorscheme solarized               " change colorscheme
	
	set number                    " display line numbers
	
	set cursorline                " highlight current line
	
	if exists('+colorcolumn')
		set colorcolumn=80          " highlight the 80th column (if supported)
	endif
	
""""'
" Shortcuts
""""'
	
	inoremap jj <Esc>       " set 'jj' as an alternate escape from insert mode
	
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
	
	set tabpagemax=20             " allow many tabs to be opened at startup
	
""""'
" Code-Specific Stuff
""""'
	
	" syntax highlighting for SQL and HTML inside PHP strings
"	let php_sql_query=1
	let php_htmlInStrings=1
	
	" turn on omni-complete
	setlocal omnifunc=syntaxcomplete#Complete
	au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
	
	" auto-complete these languages
	au FileType php        set omnifunc=phpcomplete#CompletePHP
	au FileType xml        set omnifunc=xmlcomplete#CompleteTags
	au FileType html       set omnifunc=htmlcomplete#CompleteTags
	au FileType css        set omnifunc=csscomplete#CompleteCSS
	
	filetype plugin indent on
	
