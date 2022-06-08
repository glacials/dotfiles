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
" To update, use :PlugUpgrade and :PlugUpdate
call plug#begin('~/.local/share/nvim/plugged')
let g:plug_url_format = 'git@github.com:%s.git'

" Colorize e.g. hex codes
Plug 'ap/vim-css-color'

" Show open buffers at the top of the screen
Plug 'fholgado/minibufexpl.vim'

" Preview Markdown files inside Neovim
Plug 'ellisonleao/glow.nvim'

" Preview Markdown files outside Neovim
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

Plug 'gregsexton/gitv'
Plug 'junegunn/vim-easy-align'
Plug 'arcticicestudio/nord-vim'

" Telescope (fuzzy file / text finder)
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
" Use Telescope UI for some LSP shortcuts
nnoremap gr <cmd>Telescope lsp_references<cr>
nnoremap <space>wa <cmd>Telescope lsp_code_actions<cr>
nnoremap gi <cmd>Telescope lsp_implementation<cr>
nnoremap gd <cmd>Telescope lsp_definitions<cr>
nnoremap gD <cmd>Telescope lsp_type_definitions<cr>
" Resume last Telescope search
nnoremap <leader>g <cmd>Telescope resume<cr>
" Telescope optional dependencies
Plug 'kyazdani42/nvim-web-devicons'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

Plug 'nathanaelkane/vim-indent-guides'
Plug 'rstacruz/vim-closer'
Plug 'skwp/greplace.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-endwise'

" cs"' to change surrounding double-quotes to single-quotes
" VS<p> to surround current line with <p></p>
Plug 'tpope/vim-surround'

" git <subcommand> as :Git <subcommand>
Plug 'tpope/vim-fugitive'

" More holistic shell commands, e.g. :Delete to delete a file + close its buffer
Plug 'tpope/vim-eunuch'

" Autodetect the right indentation style based on file
Plug 'tpope/vim-sleuth'

" netrw enhancements
Plug 'tpope/vim-vinegar'

" Color schemes
Plug 'utensils/colors.vim'

" Show a lightbulb in the gutter when autocomplete is available
Plug 'kosayoda/nvim-lightbulb'

" Fix this issue https://www.reddit.com/r/neovim/comments/ugyekq/lsp_autocomplete_fails_after_07_update/
Plug 'hrsh7th/nvim-cmp'

" Language server stuff
Plug 'neovim/nvim-lspconfig' " Official collection of common LSP configs
Plug 'dense-analysis/ale' " Async language-agnostic linting server

" Go
" Various Go niceties (remove 'do' if removing golines as the gofmt command)
Plug 'fatih/vim-go', { 'do': 'go install github.com/segmentio/golines@latest' }
" Amend gofmt to also wrap lines
let g:go_fmt_command = "golines"
let g:go_fmt_options = {'golines': '-m 80 -t 2'}

" Kitty config syntax highlighting.
Plug 'fladson/vim-kitty'

" Ruby
Plug 'jlcrochet/vim-ruby'

" Prettier (formatter for HTML, CSS, JS, TS, GraphQL, Markdown, JSON, ...)
Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }
let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0

" Magic
Plug 'github/copilot.vim'

call plug#end()

" Ruby
let g:ale_fix_on_save = 1
let g:ale_linters = {'ruby': ['standardrb']} " gem install standardrb
let g:ale_fixers = {'ruby': ['standardrb']}

" Language server init (must be after plug#end)
lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  -- buf_set_keymap('n', 'gD',        '<cmd>lua vim.lsp.buf.declaration()<CR>', opts) -- Overridden by Telescope (above)
  -- buf_set_keymap('n', 'gd',        '<cmd>lua vim.lsp.buf.definition()<CR>', opts) -- Overridden by Telescope (above)
  buf_set_keymap('n', 'K',         '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  -- buf_set_keymap('n', 'gi',        '<cmd>lua vim.lsp.buf.implementation()<CR>', opts) -- Overridden by Telescope (above)
  buf_set_keymap('n', '<C-k>',     '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D',  '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  -- buf_set_keymap('n', 'gr',        '<cmd>lua vim.lsp.buf.references()<CR>', opts) -- Overridden by Telescope (above)
  buf_set_keymap('n', '<space>e',  '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d',        '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d',        '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q',  '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f',  '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

local servers = {
  'gopls', -- Go
  'pyright', -- Python: npm i -g pyright
  'solargraph', -- Ruby: gem install solargraph
}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF

" Set up Ruby language server
lua <<EOF
  require'lspconfig'.solargraph.setup{}
EOF

" Organize Go imports on save
lua <<EOF
  function goimports(timeout_ms)
    local context = { only = { "source.organizeImports" } }
    vim.validate { context = { context, "t", true } }

    local params = vim.lsp.util.make_range_params()
    params.context = context

    -- See the implementation of the textDocument/codeAction callback
    -- (lua/vim/lsp/handler.lua) for how to do this properly.
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
    if not result or next(result) == nil then return end
    local actions = result[1].result
    if not actions then return end
    local action = actions[1]

    -- textDocument/codeAction can return either Command[] or CodeAction[]. If it
    -- is a CodeAction, it can have either an edit, a command or both. Edits
    -- should be executed first.
    if action.edit or type(action.command) == "table" then
      if action.edit then
        vim.lsp.util.apply_workspace_edit(action.edit)
      end
      if type(action.command) == "table" then
        vim.lsp.buf.execute_command(action.command)
      end
    else
      vim.lsp.buf.execute_command(action)
    end
  end
EOF

" Telescope config (must be after plug#end)
lua << EOF
require('telescope').setup{
  pickers = {
    find_files = {
      theme = "ivy",
    },
    lsp_code_actions = {
      theme = "cursor",
    },
    lsp_definitions = {
      theme = "cursor",
    },
    lsp_implementations = {
      theme = "cursor",
    },
    lsp_range_code_actions = {
      theme = "cursor",
    },
    lsp_references = {
      theme = "cursor",
    },
    lsp_type_definitions = {
      theme = "cursor",
    },
  }
}
EOF

autocmd BufWritePre *.go lua goimports(1000)


""""'
" General settings
""""'

" guess when to increase/decrease indenations
set smartindent

" live search (i.e. search while typing the search query);
" ignore case when searching
set incsearch
set ignorecase

" pretend certain files aren't there
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

" Automatically enter netrw (file browser) if booted without arguments
augroup ProjectDrawer
    autocmd!
    autocmd VimEnter * if argc() == 0 | Explore! | endif
augroup END

""""'
" Operating system behavior settings
""""'

" use macOS's clipboard register for yanks by default
set clipboard=unnamed

""""'
" Indentation settings
""""'

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
colorscheme nord " Use https://vimcolorschemes.com to find more

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

" if supported, highlight the 81st column (the column after the last column we want to wrap at)
if exists('+colorcolumn')
  set colorcolumn=81
endif

" When we use a wrap command like `gqj`, wrap to 80 columns
set textwidth=80

" Move the cursor through soft-wrapped lines, instead of jumping across them
noremap j gj
noremap k gk

" when we use a wrap command like `gqj`, join sentences using one space between them, not two
:set nojoinspaces

" always show the tab bar, even with just one tab open
set showtabline=2

" enable vim-indent-guides plugin on startup
let g:indent_guides_enable_on_vim_startup = 0

""""'
" Shortcuts
""""'

" set 'jk' as an alternate escape from insert mode
inoremap jk <Esc>

" set ',,' as an alternate auto-complete caller
inoremap ,, <C-x><C-o>

" allow Alt+{h,j,k,l} to navigate between windows no matter if they are displaying a normal buffer or a terminal
" buffer in terminal mode
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" map Ctrl+{h,j,k,l} to navigate between windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Set '<leader>sv' (usually <leader> is backslash) to source init.vim
nnoremap <leader>sv :source $MYVIMRC<CR>


""""'
" Language-specific stuff
""""'

" assume xml for these extensions
au BufRead,BufNewFile *.lss setfiletype xml " livesplit
au BufRead,BufNewFile *.lsl setfiletype xml " livesplit layout
au BufRead,BufNewFile *.lfs setfiletype xml " llanfair (gerad's fork)

" Automatically fold Markdown at headings
let g:markdown_folding = 1

" Open file with folds unfolded
au FileType markdown setlocal foldlevel=99

" Highlight fenced code blocks
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'ruby', 'javascript', 'go']

filetype plugin indent on
