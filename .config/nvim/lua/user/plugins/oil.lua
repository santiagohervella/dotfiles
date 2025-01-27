return {
	"stevearc/oil.nvim",
	opts = {
		default_file_explorer = false,
	},
	keys = {
		{ "<leader>fo", "<cmd>Oil<CR>", desc = "Open oil.nvim" },
	},
	dependencies = { "nvim-tree/nvim-web-devicons" },
}
