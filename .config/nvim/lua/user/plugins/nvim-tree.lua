return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local nvim_tree = require("nvim-tree")

		-- TODO: Many symbol settings in old lunarvim setup to look at
		nvim_tree.setup({
			update_focused_file = {
				enable = true,
				update_root = true,
			},
			renderer = {
				icons = {
					glyphs = {
						folder = {
							arrow_closed = "", -- arrow when folder is closed
							arrow_open = "", -- arrow when folder is open
						},
					},
				},
			},
			-- Stolen from: https://github.com/Zeddnyx/Znvim/blob/master/lua/zedd/plugins/nvimtree/setup.lua#L24
			-- Trying out a floating tree. If I don't like it, just go back to the commented out view below this
			-- view = {
			-- 	float = {
			-- 		enable = true,
			-- 		open_win_config = function()
			-- 			local screen_w = vim.opt.columns:get()
			-- 			local w_h = 70
			-- 			local s_h = 42
			-- 			local center_x = (screen_w - w_h) / 2
			-- 			local center_y = ((vim.opt.lines:get() - s_h) / 5) - vim.opt.cmdheight:get()
			-- 			return {
			-- 				border = "rounded",
			-- 				relative = "editor",
			-- 				row = center_y,
			-- 				col = center_x,
			-- 				width = w_h,
			-- 				height = s_h,
			-- 			}
			-- 		end,
			-- 	},
			-- 	width = 50,
			-- },

			-- disable window_picker for
			-- explorer to work well with
			-- window splits
			actions = {
				open_file = {
					window_picker = {
						enable = false,
					},
				},
			},
			view = {
				width = 50,
			},

			filters = {
				dotfiles = false,
				git_ignored = false,
			},
		})

		-- Shorten function name
		local keymap = vim.keymap.set
		-- Silent keymap option
		local opts = { silent = true, desc = "Show nvim-tree" }

		keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
	end,
}
