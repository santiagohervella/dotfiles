return {
	"leath-dub/snipe.nvim",
	enabled = false,
	keys = {
		{
			"<leader>fb",
			function()
				require("snipe").open_buffer_menu()
			end,
			desc = "Show open buffers in the Snipe menu",
		},
	},
	opts = {
		ui = {
			position = "center",
		},
	},
}
