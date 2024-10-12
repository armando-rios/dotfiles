local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- keymap for write
keymap("n", "<leader>w", ":w<CR>", { noremap = true, silent = true, desc = "Write File" })

-- keymap for quit
keymap("n", "<leader>q", ":bd<CR>", { noremap = true, silent = true, desc = "Close Buffer" })

-- keymap for exit nvim
keymap("n", "<leader>Q", ":qa!<CR>", { noremap = true, silent = true, desc = "Exit Nvim"})

-- keymap select option
keymap("n", "<C-a>", "gg<S-v>G", { desc = "Select all"}) -- select all

-- keymap file explorer
-- keymap("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true, desc = "File Explorer"})
keymap("n", "<leader>e", "<CMD>Oil<CR>", { desc = "Open directory"})

-- telescope

local telescope = require('telescope.builtin')
keymap("n", "<leader>fg", telescope.live_grep, { noremap = true, silent = true, desc = "Live Grep"})
keymap("n", "<leader>ff", telescope.find_files, { noremap= true, silent = true, desc = "Find Files"})
keymap("n", "<leader>fn", ":Telescope notify<CR>", { noremap= true, silent = true, desc = "Find Notify"})
