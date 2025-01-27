return {
	"folke/snacks.nvim",
	opts = {
		gitbrowse = { enabled = true },
	},
	keys = {
		{
			"<leader>gw",
			"<cmd> lua require('snacks').gitbrowse()<CR>",
			desc = "Open current file in the browser",
		},
	},
}
