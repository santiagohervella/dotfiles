return {
	"tamton-aquib/duck.nvim",
	enabled = false,
	config = function()
		vim.keymap.set("n", "<leader>dh", function()
			require("duck").hatch()
		end, { desc = "Hatch a duck" })
		vim.keymap.set("n", "<leader>dc", function()
			require("duck").cook_all()
		end, { desc = "Cook all ducks" })
	end,
}
