return {
    {
        "nvim-tree/nvim-tree.lua",
        proiority = 1000,
        config = function()
            require("nvim-tree").setup({
                sort = {
                    sorter = "case_sensitive",
                },
                view = {
                    width = 30,
                    side = "right",
                },
                renderer = {
                    group_empty = true,
                },
                filters = {
                    dotfiles = true,
                },
                actions = {
                    open_file = {
                        quit_on_open = true,
                    },
                },
            })
        end,
    },
    {
        'stevearc/oil.nvim',
        opts = {
            view_options = {
                show_hidden = true
            }
        }
    }
}
