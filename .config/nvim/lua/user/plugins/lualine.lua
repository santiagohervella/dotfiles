return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")

		local location = {
			"location",
			padding = 0,
		}

		lualine.setup({
			options = {
				icons_enabled = false,
				theme = "nightfly",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },

				-- TODO: Decide whether or not you like this setting
				globalstatus = true,
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch" },
				lualine_c = { "diff" },
				lualine_x = { "filetype" },
				lualine_y = { "progress" },
				lualine_z = { location },
			},
		})
	end,
}
