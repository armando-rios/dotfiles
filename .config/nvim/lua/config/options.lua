local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.wrap = true
opt.ignorecase = true
opt.smartcase = true
opt.cursorline = true
opt.termguicolors = true
opt.signcolumn = "yes"
opt.fillchars = { eob = " " }
opt.clipboard:append("unnamedplus")
opt.backupcopy = 'yes'
