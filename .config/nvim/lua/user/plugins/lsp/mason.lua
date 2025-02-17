return {
	-- in charge of managing lsp servers, linters & formatters
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim", -- bridges gap between mason & lspconfig
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	cmd = {
		"Mason",
		"MasonInstall",
		"MasonUninstall",
		"MasonUninstallAll",
		"MasonLog",
		"MasonUpdate",
	},
	event = "VeryLazy", -- This ensures Mason runs its setup during startup, but after other urgent plugins
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

		-- enable mason and configure icons
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
			-- list of servers for mason to install
			ensure_installed = {
				"cssls",
				"html",
				"lua_ls",
				"pyright",
				"tailwindcss",
				"terraformls",
				-- "tsserver", -- this is deprecated, use ts_ls instead
				-- "ts_ls", -- Trying out ./typescript-tools.lua tools instead of this
				"yamlls",
				"astro",
			},
			automatic_installation = true,
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"prettier", -- prettier formatter
				"stylua", -- lua formatter
				"isort", -- python formatter
				"black", -- python formatter
				"pylint",
				"eslint_d",
			},
			automatic_installation = true,
		})
	end,
}
