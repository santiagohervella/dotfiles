return {
	"vim-test/vim-test",
	dependencies = {
		"preservim/vimux",
	},
	keys = {
		{
			"<leader>tn",
			"<cmd>TestNearest<CR>",
			desc = "In a test file runs the test nearest to the cursor",
		},
		{
			"<leader>tf",
			"<cmd>TestFile<CR>",
			desc = "In a test file runs all tests in the current file",
		},
	},
	config = function()
		vim.cmd("let test#strategy = 'vimux'")
		vim.cmd("let g:test#javascript#runner = 'vitest'")
		vim.cmd("let test#javascript#vitest#executable = 'npm run test'")
	end,
}
