return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/lazydev.nvim", opts = {} },
	},
	config = function()
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local keymap = vim.keymap -- for conciseness

		-------------------------------------------------------
		-------------------------------------------------------
		local function flash_cursor_line_green()
			local current_win = vim.api.nvim_get_current_win()
			local current_buf = vim.api.nvim_get_current_buf()
			local cursor_pos = vim.api.nvim_win_get_cursor(current_win)
			local line = cursor_pos[1] - 1 -- Convert to 0-indexed

			-- Create a temporary highlight group
			vim.api.nvim_set_hl(0, "TempGreenLine", { bg = "#004400" })

			-- Add virtual text that spans the entire line
			local line_content = vim.api.nvim_buf_get_lines(current_buf, line, line + 1, false)[1] or ""
			local line_length = #line_content

			-- Create virtual text to highlight the line
			local ns_id = vim.api.nvim_create_namespace("cursor_flash")
			vim.api.nvim_buf_set_extmark(current_buf, ns_id, line, 0, {
				virt_text_pos = "overlay",
				hl_group = "TempGreenLine",
				end_col = line_length > 0 and line_length or 1,
				hl_eol = true,
			})

			-- Clear after delay
			vim.defer_fn(function()
				vim.api.nvim_buf_clear_namespace(current_buf, ns_id, 0, -1)
			end, 250)
		end
		-- Custom diagnostics function
		local function show_diagnostics_or_flash()
			local diagnostics = vim.diagnostic.get(0) -- Get diagnostics for current buffer (bufnr=0)

			if #diagnostics == 0 then
				-- No diagnostics found, flash cursor line green
				flash_cursor_line_green()
			else
				-- Diagnostics exist, show them with Telescope
				require("telescope.builtin").diagnostics({ bufnr = 0 })
			end
		end
		-------------------------------------------------------
		-------------------------------------------------------

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local opts = { buffer = ev.buf, silent = true }

				-- set keybinds
				opts.desc = "Show LSP references"
				keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)

				opts.desc = "Show LSP definitions"
				keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

				opts.desc = "Go to definition in vertical split"
				keymap.set("n", "gD", ":vsplit | lua vim.lsp.buf.definition()<CR>", opts)

				opts.desc = "Show LSP implementations"
				keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

				-- NOTE: I never use this one because it feels like lsp_definitions can do the same thing
				opts.desc = "Show LSP type definitions"
				keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

				opts.desc = "See available code actions"
				keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, opts)

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts)

				opts.desc = "Show buffer diagnostics"
				keymap.set("n", "<leader>ld", show_diagnostics_or_flash, opts)

				opts.desc = "Show workspace diagnostics"
				keymap.set("n", "<leader>lD", "<cmd>Telescope diagnostics<CR>", opts)

				opts.desc = "Show line diagnostics"
				keymap.set("n", "gl", vim.diagnostic.open_float, opts)

				opts.desc = "Go to previous diagnostic"
				keymap.set("n", "<leader>dk", function() vim.diagnostic.jump({ count = -1, float = true }) end, opts)

				opts.desc = "Go to next diagnostic"
				keymap.set("n", "<leader>dj", function() vim.diagnostic.jump({ count = 1, float = true }) end, opts)

				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "K", vim.lsp.buf.hover, opts)

				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
			end,
		})

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.HINT] = "󰠠 ",
					[vim.diagnostic.severity.INFO] = " ",
				},
			},
		})

		vim.lsp.config("*", {
			capabilities = capabilities,
		})

		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					-- make the language server recognize "vim" global
					diagnostics = {
						globals = { "vim" },
					},
					completion = {
						callSnippet = "Replace",
					},
				},
			},
		})

		-- Found out that pyright has missing stub type setting in this config
		-- https://github.com/mrjones2014/dotfiles/blob/master/nvim/lua/my/lsp/python.lua
		vim.lsp.config("pyright", {
			settings = {
				pyright = {
					autoImportCompletion = true,
				},
				python = {
					analysis = {
						reportMissingTypeStubs = false,
						useLibraryCodeForTypes = true,
						autoSearchPaths = true,
					},
				},
			},
			before_init = function(_, config)
				if config.root_dir and vim.fn.filereadable(config.root_dir .. "/pyproject.toml") == 1 then
					local poetry_env =
						vim.fn.trim(vim.fn.system("cd " .. config.root_dir .. " && poetry env info -p 2>/dev/null"))
					if poetry_env ~= "" then
						config.settings.python.pythonPath = poetry_env .. "/bin/python"
					end
				end
			end,
		})

		-- sourcekit is part of the Swift toolchain and so Mason doesn't offer it standalone
		-- https://www.swift.org/documentation/articles/zero-to-swift-nvim.html#language-server-support
		vim.lsp.config("sourcekit", {
			capabilities = {
				workspace = {
					didChangeWatchedFiles = {
						dynamicRegistration = true,
					},
				},
			},
		})
		vim.lsp.enable("sourcekit")
	end,
}
