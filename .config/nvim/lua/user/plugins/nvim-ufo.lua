-- Mostly took this config from here:
-- https://github.com/Sin-cy/dotfiles/blob/main/nvim/.config/nvim/lua/sethy/plugins/nvim-ufo.lua
return {
	-- Setup Folding with nvim-ufo
	{
		"kevinhwang91/nvim-ufo",
		dependencies = {
			"kevinhwang91/promise-async",
		},
		enabled = false,
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("ufo").setup({
				-- treesitter not required
				-- ufo uses the same query files for folding (queries/<lang>/folds.scm)
				-- performance and stability are better than `foldmethod=nvim_treesitter#foldexpr()`-
				provider_selector = function(_, _, _)
					return { "treesitter", "indent" }
				end,
				open_fold_hl_timeout = 0, -- Disable highlight timeout after opening
			})

			-- These are recommended options to set according this plugin's documentation:
			-- https://github.com/kevinhwang91/nvim-ufo?tab=readme-ov-file#minimal-configuration
			vim.o.foldenable = true
			vim.o.foldcolumn = "0" -- '0' is not bad
			vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
			vim.o.foldlevelstart = 99

			-- za to fold at cursor location is already enabled
			vim.keymap.set("n", "zO", require("ufo").openAllFolds)
			vim.keymap.set("n", "zC", require("ufo").closeAllFolds)
		end,
	},
}
