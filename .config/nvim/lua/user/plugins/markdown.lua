-- Found out about this plugin here
-- https://github.com/Wansmer/nvim-config/blob/main/lua/config/plugins/md-renderer.lua
return {
	"MeanderingProgrammer/markdown.nvim",
	enabled = true,
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	ft = { "markdown" },
	event = "BufReadPre",
	keys = {
		{ "<leader>mt", "<cmd>RenderMarkdown toggle<CR>", desc = "Toggle rendering markdown" },
	},
	config = function()
		require("render-markdown").setup({
			file_types = { "markdown", "Avante" },
			anti_conceal = {
				enabled = true, -- show raw md on line under curson
			},
			heading = {
				sign = false,
			},
			code = {
				sign = false,
			},
		})
	end,
}
