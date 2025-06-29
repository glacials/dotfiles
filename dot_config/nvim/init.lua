-- Bootstrap lazy.nvim for plugin management (unchanged)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins")

-- ---------------------------------------------------------------------------
-- Options -------------------------------------------------------------------
local opt = vim.opt

-- General -------------------------------------------------------------------
opt.autoread      = true
opt.background    = "dark"
opt.backupdir     = "/tmp"
opt.clipboard     = "unnamedplus"          -- yank to the macOS clipboard for ⌘V
opt.colorcolumn   = "81"                  -- show a vertical stripe on column 81
opt.cursorline    = true                  -- highlight the line the cursor is on
opt.directory     = "/tmp"
opt.expandtab     = true                -- have tab key inserts spaces, not tabs
opt.formatoptions:remove("t")          -- don't auto-hard-wrap lines when typing
opt.ignorecase    = true                   -- case-insensitive search by default
opt.incsearch     = true      -- search without waiting for return to be pressed
opt.joinspaces    = false
opt.list          = true
opt.listchars     = { tab = "  ", trail = " " }
opt.mouse         = "a"                               -- allow mouse interaction
opt.number        = true                                    -- show line numbers
opt.scrolloff     = 6      -- keep 6 lines above/below the cursor when scrolling
opt.shiftwidth    = 2
opt.showtabline   = 2
opt.smartindent   = true                  -- stay indented after pressing return
opt.softtabstop   = 2
opt.tabstop       = 2
opt.termguicolors = true
opt.textwidth     = 80  -- wrapping actions operate on text past the 80th column
opt.wildignore    = { "coverage/*", "log/*", "public/*", "tmp/*", "Godeps/*" }
opt.wrap          = false

if vim.fn.has("gui_running") == 1 then
  opt.guifont = "Source Code Pro ExtraLight:h9"
end

-- ----------------------------------------------------------------------------
-- Globals --------------------------------------------------------------------
vim.g.hardtime_default_on              = 1
vim.g.markdown_folding                 = 1
vim.g.markdown_fenced_languages        = { "html", "python", "bash=sh", "ruby", "javascript", "go" }

-- ----------------------------------------------------------------------------
-- Color Scheme & Syntax -------------------------------------------------------
pcall(vim.cmd, "syntax enable")
pcall(vim.cmd, "colorscheme kanagawa")

-- ----------------------------------------------------------------------------
-- Keymaps --------------------------------------------------------------------
local map = vim.keymap.set
local silent = { noremap = true, silent = true }
-- Soft‑wrap aware j/k
map("n", "j", "gj", silent)
map("n", "k", "gk", silent)
-- Insert‑mode helpers
map("i", "jk", "<Esc>", silent)
map("i", ",,", "<C-x><C-o>", silent)
-- Window navigation – Alt
map("t", "<A-h>", "<C-\\><C-n><C-w>h", silent)
map("t", "<A-j>", "<C-\\><C-n><C-w>j", silent)
map("t", "<A-k>", "<C-\\><C-n><C-w>k", silent)
map("t", "<A-l>", "<C-\\><C-n><C-w>l", silent)
map("n", "<A-h>", "<C-w>h", silent)
map("n", "<A-j>", "<C-w>j", silent)
map("n", "<A-k>", "<C-w>k", silent)
map("n", "<A-l>", "<C-w>l", silent)
-- Window navigation – Ctrl‑hjkl
map("n", "<C-h>", "<C-w>h", silent)
map("n", "<C-j>", "<C-w>j", silent)
map("n", "<C-k>", "<C-w>k", silent)
map("n", "<C-l>", "<C-w>l", silent)
-- Reload config
map("n", "<leader>sv", function()
  vim.cmd("luafile " .. vim.env.MYVIMRC)
  print("init.lua reloaded ✔︎")
end, silent)

-- ----------------------------------------------------------------------------
-- Commands -------------------------------------------------------------------
-- :W – write buffer with sudo (replacement for cabbrev w!!)
vim.api.nvim_create_user_command("W", function()
  if vim.bo.modified then
    local tmp = vim.fn.tempname()
    vim.cmd(string.format("write %s", tmp))        -- write to temp file first
    vim.fn.system(string.format("sudo tee %s > /dev/null", vim.fn.shellescape(vim.fn.expand("%:p"))), tmp)
    vim.cmd("edit!")                               -- reload without prompts
    print("Saved with sudo")
  end
end, { desc = "Write current file with sudo" })

-- ----------------------------------------------------------------------------
-- Autocommands ---------------------------------------------------------------
local augroup = vim.api.nvim_create_augroup
local autocmd  = vim.api.nvim_create_autocmd

-- Open netrw if launched without arguments.
augroup("ProjectDrawer", { clear = true })
autocmd("VimEnter", {
  group = "ProjectDrawer",
  callback = function()
    if vim.fn.argc() == 0 then
      vim.cmd("Explore!")
    end
  end,
})

-- Filetype associations
augroup("LivesplitXML", { clear = true })
autocmd({ "BufRead", "BufNewFile" }, {
  group    = "LivesplitXML",
  pattern  = { "*.lss", "*.lsl", "*.lfs" },
  callback = function() vim.bo.filetype = "xml" end,
})

-- Markdown fold settings
augroup("MarkdownFolds", { clear = true })
autocmd("FileType", {
  group = "MarkdownFolds",
  pattern = "markdown",
  callback = function() vim.opt_local.foldlevel = 99 end,
})
