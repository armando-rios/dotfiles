return  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
       require("toggleterm").setup {
        size = 20,
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        terminal_mappings = true,
        persist_size = true,
        direction = 'float',
        float_opts = {
          border = 'curved',
          width = 120,
          height = 30,
          winblend = 0,
        },
      }
    end,
 }

