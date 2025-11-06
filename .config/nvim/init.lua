vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none", "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    { import = "plugins" },
    { import = "plugins.lang" },
    { import = "plugins.editor" },
    { import = "plugins.ui" },
    { import = "plugins.ai" }
  },
  install = { colorscheme = { "cattpuccin" } },
  checker = { enabled = false },
})

-- Load basic configs
require("config.options")
require("config.keymaps")
require("config.diagnostics")
