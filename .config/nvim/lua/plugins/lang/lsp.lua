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

      local servers = {
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
          filetypes = { "lua" },
          settings = {
            Lua = {
              workspace = {
                library = {
                  "${3rd}/love2d/library"
                }
              },
              diagnostics = {
                globals = { "vim" },
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        }
      }

      local server_names = {}
      for server, config in pairs(servers) do
        local opts = vim.tbl_deep_extend("force", {
          capabilities = capabilities,
        }, config)

        vim.lsp.config(server, opts)
        table.insert(server_names, server)
      end

      vim.lsp.enable(server_names)

      -- vim.api.nvim_create_autocmd("LspAttach", {
      --   group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
      --   callback = function(ev)
      --     local opts = { buffer = ev.buf, silent = true }
      --
      --     -- Ejemplos de keymaps comunes (descomenta los que necesites):
      --     -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      --     -- vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      --     -- vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
      --     -- vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      --     -- vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      --   end,
      -- })
    end,
  },
}
