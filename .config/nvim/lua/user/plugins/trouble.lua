return {
	"folke/trouble.nvim",
	enabled = false,
	opts = {
		modes = {
			symbols = {
				win = {
					type = "split",
					position = "right",
				},
				preview = {
					type = "float",
					position = "right",
				},
			},
		},
	},
	cmd = "Trouble",
	keys = {
		{
			"<leader>fs",
			"<cmd>Trouble symbols toggle focus=true<CR>",
			desc = "Find Symbols for current buffer (Trouble)",
		},
	},
}
