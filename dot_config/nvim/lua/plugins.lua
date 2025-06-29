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

  ---------------------------------------------------------------------------
  -- FILETYPES & SYNTAX ------------------------------------------------------
  ---------------------------------------------------------------------------
  -- chezmoi.vim: Syntax highlighting for Chezmoi files.
  { "alker0/chezmoi.vim" },

  -- Diffview: Better diff handling.
  -- Required by: Neogit
  { "sindrets/diffview.nvim" },

  -- Glow: Preview markdown inside Neovim.
  { "ellisonleao/glow.nvim" },

  -- vim-kitty: Syntax highlighting for Kitty config files.
  { "fladson/vim-kitty" },

  -- markdown‑preview: Preview markdown in an external browser.
  { "iamcco/markdown-preview.nvim", build = "cd app && yarn install" },

  ---------------------------------------------------------------------------
  -- SEARCH / NAV ------------------------------------------------------------
  ---------------------------------------------------------------------------
  -- Telescope: Reusable fuzzy-finder buffer panes.
  { "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "LinArcX/telescope-command-palette.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("telescope").setup{
        pickers = {
          find_files            = { theme = "dropdown" },
          lsp_code_actions      = { theme = "cursor"   },
          lsp_definitions       = { theme = "cursor"   },
          lsp_implementations   = { theme = "dropdown" },
          lsp_range_code_actions= { theme = "cursor"   },
          lsp_references        = { theme = "dropdown" },
          lsp_type_definitions  = { theme = "cursor"   },
        }
      }
      local map = vim.keymap.set
      -- Frequently‑used pickers
      map("n", "<Leader>ff", "<Cmd>Telescope find_files<CR>", { silent = true })
      map("n", "<Leader>fg", "<Cmd>Telescope live_grep<CR>",  { silent = true })
      map("n", "<Leader>fb", "<Cmd>Telescope buffers<CR>",    { silent = true })
      map("n", "<Leader>fh", "<Cmd>Telescope help_tags<CR>", { silent = true })
      -- map("n", "gr",        "<Cmd>Telescope lsp_references<CR>",        { silent = true })
      -- map("n", "gi",        "<Cmd>Telescope lsp_implementations<CR>",  { silent = true })
      -- map("n", "gd",        "<Cmd>Telescope lsp_definitions<CR>",      { silent = true })
      -- map("n", "gD",        "<Cmd>Telescope lsp_type_definitions<CR>", { silent = true })
      -- map("n", "<Space>wa", "<Cmd>Telescope lsp_code_actions<CR>",     { silent = true })
      -- map("n", "<Leader>g", "<Cmd>Telescope resume<CR>",               { silent = true })
    end
  },

  -- greplace: Project‑wide search & replace.
  { "skwp/greplace.vim" },

  ---------------------------------------------------------------------------
  -- USER INTERFACE ----------------------------------------------------------
  ---------------------------------------------------------------------------
  -- Icons for statuslines, telescope etc.
  { "nvim-tree/nvim-web-devicons" },

  -- Lualine status line
  { "nvim-lualine/lualine.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function() require("lualine").setup {
      options = {
        theme = "auto" -- fix: avoid missing gruvbox theme error
      }
    } end
  },

  -- Indent guides
  { "nathanaelkane/vim-indent-guides",
    config = function() vim.g.indent_guides_enable_on_vim_startup = 0 end
  },

  -- vim‑vinegar + custom netrw setup
  { "tpope/vim-vinegar",
    config = function()
      -- Open tree‑style netrw in a left split
      vim.keymap.set("n", "<leader>e", function()
        vim.cmd("topleft vertical 30split")
        vim.cmd("Explore")
      end, { noremap = true, silent = true })
      vim.g.netrw_browse_split = 4   -- open files in previous window
      vim.g.netrw_liststyle    = 3   -- tree view by default
    end
  },

  -- which‑key popup
  { "folke/which-key.nvim", config = true },

  ---------------------------------------------------------------------------
  -- GIT & PROJECT -----------------------------------------------------------
  ---------------------------------------------------------------------------
  -- Plenary helper lib (required by numerous plugins)
  { "nvim-lua/plenary.nvim" },

  -- Neogit (Git UI)
  { "neogitorg/neogit",
    dependencies = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" },
    config = true
  },

  -- minibufexpl (buffer line)
  { "fholgado/minibufexpl.vim" },

  ---------------------------------------------------------------------------
  -- LSP / COMPLETION --------------------------------------------------------
  ---------------------------------------------------------------------------
  -- nvim‑cmp: Completion engine for other sources.
  { "hrsh7th/nvim-cmp" },

  -- nvim‑lightbulb: Show available code actions.
  { "kosayoda/nvim-lightbulb" },

  -- nvim-treesitter‑context: Sticky function headers.
  { "nvim-treesitter/nvim-treesitter-context" },

  -- nvim‑lspconfig: Language server support.
  { "neovim/nvim-lspconfig",
    config = function()
      ---------------------------------------------------------------------
      -- ON‑ATTACH (ported from original init.lua)
      ---------------------------------------------------------------------
      local on_attach = function(_, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }
        local map = vim.keymap.set
        map("n", "gD",        vim.lsp.buf.declaration,           opts)
        map("n", "gd",        vim.lsp.buf.definition,            opts)
        map("n", "K",         vim.lsp.buf.hover,                 opts)
        map("n", "gi",        vim.lsp.buf.implementation,        opts)
        map("n", "<C-k>",     vim.lsp.buf.signature_help,        opts)
        map("n", "<space>wa", vim.lsp.buf.add_workspace_folder,  opts)
        map("n", "<space>wr", vim.lsp.buf.remove_workspace_folder,opts)
        map("n", "<space>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
        map("n", "<space>D",  vim.lsp.buf.type_definition,       opts)
        map("n", "<space>rn", vim.lsp.buf.rename,                opts)
        map("n", "<space>ca", vim.lsp.buf.code_action,           opts)
        map("n", "gr",        vim.lsp.buf.references,            opts)
        map("n", "<space>e",  vim.diagnostic.open_float,         opts)
        map("n", "[d",        vim.diagnostic.goto_prev,          opts)
        map("n", "]d",        vim.diagnostic.goto_next,          opts)
        map("n", "<space>q",  vim.diagnostic.setloclist,         opts)
        map("n", "<space>f",  function() vim.lsp.buf.format { async = true } end, opts)
      end

      ---------------------------------------------------------------------
      -- SERVER SETUP ------------------------------------------------------
      ---------------------------------------------------------------------
      local servers   = { "gopls", "jdtls", "pyright", "solargraph", "ts_ls" }
      local lspconfig = require("lspconfig")
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup{
          on_attach = on_attach,
          flags     = { debounce_text_changes = 150 },
        }
      end
      -- Pyright extras
      lspconfig.pyright.setup{
        on_attach = on_attach,
        settings  = {
          python = {
            analysis = { exclude = {"**", "*", "**/*"} },
            pythonPath = (function()
              local venv = vim.env.VIRTUAL_ENV
              if venv and venv ~= "" then
                return venv .. "/bin/python"
              end
              local alt = vim.env.PYRIGHT_PYTHON
              if alt and alt ~= "" then
                return alt
              end
              return nil -- let pyright decide
            end)()
              and (vim.fn.getenv("VIRTUAL_ENV") .. "/bin/python")
               or vim.fn.getenv("PYRIGHT_PYTHON"),
          },
        },
      }
    end
  },

  { "Exafunction/windsurf.vim" },

  ---------------------------------------------------------------------------
  -- EDITING UTILITIES ------------------------------------------------------
  ---------------------------------------------------------------------------
  -- vim‑prettier formatter
  { "prettier/vim-prettier",
    build = "yarn install --frozen-lockfile --production",
    config = function()
      vim.g["prettier#autoformat"]               = 1
      vim.g["prettier#autoformat_require_pragma"] = 0
      vim.cmd [[
        autocmd BufWritePre
          \ *.gohtml,*.gotmpl,*.go.tmpl,*.tmpl,*.tpl,*.html.tmpl
          \ noautocmd call prettier#Autoformat()
      ]]
    end
  },

  -- Color‑string highlighter
  { "rrethy/vim-hexokinase", build = "make hexokinase" },

  -- Autoclose pairs / structures
  { "rstacruz/vim-closer" },
  { "tpope/vim-endwise" },

  -- Comment toggles
  { "tpope/vim-commentary" },

  -- Alignment operator
  { "junegunn/vim-easy-align", keys = { { "ga", mode = { "n", "x" } } } },

  -- UNIX helpers
  { "tpope/vim-eunuch" },

  -- Multiple cursors
  { "mg979/vim-visual-multi" },

  -- Ruby helpers
  { "jlcrochet/vim-ruby" },

  -- Sensible defaults & indent autodetection
  { "tpope/vim-sensible" },
  { "tpope/vim-sleuth" },

  -- Go development plugin (golines configured)
  { "fatih/vim-go",
    build = "go install github.com/segmentio/golines@latest",
    config = function()
      vim.g.go_fmt_command = "golines"
      vim.g.go_fmt_options = { golines = "-m 80 -t 2" }
    end
  },

  ---------------------------------------------------------------------------
  -- THEMES -----------------------------------------------------------------
  ---------------------------------------------------------------------------
  { "nordtheme/vim"         },
  { "rebelot/kanagawa.nvim" },
  { "sainnhe/everforest"    },
  { "utensils/colors.vim"   },
}
