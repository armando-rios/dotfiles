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

      local lspconfig = require("lspconfig")

      local function setup_lsp_servers(servers)
        for server, config in pairs(servers) do
          local opts = vim.tbl_deep_extend("force", {
            capabilities = capabilities,
          }, config)

          lspconfig[server].setup(opts)
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
          filetypes = { "html", "css", "javascript", "typescript", "javascriptreact", "typescriptreact", "astro" },
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
}
