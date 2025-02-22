-- mason.lua
return {
	{
		"williamboman/mason.nvim",
		event = { "BufReadPre", "BufNewFile" },
		cmd = {
			"Mason",
			"MasonInstall",
			"MasonUninstall",
			"MasonUninstallAll",
			"MasonLog",
			"MasonUpdate",
		},
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
		},
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"cssls",
					"html",
					"lua_ls",
					"pyright",
					"tailwindcss",
					"terraformls",
					"ts_ls",
					"yamlls",
					"astro",
				},
				automatic_installation = true,
			})
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
		},
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					"prettier",
					"stylua",
					"isort",
					"black",
					"pylint",
					"eslint_d",
				},
				automatic_installation = true,
			})
		end,
	},
}

-- return {
-- 	-- in charge of managing lsp servers, linters & formatters
-- 	"williamboman/mason.nvim",
-- 	dependencies = {
-- 		"williamboman/mason-lspconfig.nvim", -- bridges gap between mason & lspconfig
-- 		"WhoIsSethDaniel/mason-tool-installer.nvim",
-- 		"neovim/nvim-lspconfig",
-- 	},
-- 	priority = 100, -- Add this to ensure it loads early
-- 	event = { "BufReadPre", "BufNewFile" }, -- Match the lspconfig event
-- 	cmd = {
-- 		"Mason",
-- 		"MasonInstall",
-- 		"MasonUninstall",
-- 		"MasonUninstallAll",
-- 		"MasonLog",
-- 		"MasonUpdate",
-- 	},
-- 	config = function()
-- 		local mason = require("mason")
-- 		local mason_lspconfig = require("mason-lspconfig")
-- 		local mason_tool_installer = require("mason-tool-installer")
--
-- 		-- enable mason and configure icons
-- 		mason.setup({
-- 			ui = {
-- 				icons = {
-- 					package_installed = "✓",
-- 					package_pending = "➜",
-- 					package_uninstalled = "✗",
-- 				},
-- 			},
-- 		})
--
-- 		mason_lspconfig.setup({
-- 			-- list of servers for mason to install
-- 			ensure_installed = {
-- 				"cssls",
-- 				"html",
-- 				"lua_ls",
-- 				"pyright",
-- 				"tailwindcss",
-- 				"terraformls",
-- 				-- "tsserver", -- this is deprecated, use ts_ls instead
-- 				"ts_ls",
-- 				"yamlls",
-- 				"astro",
-- 			},
-- 			automatic_installation = true,
-- 		})
--
-- 		mason_tool_installer.setup({
-- 			ensure_installed = {
-- 				"prettier", -- prettier formatter
-- 				"stylua", -- lua formatter
-- 				"isort", -- python formatter
-- 				"black", -- python formatter
-- 				"pylint",
-- 				"eslint_d",
-- 			},
-- 			automatic_installation = true,
-- 		})
-- 	end,
-- }
