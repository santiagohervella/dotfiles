--[[
For all open/close pairs, e.g. `()`, adding a surround
using the closing character will surround the selection with just the pair
itself, whereas using the opening character will add a whitespace gap between
the selection and delimiter pair.
--]]
return {
	"kylechui/nvim-surround",
	event = { "BufReadPre", "BufNewFile" },
	version = "*", -- Use for stability; omit to use `main` branch for the latest features
	config = true,
}
