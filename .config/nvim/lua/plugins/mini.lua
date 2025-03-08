return {
  'echasnovski/mini.nvim',
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
  end
}
