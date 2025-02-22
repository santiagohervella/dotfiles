return {
	"declancm/cinnamon.nvim",
	enabled = false,
	event = {
		"BufReadPost",
		"BufNewFile",
	},
	opts = {
		keymaps = {
			basic = true,
			extra = false,
		},
		options = {
			delay = 5,
		},
	},
}
