return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  --@type snacks.Config
  opts = {
    terminal = {},
    lazygit = {},
    zen = {},
    picker = {},
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
    notify = { enabled = true },
    ---@class snacks.notifier.Config
    ---@field enabled? boolean
    ---@field keep? fun(notif: snacks.notifier.Notif): boolean # global keep function
    ---@field filter? fun(notif: snacks.notifier.Notif): boolean # filter our unwanted notifications (return false to hide)
    notifier = {
      timeout = 3000, -- default timeout in ms
      width = { min = 100, max = 0.3 },
      height = { min = 1, max = 0.6 },
      margin = { top = 0, right = 1, bottom = 0 },
      padding = true,              -- add 1 cell of left/right padding to the notification window
      sort = { "level", "added" }, -- sort by level and time
      level = vim.log.levels.TRACE,
      icons = {
        error = " ",
        warn = " ",
        info = " ",
        debug = " ",
        trace = " ",
      },
      keep = function(notif)
        return vim.fn.getcmdpos() > 0
      end,
      ---@type snacks.notifier.style
      style = "compact",
      top_down = false,   -- place notifications from top to bottom
      date_format = "%R", -- time format for notifications
      ---@type string|boolean
      more_format = " ↓ %d lines ",
      refresh = 50, -- refresh at most every 50ms
    },
    ---@class snacks.indent.Config
    ---@field enabled? boolean
    indent = {
      indent = {
        priority = 1,
        enabled = true, -- enable indent guides
        char = "│",
        only_scope = false,
        only_current = false,
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
    },
  },
  keys = {
    -- Top Pickers & Explorer
    { "<leader><space>", function() Snacks.picker.smart() end,                 desc = "Smart Find Files" },
    { "<leader>:",       function() Snacks.picker.command_history() end,       desc = "Command History" },
    { "<leader>gn",      function() Snacks.picker.notifications() end,         desc = "Notification History" },
    { "<leader>e",       function() Snacks.explorer() end,                     desc = "File Explorer" },
    -- find and grep
    { "<leader>fb",      function() Snacks.picker.buffers() end,               desc = "Buffers" },
    { "<leader>ff",      function() Snacks.picker.files() end,                 desc = "Find Files" },
    { "<leader>fp",      function() Snacks.picker.projects() end,              desc = "Projects" },
    { "<leader>fg",      function() Snacks.picker.grep() end,                  desc = "Grep" },
    { "<leader>fc",      function() Snacks.picker.colorschemes() end,          desc = "Colorschemes" },
    -- search
    { '<leader>s"',      function() Snacks.picker.registers() end,             desc = "Registers" },
    { "<leader>sd",      function() Snacks.picker.diagnostics() end,           desc = "Diagnostics" },
    { "<leader>sD",      function() Snacks.picker.diagnostics_buffer() end,    desc = "Buffer Diagnostics" },
    { "<leader>sh",      function() Snacks.picker.help() end,                  desc = "Help Pages" },
    { "<leader>sk",      function() Snacks.picker.keymaps() end,               desc = "Keymaps" },
    { "<leader>sm",      function() Snacks.picker.marks() end,                 desc = "Marks" },
    -- LSP
    { "gd",              function() Snacks.picker.lsp_definitions() end,       desc = "Goto Definition" },
    { "gD",              function() Snacks.picker.lsp_declarations() end,      desc = "Goto Declaration" },
    { "gr",              function() Snacks.picker.lsp_references() end,        nowait = true,                  desc = "References" },
    { "gI",              function() Snacks.picker.lsp_implementations() end,   desc = "Goto Implementation" },
    { "gy",              function() Snacks.picker.lsp_type_definitions() end,  desc = "Goto T[y]pe Definition" },
    { "<leader>ss",      function() Snacks.picker.lsp_symbols() end,           desc = "LSP Symbols" },
    { "<leader>sS",      function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
    -- Other
    { "<leader>z",       function() Snacks.zen.zoom() end,                     desc = "Toggle Zoom" },
    { "<leader>n",       function() Snacks.picker.notifications() end,         desc = "Notification History" },
    { "<leader>cR",      function() Snacks.rename.rename_file() end,           desc = "Rename File" },
    { "<leader>lg",      function() Snacks.lazygit() end,                      desc = "Lazygit" },
    { "<c-/>",           function() Snacks.terminal() end,                     desc = "Toggle Terminal" },
  },
}
