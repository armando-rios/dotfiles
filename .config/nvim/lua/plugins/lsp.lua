return {
  {
    "neovim/nvim-lspconfig",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      {
        "hrsh7th/cmp-nvim-lsp",
        lazy = true,
      },
      {
        "nvim-lua/plenary.nvim",
        lazy = true,
      },
      {
        "antosha417/nvim-lsp-file-operations",
        lazy = true,
        config = true,
      }
    },
    config = function()
      local cmp_nvim_lsp = require("cmp_nvim_lsp")

      local capabilities = cmp_nvim_lsp.default_capabilities()

      local function setup_lsp_servers(servers)
        for server, config in pairs(servers) do
          local opts = vim.tbl_deep_extend("force", {
            capabilities = capabilities,
          }, config)

          vim.lsp.config(server, opts)
        end
      end

      vim.diagnostic.config({
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.INFO] = " ",
            [vim.diagnostic.severity.HINT] = "󰠠 ",
          },
          linehl = {
            [vim.diagnostic.severity.ERROR] = "Error",
            [vim.diagnostic.severity.WARN] = "Warn",
            [vim.diagnostic.severity.INFO] = "Info",
            [vim.diagnostic.severity.HINT] = "Hint",
          },
        },
      })

      setup_lsp_servers({
        vtsls = {
          filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
        },
        astro = {
          filetypes = { "astro" },
        },
        html = {
          filetypes = { "html", "htm" },
        },
        cssls = {
          filetypes = { "css", "scss", "less" },
        },
        tailwindcss = {
          filetypes = { "css", "scss", "less" },
        },
        marksman = {
          filetypes = { "markdown" },
        },
        lua_ls = {
          settings = {
            Lua = {
              workspace = {
                library = {
                  "${3rd}/love2d/library"
                }
              },
              diagnostics = {
                globals = { "vim" }, -- Ignora la advertencia sobre 'vim'
              },
              completion = {
                callSnippet = "Replace", -- Configuración del comportamiento de los fragmentos de código
              },
            },
          },
          filetypes = { "lua" }, -- Solo activado para archivos Lua
        }
      })
    end,
  },
  {
    "mason-org/mason.nvim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason-org/mason-lspconfig.nvim",
      lazy = true,
    },
    config = function()
      local mason = require("mason")
      local mason_lspconfig = require("mason-lspconfig")

      mason.setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
      mason_lspconfig.setup({
        ensure_installed = {
          "vtsls",
          "html",
          "cssls",
          "tailwindcss",
          "lua_ls",
          "graphql",
          "astro",
          "marksman",
        },
        automatic_installation = true,
      })
    end,
  },
  {
    "stevearc/conform.nvim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local conform = require("conform")
      conform.setup({
        formatters_by_ft = {
          json = { "prettier" },
          javascript = { "prettier" },
          typescript = { "prettier" },
          javascriptreact = { "prettier" },
          typescriptreact = { "prettier" },
          astro = { "prettier" },
          css = { "prettier" },
          html = { "prettier" },
          markdown = { "prettier" },
          lua = { "stylua" },
          python = { "black" },
        },
        format_on_save = {
          lsp_fallback = true,
          async = false,
          timeout_ms = 500,
        },
      })
      vim.keymap.set({ "n", "v" }, "<leader>mp", function()
        conform.format({
          lsp_fallback = true,
          async = false,
          timeout_ms = 500,
        })
      end, { desc = "Format file or range (in visual mode)" })
    end,
  },
  {
    "mfussenegger/nvim-lint",
    lazy = true,
    event = {
      "BufReadPre",
      "BufNewFile",
    },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        astro = { "eslint_d" },
        markdown = { "markdownlint" },
        python = { "pylint" },
      }
      vim.diagnostic.config({ virtual_text = true })
      local lint_autogroup = vim.api.nvim_create_augroup("LintGroup", { clear = true })
      vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
        group = lint_autogroup,
        callback = function()
          lint.try_lint()
        end,
      })
      vim.keymap.set("n", "<leader>l", function()
        lint.try_lint()
      end, { desc = "Trigger linting for current file" })

      vim.keymap.set("n", "<leader>le", function()
        vim.diagnostic.enable()
        vim.notify("Linter enabled", vim.log.levels.INFO)
      end, { desc = "Linter enabled" })

      vim.keymap.set("n", "<leader>ld", function()
        vim.diagnostic.disable()
        vim.notify("Linter enabled", vim.log.levels.INFO)
      end, { desc = "Linter disabled" })
    end,
  },
}
