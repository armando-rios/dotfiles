local map = vim.keymap.set

return {
  {
    "github/copilot.vim",
    map("n", "<leader>ce", function()
      vim.copilot_enable = true
      vim.notify("Copilot enabled")
    end, { desc = "Enable Copilot" }),
    map("n", "<leader>cd", function()
      vim.copilot_enable = false
      vim.notify("Copilot disabled")
    end, { desc = "Disable Copilot" }),

  },
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false,
    opts = {
      provider = "copilot",
      providers = {
        copilot = {
          model = "gpt-4o", -- "claude-3.7-sonnet", "claude-3.5-sonnet"
        },
      },
      cursor_applying_provider = "copilot",
      auto_suggestions_provider = "copilot",
      behaviour = {
        auto_suggestions = false, -- Experimental stage
        auto_set_highlight_group = true,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = false,
        support_paste_from_clipboard = false,
        enable_cursor_planning_mode = true, -- enable cursor planning mode!
        enable_token_counter = true,        -- enable token counter
      },
      selector = {
        provider = "snacks", -- Avoid native provider issues
        provider_opts = {},
      },
      hints = { enabled = false },
      windows = {
        ---@type "right" | "left" | "top" | "bottom" | "smart"
        position = "smart", -- the position of the sidebar
        wrap = true,        -- similar to vim.o.wrap
        width = 30,         -- default % based on available width
        sidebar_header = {
          enabled = true,   -- true, false to enable/disable the header
          align = "center", -- left, center, right for title
          rounded = false,
        },
        input = {
          prefix = "> ",
          height = 8, -- Height of the input window in vertical layout
        },
        edit = {
          start_insert = true, -- Start insert mode when opening the edit window
        },
        ask = {
          floating = false,        -- Open the 'AvanteAsk' prompt in a floating window
          start_insert = true,     -- Start insert mode when opening the ask window
          ---@type "ours" | "theirs"
          focus_on_apply = "ours", -- which diff to focus after applying
        },
      },
      highlights = {
        ---@type AvanteConflictHighlights
        diff = {
          current = "DiffText",
          incoming = "DiffAdd",
        },
      },
      --- @class AvanteConflictUserConfig
      diff = {
        autojump = true,
        ---@type string | fun(): any
        list_opener = "copen",
        override_timeoutlen = 500,
      },
    },
    build = "make",
    dependencies = {
      "stevearc/dressing.nvim",
    },
  },
}
