return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    terminal = {},
    lazygit = {},
    picker = {},
    zen = {},
    dashboard = {
      preset = {
        header = [[
   █████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
  ██╔══██╗██╔══██╗██║   ██║██║████╗ ████║
  ███████║██████╔╝██║   ██║██║██╔████╔██║
  ██╔══██║██╔══██╗╚██╗ ██╔╝██║██║╚██╔╝██║
  ██║  ██║██║  ██║ ╚████╔╝ ██║██║ ╚═╝ ██║
  ╚═╝  ╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
        ]]
      }
    },
    ---@class snacks.indent.Config
    ---@field enabled? boolean
    indent = {
      indent = {
        priority = 1,
        enabled = true,       -- enable indent guides
        char = "│",
        only_scope = false,   -- only show indent guides of the scope
        only_current = false, -- only show indent guides in the current window
        -- hl = "SnacksIndent", ---@type string|string[] hl groups for indent guides
        -- can be a list of hl groups to cycle through
        hl = {
          "SnacksIndent1",
          "SnacksIndent2",
          "SnacksIndent3",
          "SnacksIndent4",
          "SnacksIndent5",
          "SnacksIndent6",
          "SnacksIndent7",
          "SnacksIndent8",
        },
      },
      ---@class snacks.indent.animate: snacks.animate.Config
      ---@field enabled? boolean
      ---@field style? "out"|"up_down"|"down"|"up"
      animate = {
        enabled = vim.fn.has("nvim-0.10") == 1,
        style = "out",
        easing = "linear",
        duration = {
          step = 20,   -- ms per step
          total = 500, -- maximum duration
        },
      },
      ---@class snacks.indent.Scope.Config: snacks.scope.Config
      scope = {
        enabled = true, -- enable highlighting the current scope
        priority = 200,
        char = "│",
        underline = false,    -- underline the start of the scope
        only_current = false, -- only show scope in the current window
        hl = "SnacksIndentScope", ---@type string|string[] hl group for scopes
      },
      chunk = {
        enabled = false,
        only_current = false,
        priority = 200,
        hl = "SnacksIndentChunk", ---@type string|string[] hl group for chunk scopes
        char = {
          corner_top = "┌",
          corner_bottom = "└",
          -- corner_top = "╭",
          -- corner_bottom = "╰",
          horizontal = "─",
          vertical = "│",
          arrow = ">",
        },
      },
      -- filter for buffers to enable indent guides
      filter = function(buf)
        return vim.g.snacks_indent ~= false and vim.b[buf].snacks_indent ~= false and vim.bo[buf].buftype == ""
      end,
    }
  },
  keys = {
    -- lazygit
    { "<leader>lg", function() Snacks.lazygit() end,                      desc = "Lazygit" },
    -- terminal
    { "<leader>t",  function() Snacks.terminal() end,                     desc = "Toggle Terminal" },
    -- picker
    { "<leader>fb", function() Snacks.picker.buffers() end,               desc = "Buffers" },
    { "<leader>ff", function() Snacks.picker.files() end,                 desc = "Find Files" },
    { "<leader>fg", function() Snacks.picker.grep() end,                  desc = "Grep" },
    { "<leader>fp", function() Snacks.picker.projects() end,              desc = "Projects" },

    { '<leader>s"', function() Snacks.picker.registers() end,             desc = "Registers" },
    { '<leader>s/', function() Snacks.picker.search_history() end,        desc = "Search History" },
    { "<leader>sd", function() Snacks.picker.diagnostics() end,           desc = "Diagnostics" },
    { "<leader>sm", function() Snacks.picker.marks() end,                 desc = "Marks" },
    { "<leader>sp", function() Snacks.picker.lazy() end,                  desc = "Search for Plugin Spec" },
    { "<leader>uC", function() Snacks.picker.colorschemes() end,          desc = "Colorschemes" },
    -- LSP
    { "gd",         function() Snacks.picker.lsp_definitions() end,       desc = "Goto Definition" },
    { "gD",         function() Snacks.picker.lsp_declarations() end,      desc = "Goto Declaration" },
    { "gr",         function() Snacks.picker.lsp_references() end,        nowait = true,                  desc = "References" },
    { "gI",         function() Snacks.picker.lsp_implementations() end,   desc = "Goto Implementation" },
    { "gy",         function() Snacks.picker.lsp_type_definitions() end,  desc = "Goto T[y]pe Definition" },
    { "<leader>ss", function() Snacks.picker.lsp_symbols() end,           desc = "LSP Symbols" },
    { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
    { "<leader>z",  function() Snacks.zen() end,                          desc = "Toggle Zen Mode" },
  }
}
