return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local conform = require("conform")
        conform.setup({
            formatters_by_ft = {
                json = { "prettier" },
                javascript = { "prettier" },
                javascriptreact = { "prettier" },
                typescriptreact = { "prettier" },
                astro = { "prettier" },
                css = { "prettier" },
                html = { "prettier" },
                markdown = { "prettier" },
                lua = { "stylua" },
            },
            format_on_save = {
                lsp_fallback = true,
                async = false,
                timeout_ms = 500,
            }
        })
        vim.keymap.set({ "n", "v" }, "<leader>mp", function()
            conform.format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 500,
            })
        end, { desc = "Format file or range (in visual mode)" })
    end
}