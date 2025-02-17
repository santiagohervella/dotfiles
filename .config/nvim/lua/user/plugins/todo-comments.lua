return {
	"folke/todo-comments.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		signs = false,
		gui_style = {
			-- The gui style to use for the fg highlight group.
			-- fg is the text, not the highlight, so bold here
			-- Makes the font a big heavier
			fg = "BOLD",
		},
		-- This determines whether the highlight should be changing the font color or highlighting the text
		-- Before is from the start of the line to the keyword
		-- Keyword is the keyword (e.g. TODO, NOTE, FIX, etc)
		-- After is the rest of the line
		-- By default, keyword is set to "wide", which is the same as bg
		-- but with one character of additional highlighting on either side of the keyword
		highlight = {
			before = "fg",
			keyword = "fg",
			after = "fg",
		},
	},
}
