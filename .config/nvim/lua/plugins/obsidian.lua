return {
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = { "md", "markdown" },
    event = "BufReadPre",
    opts = {
      workspaces = {
        {
          name = "IRA",
          path = "~/Vault",
        },
      },
      completion = {
        nvim_cpm = true,
        min_char = 2,
      },
      notes_subdir = "Void",
      new_notes_location = "Void",
      attachments = {
        img_folder = "Files",
      },
      daily_notes = {
        folder = "Daily",
        date_format = "%Y-%m-%d",
        default_tags = { "daily-notes" },
        template = "Daily",
      },
      templates = {
        folder = "Templates",
      },
      ui = { enable = false },
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    -- dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
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
