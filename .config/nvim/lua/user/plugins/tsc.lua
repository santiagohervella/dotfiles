--[[
This Neovim plugin provides an asynchronous interface to run project-wide
TypeScript type-checking using the TypeScript compiler (tsc).
It displays the type-checking results in a quickfix list and provides
visual notifications about the progress and completion of type-checking.
--]]
return {
	"dmmulroy/tsc.nvim",
	enabled = true,
	event = "VeryLazy",
	config = function()
		require("tsc").setup({ enable_progress_notifications = true })
	end,
}
