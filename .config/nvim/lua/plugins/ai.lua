local map = vim.keymap.set

return {
  {
    'Exafunction/windsurf.vim',
  },
  {
    'github/copilot.vim',
    -- functions to enable/disable copilot
    config = function()
      map("n", "<leader>ce", function()
        vim.g.copilot_enabled = true
        vim.notify("Copilot enabled")
      end, { desc = "Enable Copilot"})
      map("n", "<leader>cd", function()
        vim.g.copilot_enabled = false
        vim.notify("Copilot disabled")
      end, { desc = "Disable Copilot"})
    end
  }
}
