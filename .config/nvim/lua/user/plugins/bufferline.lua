return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = { "BufReadPre", "BufNewFile" },
	version = "*",
	opts = {
		options = {
			show_buffer_close_icons = false,
			offsets = {
				{
					filetype = "NvimTree",
					text = "",
					highlight = "Directory",
					separator = true, -- use a "true" to enable the default, or set your own character
				},
			},
		},
	},
}
