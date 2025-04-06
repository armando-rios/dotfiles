return {
  {
    "github/copilot.vim",
    lazy = true,
    config = function()
      -- Desactivar Copilot por defecto al inicio
      vim.g.copilot_enabled = 0
    end,
  },
  {
    "olimorris/codecompanion.nvim",
    config = true,
  },
  {
    "Exafunction/codeium.vim",
  },
}
