return {
	"echasnovski/mini.move",
	version = false,
	config = function()
		local minimove = require("mini.move")

		minimove.setup({
			-- Module mappings. Use `''` (empty string) to disable one.
			mappings = {
				-- Move visual selection in Visual mode
				left = "",
				right = "",
				down = "J",
				up = "K",

				-- Move current line in Normal mode
				line_left = "",
				line_right = "",
				line_down = "",
				line_up = "",
			},

			options = {
				-- Automatically reindent selection during linewise vertical move
				reindent_linewise = false,
			},
		})
	end,
}
