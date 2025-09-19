return {
  'nvim-mini/mini.nvim',
  version = '*',
  config = function()
    require("mini.icons").setup({

    })
    require("mini.pairs").setup({
      modes = {
        insert = true,
        command = false,
        terminal = false
      },
    })
    require("mini.comment").setup({})
    require('mini.surround').setup({})
    -- require("mini.completion").setup({
    --   lsp_completion = {
    --     source = "nvim_lsp"
    --   }
    -- })
  end
}
