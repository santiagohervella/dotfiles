return {
	"vim-test/vim-test",
	dependencies = {
		"preservim/vimux",
	},
	config = function()
		vim.keymap.set(
			"n",
			"<leader>tn",
			":TestNearest<CR>",
			{ desc = "In a test file runs the test nearest to the cursor" }
		)
		vim.keymap.set(
			"n",
			"<leader>tf",
			":TestFile<CR>",
			{ desc = "In a test file runs all tests in the current file" }
		)
		vim.cmd("let test#strategy = 'vimux'")
	end,
}
