return {
	"numToStr/Comment.nvim",
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local comment = require("Comment")
		local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

		comment.setup({
			-- for commenting tsx and jsx files
			-- https://github.com/JoosepAlviste/nvim-ts-context-commentstring/wiki/Integrations#commentnvim
			pre_hook = ts_context_commentstring.create_pre_hook(),
			toggler = {
				line = "<leader>/",
			},
			opleader = {
				line = "<leader>/",
			},
		})
	end,
}
