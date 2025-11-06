return {
  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts

    opts = {
      view_options = {
        show_hidden = true,
      },
    },

    dependencies = { { "nvim-mini/mini.nvim", opts = {} } },
    lazy = false,
  },
}
