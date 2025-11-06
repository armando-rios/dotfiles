vim.o.updatetime = 300
vim.diagnostic.config({
  float = {
    border = "rounded",
    source = "always",
  },
  virtual_text = true,
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = " ",
      [vim.diagnostic.severity.HINT] = "󰠠 ",
    },
    linehl = {
      [vim.diagnostic.severity.ERROR] = "Error",
      [vim.diagnostic.severity.WARN] = "Warn",
      [vim.diagnostic.severity.INFO] = "Info",
      [vim.diagnostic.severity.HINT] = "Hint",
    },
  },
})
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, { focus = false })
  end,
})
vim.keymap.set("n", "<leader>le", function()
  vim.diagnostic.enable()
  vim.notify("Linter enabled", vim.log.levels.INFO)
end, { desc = "Linter enabled" })
vim.keymap.set("n", "<leader>ld", function()
  vim.diagnostic.disable()
  vim.notify("Linter disabled", vim.log.levels.INFO)
end, { desc = "Linter disabled" })
