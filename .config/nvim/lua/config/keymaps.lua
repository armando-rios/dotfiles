local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", "<leader>w", "<cmd>w<cr>", opts)
map("n", "<leader>q", "<cmd>bd<cr>", opts)
map("n", "<leader>Q", "<cmd>qa!<cr>", opts)
-- File explorer
map("n", "<leader>e", "<cmd>Oil<cr>", opts)
map("n", "<leader>E", "<cmd>Neotree toggle<cr>", opts)

-- Telescope
local telescope = require('telescope.builtin')
map("n", "<leader>fg", telescope.live_grep, opts)
map("n", "<leader>ff", telescope.find_files, opts)
map("n", "<leader>fb", telescope.buffers, opts)
map("n", "<leader>fn", ":Telescope notify<cr>", opts)
map("n", "<leader>fc", telescope.colorscheme, opts)

-- Obsidian

map({ 'n', 'v' }, '<leader>ob', '<cmd>ObsidianOpen<cr>', opts)
map({ 'n', 'v' }, '<leader>of', '<cmd>ObsidianFollowLink<cr>', opts)
map({ 'n', 'v' }, '<leader>on', '<cmd>ObsidianNew<cr>', opts)
map({ 'n', 'v' }, '<leader>ont', '<cmd>ObsidianNewFromTemplate<cr>', opts)
map({ 'n', 'v' }, '<leader>od', '<cmd>ObsidianToday<cr>', opts)
map({ 'n', 'v' }, '<leader>oy', '<cmd>ObsidianYesterday<cr>', opts)
map({ 'n', 'v' }, '<leader>ot', '<cmd>ObsidianTomorrow<cr>', opts)
map({ 'n', 'v' }, '<leader>op', '<cmd>ObsidianPreview<cr>', opts)
map({ 'n', 'v' }, '<leader>oln', '<cmd>ObsidianLinkNew<cr>', opts)
map({ 'n', 'v' }, '<leader>ol', '<cmd>ObsidianLink<cr>', opts)
map({ 'n', 'v' }, '<leader>oi', '<cmd>ObsidianPasteImg<cr>', opts)

-- REST
map({ 'n', 'v' }, '<leader>rr', ':Rest run<cr>', opts)

-- which key

local wk = require("which-key")
wk.add({
  { "<leader>q",  desc = "Close Buffer" },
  { "<leader>Q",  desc = "Exit and close all" },
  { "<leader>e",  desc = "File Explorer" },
  { "<leader>w",  desc = "Write File" },
  { "<leader>f",  desc = "Find Files" },
  { "<leader>g",  desc = "Live Grep" },
  { "<leader>b",  desc = "Find Buffers" },
  { "<leader>fc", desc = "Change Colorscheme" },
  { "<leader>rr", desc = "Rest run (API)" },
})
