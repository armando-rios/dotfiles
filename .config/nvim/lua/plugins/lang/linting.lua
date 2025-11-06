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

      local function has_eslint_config()
        local root_dir = vim.fn.getcwd()
        local eslint_configs = {
          ".eslintrc",
          ".eslintrc.js",
          ".eslintrc.cjs",
          ".eslintrc.yaml",
          ".eslintrc.yml",
          ".eslintrc.json",
          "eslint.config.js",
          "eslint.config.cjs",
          "eslint.config.mjs",
        }

        for _, config in ipairs(eslint_configs) do
          if vim.fn.filereadable(root_dir .. "/" .. config) == 1 then
            return true
          end
        end

        local package_json = root_dir .. "/package.json"
        if vim.fn.filereadable(package_json) == 1 then
          local ok, content = pcall(vim.fn.readfile, package_json)
          if ok then
            local json_str = table.concat(content, "\n")
            if json_str:match('"eslintConfig"') then
              return true
            end
          end
        end

        return false
      end

      local lint_autogroup = vim.api.nvim_create_augroup("LintGroup", { clear = true })
      vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
        group = lint_autogroup,
        callback = function()
          local ft = vim.bo.filetype
          local eslint_filetypes = {
            "javascript",
            "typescript",
            "javascriptreact",
            "typescriptreact",
            "astro"
          }
          local is_eslint_filetype = vim.tbl_contains(eslint_filetypes, ft)
          if is_eslint_filetype and has_eslint_config() then
            lint.try_lint()
          elseif not is_eslint_filetype then
            lint.try_lint()
          end
        end,
      })
      vim.keymap.set("n", "<leader>l", function()
        lint.try_lint()
      end, { desc = "Trigger linting for current file" })
    end,
  },
}
