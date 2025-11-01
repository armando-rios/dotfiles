return {
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
}
