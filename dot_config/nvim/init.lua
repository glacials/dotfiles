-- Initialize vim-plug.
-- Manages plugins. TODO: Consider moving to lazy.vim.
-- https://github.com/junegunn/vim-plug
vim.cmd([[

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  vim.call.autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

]])

-- ** -- ** ------------------- ** -- ** --
-- ** -- ** -- START PLUGINS -- ** -- ** --
-- ** -- ** ------------------- ** -- ** --

--
-- Plugin tips --
--
-- :PlugInstall:     Install plugins.
-- :PlugUpdate:      Update plugins.
-- :PlugUpgrade:     Update plugin manager.
-- :source $MYVIMRC: Reload init file.
--

vim.cmd([[

call plug#begin('~/.local/share/nvim/plugged')

]])

local Plug = vim.fn['plug#']

-- ale
-- Language-agnostic linting server.
-- Plug('https://github.com/dense-analysis/ale', {['do'] = 'gem install standardrb'})
-- Configuration.
vim.g.ale_fix_on_save = 1
vim.g.ale_linters = {['ruby'] = {'standardrb'}}
vim.g.ale_fixers = {['ruby'] = {'standardrb'}}

-- chezmoi
-- Syntax highlighting for Chezmoi-managed dotfiles.
Plug('https://github.com/alker0/chezmoi.vim')

-- Diffview.nvim
-- Review changed files for any Git revision.
-- Required by: Neogit.
Plug('https://github.com/sindrets/diffview.nvim')

-- glow
-- Preview Markdown inside Vim.
Plug('https://github.com/ellisonleao/glow.nvim')

-- greplace.vim
-- Global search and replace.
Plug('https://github.com/skwp/greplace.vim')

-- lualine
-- Modern version of Powerline.
Plug('https://github.com/nvim-lualine/lualine.nvim')
-- Optional dependency: nvim-web-devicons
-- Icons for use by the status line.
Plug('https://github.com/nvim-tree/nvim-web-devicons')

-- markdown-preview
-- Preview Markdown outside Vim.
Plug('https://github.com/iamcco/markdown-preview.nvim', {
  ['do'] = 'cd app && yarn install'
})

-- minibufexpl
-- Show open buffers at the top of the viewport.
Plug('https://github.com/fholgado/minibufexpl.vim')

-- Neoformat
-- Invoke formatters automatically.
-- Plug('https://github.com/sbdchd/neoformat')

-- Neogit
-- Interactive Git interface.
-- Requires: Diffview.nvim.
Plug('https://github.com/neogitorg/neogit')

-- nvim-cmp
-- Fixes a specific autocomplete issue:
-- https://www.reddit.com/r/neovim/comments/ugyekq/lsp_autocomplete_fails_after_07_update/
Plug('https://github.com/hrsh7th/nvim-cmp')

-- nvim-lightbulb
-- Shows a gutter lightbulb when autocompletion is available.
Plug('https://github.com/kosayoda/nvim-lightbulb')

-- nvim-lspconfig
-- Common language server configurations for every language under the sun.
Plug('https://github.com/neovim/nvim-lspconfig')

-- nvim-treesitter-context
-- Makes function signatures etc. sticky at top-of-screen.
Plug('https://github.com/nvim-treesitter/nvim-treesitter-context')

-- plenary.vim
-- Lua library of common functions.
-- Required by: Neogit.
Plug('https://github.com/nvim-lua/plenary.nvim')

-- telescope
-- Live-updating fuzzy finder for lists (e.g. files, grep).
Plug('https://github.com/nvim-telescope/telescope.nvim')
-- Related keymaps:
vim.api.nvim_set_keymap('n', '<Leader>ff', '<Cmd>Telescope find_files<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>fg', '<Cmd>Telescope live_grep<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>fb', '<Cmd>Telescope buffers<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>fh', '<Cmd>Telescope help_tags<CR>', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', 'gr <Cmd>Telescope', 'lsp_references<CR>', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', '<Space>wa <cmd>Telescope', 'lsp_code_actions<CR>', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', 'gi <Cmd>Telescope', 'lsp_implementation<CR>', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', 'gd <Cmd>Telescope', 'lsp_definitions<CR>', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', 'gD <Cmd>Telescope', 'lsp_type_definitions<CR>', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', '<Leader>g <cmd>Telescope', 'resume<CR>', {noremap = true, silent = true})
-- Optional dependency: nvim-web-devicons
-- Icons for use in Telescope.
Plug('https://github.com/nvim-tree/nvim-web-devicons')
-- Optional dependency: plenary
-- A library of commonly used Lua functions.
Plug('https://github.com/nvim-lua/plenary.nvim')
-- Optional dependency: telescope-command-palette
-- Adds a VSCode-like command palette to Telescope.
Plug('https://github.com/LinArcX/telescope-command-palette.nvim')
-- Optional dependency: telescope-fzf-native.nvim
-- Use fzf for Telescope fuzzy file search.
Plug('https://github.com/nvim-telescope/telescope-fzf-native.nvim', {['do'] = 'make'})

-- vim-closer
-- Autoclose curly braces and other equivalents.
Plug('https://github.com/rstacruz/vim-closer')

-- vim-commentary
-- Adds keymaps for {,un}commenting lines.
Plug('https://github.com/tpope/vim-commentary')

-- vim-easy-align
-- Advanced line alignment.
Plug('https://github.com/junegunn/vim-easy-align')
-- Related keymaps:
vim.api.nvim_set_keymap('n', 'ga', '<Plug>(EasyAlign)', {noremap = true, silent = true})
vim.api.nvim_set_keymap('x', 'ga', '<Plug>(EasyAlign)', {noremap = true, silent = true})

-- vim-endwise
-- Autoclose curly braces and other equivalents.
Plug('https://github.com/tpope/vim-endwise')

-- vim-eunuch
-- Holistic shell commands (e.g. :Delete to delete a file & close its buffer).
Plug('https://github.com/tpope/vim-eunuch')

-- vim-go
-- Various Go enhancements.
-- NOTE: Below settings replace gofmt with golines, which is stricter.
Plug('https://github.com/fatih/vim-go', {['do'] = 'go install github.com/segmentio/golines@latest'})
vim.cmd([[
  let g:go_fmt_command = 'golines'
  let g:go_fmt_options = {'golines': '-m 80 -t 2'}
]])

-- vim-hexokinase
-- Colorize color hex codes & names.
Plug('https://github.com/rrethy/vim-hexokinase', {['do'] = 'make hexokinase'})

-- vim-indentguides
-- Stylize indent levels.
Plug('https://github.com/nathanaelkane/vim-indent-guides')

-- vim-kitty
-- Syntax highlighting for Kitty config files.
Plug('https://github.com/fladson/vim-kitty')

-- vim-prettier
-- Support for Prettier, a formatter for web frontend languages.
Plug('https://github.com/prettier/vim-prettier', {['do'] = 'yarn install --frozen-lockfile --production'})
vim.cmd([[
  let g:prettier#autoformat = 1
  let g:prettier#autoformat_require_pragma = 0
  " With prettier-plugin-go-template installed, cover additional files:
  autocmd BufWritePre *.gohtml,*.gotmpl,*.go.tmpl,*.tmpl,*.tpl,*.html.tmpl noautocmd call prettier#Autoformat()
]])

-- vim-ruby
-- Enhancements for Ruby.
Plug('https://github.com/jlcrochet/vim-ruby')

-- vim-sensible
-- Sets sensible defaults to build on.
Plug('https://github.com/tpope/vim-sensible')

-- vim-sleuth
-- Autodetect indentation settings based on file & directory.
Plug('https://github.com/tpope/vim-sleuth')

-- vim-surround
-- cs"' to change surrounding double quotes to single;
-- VS<p> to surround current line with <p>...</p>.
Plug('https://github.com/tpope/vim-surround')

-- vim-vinegar
-- Enhancements to netrw.
Plug('https://github.com/tpope/vim-vinegar')
vim.keymap.set('n', '<leader>e', function()
  vim.cmd('topleft vertical 30split') -- Create vsplit on left with width 30
  vim.cmd('Explore')                  -- Start netrw in that split
end, { noremap = true, silent = true })
vim.g.netrw_browse_split = 4          -- netrw: open files in previous window
vim.g.netrw_liststyle = 3             -- netrw: "tree" display style by default

-- vim-visual-multi
-- Multiple cursors.
Plug('https://github.com/mg979/vim-visual-multi')

-- which-key
-- Completions for key sequences.
Plug('https://github.com/folke/which-key.nvim')

-------------------------
-- START THEME PLUGINS --
-------------------------

-- colors
-- A large collection of themes.
Plug('https://github.com/utensils/colors.vim')

-- everforest
-- A green theme.
Plug('https://github.com/sainnhe/everforest')

-- nord-vim
-- A blue theme.
Plug('https://github.com/nordtheme/vim')

-----------------------
-- END THEME PLUGINS --
-----------------------

vim.call('plug#end')
-- ** -- ** ----------------- ** -- ** --
-- ** -- ** -- END PLUGINS -- ** -- ** --
-- ** -- ** ----------------- ** -- ** --


-- ** -- ** -------------------------------- ** -- ** --
-- ** -- ** -- START PLUGIN CONFIGURATION -- ** -- ** --
-- ** -- ** -------------------------------- ** -- ** --

-- Initialize lualine. Must come after plug#end.
require('lualine').setup()

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
  buf_set_keymap('n', 'gD',        '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd',        '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K',         '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi',        '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>',     '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D',  '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr',        '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e',  '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d',        '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d',        '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q',  '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f',  '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

local servers = {
  'gopls',      -- Go
  'jdtls',      -- Java
  'pyright',    -- Python: npm i -g pyright
  'solargraph', -- Ruby: gem install solargraph
  'tsserver',   -- TypeScript: npm install -g typescript
}

local lspconfig = require('lspconfig')

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

lspconfig.pyright.setup({
  settings = {
    python = {
      analysis = {
        exclude = {"**", "*", "**/*"},
      },
      pythonPath = vim.fn.getenv('VIRTUAL_ENV') and (vim.fn.getenv('VIRTUAL_ENV') .. '/bin/python') or vim.fn.getenv('PYRIGHT_PYTHON'),
    },
  },
})

-- Configure Telescope. Must come after plug#end.
require('telescope').setup{
  pickers = {
    find_files = {theme = "ivy"},
    lsp_code_actions = {theme = "cursor"},
    lsp_definitions = {theme = "cursor"},
    lsp_implementations = {theme = "dropdown"},
    lsp_range_code_actions = {theme = "cursor"},
    lsp_references = {theme = "dropdown"},
    lsp_type_definitions = {theme = "cursor"},
  }
}

-- ** -- ** ------------------------------ ** -- ** --
-- ** -- ** -- END PLUGIN CONFIGURATION -- ** -- ** --
-- ** -- ** ------------------------------ ** -- ** --

vim.cmd([[

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
colorscheme everforest " Use https://vimcolorschemes.com to find more

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

]])
