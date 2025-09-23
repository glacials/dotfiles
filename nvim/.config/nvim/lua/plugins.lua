return {
	---------------------------------------------------------------------------
	-- CORE & LINTING ----------------------------------------------------------
	---------------------------------------------------------------------------
	-- ale
	-- Language‑agnostic linting server (disabled by default).
	-- { "dense-analysis/ale",
	--   build = "gem install standardrb",
	--   config = function()
	--     vim.g.ale_fix_on_save = 1
	--     vim.g.ale_linters = { ruby = { "standardrb" } }
	--     vim.g.ale_fixers  = { ruby = { "standardrb" } }
	--   end
	-- },

	----------------------------------------------------------------------------
	-- DEBUGGING ---------------------------------------------------------------
	-------------------------------------------------------------------------------

	-- nvim-dap: Debug Adapter Protocol client.
	{ "mfussenegger/nvim-dap" },

	----------------------------------------------------------------------------
	-- FILETYPES & SYNTAX ------------------------------------------------------
	----------------------------------------------------------------------------

	-- chezmoi.vim: Syntax highlighting for Chezmoi files.
	{ "alker0/chezmoi.vim" },

	-- Markdown Preview for (Neo)vim: Preview markdown in an external browser.
	{ "iamcco/markdown-preview.nvim", build = "cd app && yarn install" },

	-- render-markdown.nvim: Preview markdown inside Neovim.
	{ "MeanderingProgrammer/render-markdown.nvim" },

	-- vim-kitty: Syntax highlighting for Kitty config files.
	{ "fladson/vim-kitty" },

	----------------------------------------------------------------------------
	-- SEARCH / NAV ------------------------------------------------------------
	----------------------------------------------------------------------------

	-- greplace.vim: Project‑wide search & replace.
	{ "skwp/greplace.vim" },

	-- telescope.nvim: Reusable fuzzy-finder buffer panes.
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"LinArcX/telescope-command-palette.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("telescope").setup({
				pickers = {
					find_files = { theme = "dropdown" },
					lsp_code_actions = { theme = "cursor" },
					lsp_definitions = { theme = "cursor" },
					lsp_implementations = { theme = "dropdown" },
					lsp_range_code_actions = { theme = "cursor" },
					lsp_references = { theme = "dropdown" },
					lsp_type_definitions = { theme = "cursor" },
				},
			})
			local map = vim.keymap.set
			-- Frequently‑used pickers
			map("n", "<Leader>ff", "<Cmd>Telescope find_files<CR>", { silent = true })
			map("n", "<Leader>fg", "<Cmd>Telescope live_grep<CR>", { silent = true })
			map("n", "<Leader>fb", "<Cmd>Telescope buffers<CR>", { silent = true })
			map("n", "<Leader>fh", "<Cmd>Telescope help_tags<CR>", { silent = true })
			-- map("n", "gr",        "<Cmd>Telescope lsp_references<CR>",        { silent = true })
			-- map("n", "gi",        "<Cmd>Telescope lsp_implementations<CR>",  { silent = true })
			-- map("n", "gd",        "<Cmd>Telescope lsp_definitions<CR>",      { silent = true })
			-- map("n", "gD",        "<Cmd>Telescope lsp_type_definitions<CR>", { silent = true })
			-- map("n", "<Space>wa", "<Cmd>Telescope lsp_code_actions<CR>",     { silent = true })
			map("n", "<Leader>gg", "<Cmd>Telescope resume<CR>", { silent = true })
		end,
	},

	---------------------------------------------------------------------------
	-- USER INTERFACE ----------------------------------------------------------
	---------------------------------------------------------------------------

	-- illuminate.vim: Highlight other uses of the symbol under the cursor.
	{ "RRethy/vim-illuminate" },

	-- Indent Guides: Vertical stripes showing indentation levels.
	{
		"nathanaelkane/vim-indent-guides",
		config = function()
			vim.g.indent_guides_enable_on_vim_startup = 0
		end,
	},

	-- lualine.nvim: Like powerline, but for Neovim.
	{
		"nvim-lualine/lualine.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("lualine").setup({
				options = {
					theme = "auto", -- fix: avoid missing gruvbox theme error
				},
			})
		end,
	},

	-- Neoscroll: Smooth scrolling for ^D and friends.
	{
		"karb94/neoscroll.nvim",
		config = function()
			require("neoscroll").setup({
				mappings = { -- Keys to be mapped to their corresponding default scrolling animation
					"<C-u>",
					"<C-d>",
					"<C-b>",
					"<C-f>",
					"<C-y>",
					"<C-e>",
					"zt",
					"zz",
					"zb",
				},
				hide_cursor = true, -- Hide cursor while scrolling
				stop_eof = true, -- Stop at <EOF> when scrolling downwards
				respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
				cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
				duration_multiplier = 1.0, -- Global duration multiplier
				easing = "linear", -- Default easing function
				pre_hook = nil, -- Function to run before the scrolling animation starts
				post_hook = nil, -- Function to run after the scrolling animation ends
				performance_mode = false, -- Disable "Performance Mode" on all buffers.
				ignored_events = { -- Events ignored while scrolling
					"WinScrolled",
					"CursorMoved",
				},
			})
		end,
	},

	-- nvim-web-devicons: Icons for statuslines, telescope etc.
	{ "nvim-tree/nvim-web-devicons" },

	-- toggleterm.nvim: Improved terminal window management.
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				open_mapping = [[<c-\>]], -- default
				direction = "horizontal", -- or "vertical" or "float"
				shade_terminals = true,
				start_in_insert = true,
				insert_mappings = true,
			})
			vim.keymap.set("n", "<leader>tf", function()
				require("toggleterm.terminal").Terminal:new({ direction = "float" }):toggle()
			end, { desc = "Toggle floating terminal" })
		end,
	},

	-- vinegar.vim: Improvements to netrw that make it rival NERDTree.
	{
		"tpope/vim-vinegar",
		config = function()
			-- Open tree‑style netrw in a left split
			vim.keymap.set("n", "<leader>e", function()
				vim.cmd("topleft vertical 30split")
				vim.cmd("Explore")
			end, { noremap = true, silent = true })
			vim.g.netrw_browse_split = 4 -- open files in previous window
			vim.g.netrw_liststyle = 3 -- tree view by default
		end,
	},

	-- WhichKey: Show available next keys in the current sequence.
	{ "folke/which-key.nvim", config = true },

	---------------------------------------------------------------------------
	-- GIT & PROJECT -----------------------------------------------------------
	---------------------------------------------------------------------------

	-- Buftabline: Show buffers in the statusline.
	{ "akinsho/bufferline.nvim" },

	-- gitlinker.nvim: Open GitHub (etc.) links to lines of code.
	{
		"ruifm/gitlinker.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" },
		config = function()
			require("gitlinker").setup()
		end,
	},

	-- gitsigns.nvim: Deep buffer integration for Git.
	{ "lewis6991/gitsigns.nvim" },

	-- Neogit: Like Magit but for Neovim.
	{
		"neogitorg/neogit",
		dependencies = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" },
		config = true,
	},

	---------------------------------------------------------------------------
	-- LSP / COMPLETION --------------------------------------------------------
	---------------------------------------------------------------------------

	-- conform.nvim: LSP autoformatter.
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		-- This will provide type hinting with LuaLS
		---@module "conform"
		---@type conform.setupOpts
		opts = {
			-- Define your formatters
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black" },
				javascript = { "prettierd", "prettier", stop_after_first = true },
			},
			-- Set default options
			default_format_opts = {
				lsp_format = "fallback",
			},
			-- Set up format-on-save
			format_on_save = { timeout_ms = 500 },
			-- Customize formatters
			formatters = {
				shfmt = {
					append_args = { "-i", "2" },
				},
			},
		},
		init = function()
			-- If you want the formatexpr, here is the place to set it
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		end,
	},

	-- nvim‑cmp: Completion engine for other sources.
	{ "hrsh7th/nvim-cmp" },

	-- nvim‑lightbulb: Show available code actions.
	{ "kosayoda/nvim-lightbulb" },

	-- nvim‑lspconfig: Language server support.
	{
		"neovim/nvim-lspconfig",
		config = function()
			---------------------------------------------------------------------
			-- ON‑ATTACH (ported from original init.lua)
			---------------------------------------------------------------------
			local on_attach = function(_, bufnr)
				local opts = { noremap = true, silent = true, buffer = bufnr }
				local map = vim.keymap.set
				map("n", "gD", vim.lsp.buf.declaration, opts)
				map("n", "gd", vim.lsp.buf.definition, opts)
				map("n", "K", vim.lsp.buf.hover, opts)
				map("n", "gi", vim.lsp.buf.implementation, opts)
				map("n", "<C-k>", vim.lsp.buf.signature_help, opts)
				map("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
				map("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
				map("n", "<space>wl", function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, opts)
				map("n", "<space>D", vim.lsp.buf.type_definition, opts)
				map("n", "<space>rn", vim.lsp.buf.rename, opts)
				map("n", "<space>ca", vim.lsp.buf.code_action, opts)
				map("n", "gr", vim.lsp.buf.references, opts)
				map("n", "<space>e", vim.diagnostic.open_float, opts)
				map("n", "[d", vim.diagnostic.goto_prev, opts)
				map("n", "]d", vim.diagnostic.goto_next, opts)
				map("n", "<space>q", vim.diagnostic.setloclist, opts)
				map("n", "<space>f", function()
					vim.lsp.buf.format({ async = true })
				end, opts)
			end

			---------------------------------------------------------------------
			-- SERVER SETUP ------------------------------------------------------
			---------------------------------------------------------------------
			local servers = { "gopls", "jdtls", "pyright", "solargraph", "ts_ls" }
			local base = {
				on_attach = on_attach,
				flags = { debounce_text_changes = 150 },
			}
			for _, s in ipairs(servers) do
				vim.lsp.config(s, base)
			end

			-- Pyright extras
			do
				local py -- prefer venv, then PYRIGHT_PYTHON, else nil (let pyright decide)
				local venv = vim.env.VIRTUAL_ENV
				if venv and venv ~= "" then
					py = venv .. "/bin/python"
				elseif vim.env.PYRIGHT_PYTHON and vim.env.PYRIGHT_PYTHON ~= "" then
					py = vim.env.PYRIGHT_PYTHON
				end

				vim.lsp.config(
					"pyright",
					vim.tbl_deep_extend("force", base, {
						settings = {
							python = {
								analysis = { exclude = { "**", "*", "**/*" } },
								pythonPath = py,
							},
						},
					})
				)
			end

			-- Start them (can pass a list)
			vim.lsp.enable(servers)
		end,
	},

	-- nvim-treesitter: tree-sitter features.
	{ "nvim-treesitter/nvim-treesitter", lazy = false, branch = "main", build = ":TSUpdate" },

	-- nvim-treesitter‑context: Sticky function headers.
	{ "nvim-treesitter/nvim-treesitter-context" },

	-- Trouble: Pretty buffers to list LSP diagnostics, references, etc.
	{ "folke/trouble.nvim" },

	-- windsurf.nvim: AI autocompletion.
	{ "Exafunction/windsurf.vim" },

	---------------------------------------------------------------------------
	-- EDITING UTILITIES ------------------------------------------------------
	---------------------------------------------------------------------------

	-- commentary.vim: gc to comment a target, gcc to comment a line.
	{ "tpope/vim-commentary" },

	-- endwise.vim: Autoclose if, do, def, etc.
	-- Note: Does not overlap with vim-closer.
	{ "tpope/vim-endwise" },

	-- eunuch.vim: Holistic shell commands (e.g. :Move to mv a file and buffer).
	{ "tpope/vim-eunuch" },

	-- last-look.nvim: Show diff of unsaved buffer(s) before quitting.
	{ "glacials/last-look.nvim" },

	-- sleuth.vim: Auto-adjust shiftwidth and expandtab heuristically.
	{ "tpope/vim-sleuth" },

	-- vim-closer: Autoclose curly braces, parentheses, brackets, etc.
	-- Note: Does not overlap with endwise.vim.
	{ "rstacruz/vim-closer" },

	-- vim-easy-align: ga to align tables, assignments, etc.
	{ "junegunn/vim-easy-align", keys = { { "ga", mode = { "n", "x" } } } },

	-- vim-go: Various Go support.
	{
		"fatih/vim-go",
		build = function()
			vim.fn.system("go install github.com/segmentio/golines@latest")
			vim.cmd("GoInstallBinaries")
		end,
		config = function()
			vim.g.go_fmt_command = "golines"
			vim.g.go_fmt_options = { golines = "-m 80 -t 2" }
		end,
	},

	-- vim-hexokinase: Show color blips by hex codes and color names.
	{ "rrethy/vim-hexokinase", build = "make hexokinase" },

	-- vim-ruby: Various Ruby and HAML support.
	{ "jlcrochet/vim-ruby" },

	-- vim-visual-multi: ^N for multiple cursors.
	{ "mg979/vim-visual-multi" },

	---------------------------------------------------------------------------
	-- THEMES -----------------------------------------------------------------
	---------------------------------------------------------------------------

	-- colors.vim: A collection of color schemes.
	{ "utensils/colors.vim" },

	-- Everforest: A green based color scheme designed to be warm and soft.
	{ "sainnhe/everforest" },

	-- KANAGAWA.nvim: A dark scheme inspired by the Katsushika Hokusai painting.
	{ "rebelot/kanagawa.nvim" },

	-- Nord: An arctic, north-bluish cleana and elegant color scheme.
	{ "nordtheme/vim" },
}
