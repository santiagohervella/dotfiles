return {
	"ThePrimeagen/harpoon",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	enabled = false,
	config = function()
		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set(
			"n",
			"<leader>a",
			"<cmd>lua require('harpoon.mark').add_file()<cr>",
			{ desc = "Mark file with harpoon" }
		)
		keymap.set(
			"n",
			"<leader>fm",
			"<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>",
			{ desc = "Show harpoon marks" }
		)
		keymap.set(
			"n",
			"<leader>h",
			"<cmd>lua require('harpoon.ui').nav_file(1)<cr>",
			{ desc = "Go to harpoon mark 1" }
		)
		keymap.set(
			"n",
			"<leader>t",
			"<cmd>lua require('harpoon.ui').nav_file(2)<cr>",
			{ desc = "Go to harpoon mark 2" }
		)
		keymap.set(
			"n",
			"<leader>n",
			"<cmd>lua require('harpoon.ui').nav_file(3)<cr>",
			{ desc = "Go to harpoon mark 3" }
		)
		keymap.set(
			"n",
			"<leader>s",
			"<cmd>lua require('harpoon.ui').nav_file(4)<cr>",
			{ desc = "Go to harpoon mark 4" }
		)
	end,
}
