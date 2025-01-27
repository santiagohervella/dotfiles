return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = true,
	keys = {
		{ "<leader>gp", "<cmd>:Gitsigns preview_hunk<CR>", desc = "Toggle git hunk preview" },
		{ "<leader>rh", "<cmd>:Gitsigns reset_hunk<CR>", desc = "Reset hunk under the cursor" },
		{
			"<leader>gbl",
			"<cmd>lua require('gitsigns').blame_line({ full = true })<CR>",
			desc = "Git blame line and show the change in a popup",
		},
	},
}
