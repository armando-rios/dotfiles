return {
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    event = "BufReadPre",
    opts = {
      workspaces = {
        {
          name = "ira",
          path = "~/vault",
        },
      },
      completion = {
        nvim_cpm = true,
        min_char = 2,
      },
      notes_subdir = "void",
      new_notes_location = "void",
      attachments = {
        img_folder = "files",
      },
      daily_notes = {
        folder = "Daily",
        date_format = "%Y-%m-%d",
        default_tags = { "daily-notes" },
        template = "Daily",
      },
      templates = {
        folder = "templates",
      },
      ui = { enable = false },
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      heading = {
        width = "block",
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
        backgrounds = {},
      },
      code = {
        width = "block",
        position = "right",
        border = "thick",
        min_width = 45,
        left_pad = 2,
        lenguage_pad = 2,
      },
    },
  },
}
