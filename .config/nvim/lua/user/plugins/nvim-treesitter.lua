return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		dependencies = {
			"windwp/nvim-ts-autotag",
		},
		config = function()
			local treesitter = require("nvim-treesitter.configs")

			treesitter.setup({
				-- enable syntax highlighting
				highlight = { enable = true },
				indent = { enable = true },
				-- enable autotagging (w/ nvim-ts-autotag plugin)
				autotag = { enable = true },
				ensure_installed = {
					"astro",
					"bash",
					"css",
					"dockerfile",
					"gitignore",
					"html",
					"javascript",
					"json",
					"lua",
					"markdown",
					"markdown_inline",
					"prisma",
					"scss",
					"tsx",
					"typescript",
					"vim",
					"yaml",
					"python",
					"terraform",
				},

				-- the following ar required based on the types,
				-- but eh, I'm going to comment them out
				-- auto_install = true,
				-- sync_install = false,
				-- ignore_install = {},
				-- modules = {},

				incremental_selection = {
					enable = true,
					keymaps = {
						-- init_selection = "<leader>is",
						-- node_incremental = "<leader>is",
						-- scope_incremental = false,
						-- node_decremental = "<bs>",

						-- Trying out these keymaps to have this be easier to use
						init_selection = "<CR>",
						scope_incremental = "<CR>",
						node_incremental = "<TAB>",
						node_decremental = "<S-TAB>",
					},
				},
			})
		end,
	},
}
