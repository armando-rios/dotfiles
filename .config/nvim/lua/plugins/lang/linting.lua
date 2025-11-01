return {
  {
    "mfussenegger/nvim-lint",
    lazy = true,
    event = {
      "BufReadPre",
      "BufNewFile",
    },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        astro = { "eslint_d" },
        markdown = { "markdownlint" },
        python = { "pylint" },
      }
      vim.diagnostic.config({ virtual_text = true })
      local lint_autogroup = vim.api.nvim_create_augroup("LintGroup", { clear = true })
      vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
        group = lint_autogroup,
        callback = function()
          lint.try_lint()
        end,
      })
      vim.keymap.set("n", "<leader>l", function()
        lint.try_lint()
      end, { desc = "Trigger linting for current file" })

      vim.keymap.set("n", "<leader>le", function()
        vim.diagnostic.enable()
        vim.notify("Linter enabled", vim.log.levels.INFO)
      end, { desc = "Linter enabled" })

      vim.keymap.set("n", "<leader>ld", function()
        vim.diagnostic.disable()
        vim.notify("Linter enabled", vim.log.levels.INFO)
      end, { desc = "Linter disabled" })
    end,
  },
}
