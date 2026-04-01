return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				svelte = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				graphql = { "prettier" },
				liquid = { "prettier" },
				go = { "gofmt" },
				lua = { "stylua" },
				python = { "isort", "black" },
				hcl = { "terraform_fmt" },
				tf = { "terraform_fmt" },
				terraform = { "terraform_fmt" },
				["terraform-vars"] = { "terraform_fmt" },
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			},
			formatters = {
				prettier = {
					prepend_args = { "--single-quote" },
				},
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>lf", function()
			local ft = vim.bo.filetype

			-- Include removing unused imports in this keymap is something I saw in this config: https://github.com/smnatale/nvim
			if ft == "typescript" or ft == "typescriptreact" then
				vim.lsp.buf.code_action({
					apply = true,
					context = { only = { "source.removeUnused.ts" }, diagnostics = {} },
				})
				vim.defer_fn(function()
					conform.format({
						lsp_fallback = true,
						async = false,
						timeout_ms = 1000,
					})
				end, 100)
			else
				conform.format({
					lsp_fallback = true,
					async = false,
					timeout_ms = 1000,
				})
			end
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
