return {
	{
		"nvim-lua/plenary.nvim", -- Useful lua functions used by lots of plugins
	},
	-- Navigation of vim splits and tmux panes with the same keymaps
	{
		"christoomey/vim-tmux-navigator",
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
	},
	-- Putting this transparent plugin here because lazy doesn't like files that are 100% commented out
	-- If you ever want to play around with transparency again, just enable this plugin
	-- {
	--   "tribela/transparent.nvim",
	--   event = "VimEnter",
	--   config = true,
	-- }
}
