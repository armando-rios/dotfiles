local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", "<leader>w", "<cmd>w<cr>", opts)
map("n", "<leader>q", "<cmd>bd<cr>", opts)
map("n", "<leader>Q", "<cmd>qa!<cr>", opts)
-- File explorer
map("n", "<leader>e", "<cmd>Oil<cr>", opts)
map("n", "<leader>E", "<cmd>Neotree toggle<cr>", opts)

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

map("v", "J", ":m '>+1<CR>gv=gv", opts)
map("v", "K", ":m '<-2<CR>gv=gv", opts)
map("x", "<leader>p", '"_dP', opts)
