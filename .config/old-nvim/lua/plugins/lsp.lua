return {
	{
		"neovim/nvim-lspconfig",
		lazy = true,
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			{
				"antosha417/nvim-lsp-file-operations",
				config = true,
			},
		},
		config = function()
			local lspconfig = require("lspconfig")

			local cmp_nvim_lsp = require("cmp_nvim_lsp")

			local keymap = vim.keymap

			local opts = { noremap = true, silent = true }
			local on_attach = function(client, bufnr)
				opts.buffer = bufnr

				-- set keybinds
				opts.desc = "Show LSP references"
				keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

				opts.desc = "Go to declaration"

				keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

				opts.desc = "Show LSP definitions"
				keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

				opts.desc = "Show LSP implementations"
				keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

				opts.desc = "Show LSP type definitions"
				keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

				opts.desc = "See available code actions"
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

				opts.desc = "Show buffer diagnostics"
				keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

				opts.desc = "Show line diagnostics"
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

				opts.desc = "Go to previous diagnostic"
				keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

				opts.desc = "Go to next diagnostic"
				keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
			end

			local capabilities = cmp_nvim_lsp.default_capabilities()

			local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
			end

			lspconfig["html"].setup({
				capabilities = capabilities,
				on_attach = on_attach,
				filetypes = { "html", "htm" }, -- Solo activado para archivos HTML
			})

			lspconfig["ts_ls"].setup({
				capabilities = capabilities,
				on_attach = on_attach,
				filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" }, -- Solo para archivos TypeScript y JavaScript
			})

			lspconfig["emmet_ls"].setup({
				capabilities = capabilities,
				on_attach = on_attach,
				filetypes = { "javascript", "typescript", "typescriptreact", "javascriptreact" }, -- Solo para archivos con soporte de Emmet
			})

			lspconfig["astro"].setup({
				capabilities = capabilities,
				on_attach = on_attach,
				filetypes = { "astro" }, -- Solo activado para archivos Astro
				init_options = {
					typescript = {},
				},
			})

			lspconfig["tailwindcss"].setup({
				capabilities = capabilities,
				on_attach = on_attach,
				filetypes = { "html", "css", "javascript", "typescript", "jsx", "tsx" }, -- Solo para archivos relacionados con Tailwind
			})

			lspconfig["cssls"].setup({
				capabilities = capabilities,
				on_attach = on_attach,
				filetypes = { "css", "scss", "less" }, -- Solo activado para archivos CSS, SCSS y LESS
			})

			lspconfig["marksman"].setup({
				capabilities = capabilities,
				on_attach = on_attach,
				filetypes = { "markdown" }, -- Solo para archivos Markdown
			})

			lspconfig["lua_ls"].setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" }, -- Ignora la advertencia sobre 'vim'
						},
						completion = {
							callSnippet = "Replace", -- Configuración del comportamiento de los fragmentos de código
						},
					},
				},
				filetypes = { "lua" }, -- Solo activado para archivos Lua
			})
		end,
	},
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			local mason = require("mason")
			local mason_lspconfig = require("mason-lspconfig")

			mason.setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
			mason_lspconfig.setup({
				ensure_installed = {
					"ts_ls",
					"html",
					"cssls",
					"tailwindcss",
					"lua_ls",
					"graphql",
					"emmet_ls",
					"pyright",
					"astro",
					"marksman",
				},
				automatic_installation = true,
			})
		end,
	},
	{
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
				},
			})
			vim.keymap.set({ "n", "v" }, "<leader>mp", function()
				conform.format({
					lsp_fallback = true,
					async = false,
					timeout_ms = 500,
				})
			end, { desc = "Format file or range (in visual mode)" })
		end,
	},
	{
		"mfussenegger/nvim-lint",
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
				python = { "pylint" },
				markdown = { "markdownlint" },
			}
			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
			vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
				group = lint_augroup,
				callback = function()
					lint.try_lint()
				end,
			})
			vim.keymap.set("n", "<leader>l", function()
				lint.try_lint()
			end, { desc = "Trigger linting for current file" })
		end,
	},
}
