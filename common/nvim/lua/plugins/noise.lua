return {
    {
        "rcarriga/nvim-notify",
        config = function()
            vim.notify = require("notify")
            require("notify").setup({
                max_width = 200,
                fps = 30,
                timeout = 1000,
                stages = "static",
                top_down = false,
            })
        end,
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            cmdline = {
                view = "cmdline"
            }
        },
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
    },
}
