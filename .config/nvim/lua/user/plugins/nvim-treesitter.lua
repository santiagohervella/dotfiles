return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		dependencies = {
			"windwp/nvim-ts-autotag",
		},
		config = function()
			local parsers = {
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
			}

			require("nvim-treesitter").install(parsers)

			vim.api.nvim_create_autocmd("FileType", {
				callback = function(ev)
					local lang = vim.treesitter.language.get_lang(vim.bo[ev.buf].filetype)
					if lang and vim.treesitter.language.add(lang) then
						vim.treesitter.start(ev.buf, lang)
						vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})

			require("nvim-ts-autotag").setup()
		end,
	},
}
