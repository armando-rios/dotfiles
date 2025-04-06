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
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
  {
    "Exafunction/codeium.vim",
  },
}
