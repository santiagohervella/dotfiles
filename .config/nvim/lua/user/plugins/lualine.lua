return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")

		local location = {
			"location",
			padding = 0,
		}

		local original_config = {
			options = {
				icons_enabled = false,
				theme = "nightfly",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
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
		}

		local recording_colors = {
			a = { fg = "#ffffff", bg = "#ff0000", gui = "bold" },
			b = { fg = "#ffffff", bg = "#cc0000" },
			c = { fg = "#ffffff", bg = "#990000" },
		}

		local recording_config = vim.deepcopy(original_config)
		recording_config.options.theme = {
			normal = recording_colors,
			insert = recording_colors,
			visual = recording_colors,
			replace = recording_colors,
			command = recording_colors,
			inactive = recording_colors,
		}

		lualine.setup(original_config)

		-- Set up autocmds to automatically switch themes based on macro recording status
		local recording_group = vim.api.nvim_create_augroup("LualineRecording", { clear = true })

		vim.api.nvim_create_autocmd("RecordingEnter", {
			group = recording_group,
			callback = function()
				lualine.setup(recording_config)
			end,
		})

		vim.api.nvim_create_autocmd("RecordingLeave", {
			group = recording_group,
			callback = function()
				lualine.setup(original_config)
			end,
		})
	end,
}
