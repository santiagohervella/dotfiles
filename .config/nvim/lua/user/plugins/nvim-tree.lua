return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		{
			"<leader>e",
			function()
				local api = require("nvim-tree.api")
				if api.tree.is_visible() then
					api.tree.close()
				else
					api.tree.find_file({
						open = true,
						focus = true,
					})
				end
			end,
			desc = "Show nvim-tree",
		},
		{
			"<leader>E",
			function()
				local api = require("nvim-tree.api")
				api.tree.find_file({
					open = true,
					focus = true,
				})
			end,
			desc = "Show current file in nvim-tree",
		},
	},
	config = function()
		local nvim_tree = require("nvim-tree")

		nvim_tree.setup({
			update_focused_file = {
				enable = false,
				-- Still feeling this setting out
				-- enable = true,

				-- Always keep the root of the tree to the cwd
				-- So if, for example, I open up the help file for a plugin,
				-- the tree won't change to show the directory of the help file
				update_root = false,
			},

			actions = {
				open_file = {
					-- If there are splits, ask which split to open a file in rather than just opening in the more recent one
					window_picker = {
						enable = true,
					},
				},
			},
			view = {
				width = 50,
			},

			filters = {
				dotfiles = false,
				git_ignored = false,
			},
		})

		-- autocommand to make the all the nvim-tree backgrounds the same color as a regular file buffer
		vim.api.nvim_create_autocmd("BufEnter", {
			pattern = "NvimTree_*", -- NvimTree buffers typically start with this prefix
			callback = function()
				vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "NONE" })
				vim.api.nvim_set_hl(0, "NvimTreeEndOfBuffer", { bg = "NONE" })
				vim.api.nvim_set_hl(0, "NvimTreeVertSplit", { bg = "NONE" })
			end,
		})
	end,
}
