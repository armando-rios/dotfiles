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
      local lspconfig = require("lspconfig")

      local cmp_nvim_lsp = require("cmp_nvim_lsp")

      local capabilities = cmp_nvim_lsp.default_capabilities()

      local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      lspconfig["html"].setup({
        capabilities = capabilities,
        filetypes = { "html", "htm" }, -- Solo activado para archivos HTML
      })

      lspconfig["ts_ls"].setup({
        capabilities = capabilities,
        filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" }, -- Solo para archivos TypeScript y JavaScript
      })

      lspconfig["astro"].setup({
        capabilities = capabilities,
        filetypes = { "astro" }, -- Solo activado para archivos Astro
        init_options = {
          typescript = {},
        },
      })

      lspconfig["tailwindcss"].setup({
        capabilities = capabilities,
        filetypes = { "html", "css", "javascript", "typescript", "javascriptreact", "typescriptreact" }, -- Solo para archivos relacionados con Tailwind
      })

      lspconfig["cssls"].setup({
        capabilities = capabilities,
        filetypes = { "css", "scss", "less" }, -- Solo activado para archivos CSS, SCSS y LESS
      })

      lspconfig["marksman"].setup({
        capabilities = capabilities,
        filetypes = { "markdown" }, -- Solo para archivos Markdown
      })

      lspconfig["lua_ls"].setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" }, -- Ignora la advertencia sobre 'vim'
            },
            completion = {
              callSnippet = "Replace", -- Configuración del comportamiento de los fragmentos de código
            },
          },
        },
        filetypes = { "lua" }, -- Solo activado para archivos Lua
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
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
          "ts_ls",
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
      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })
      vim.keymap.set("n", "<leader>l", function()
        lint.try_lint()
      end, { desc = "Trigger linting for current file" })
    end,
  },
}
