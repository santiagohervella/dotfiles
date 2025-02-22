return {
	{
		-- I don't love this one as much as I used to. I like the tint, but don't love the orange
		-- "ellisonleao/gruvbox.nvim",
		-- This version of gruvbox is better because the shitty orange is gone
		--"luisiacc/gruvbox-baby",
		-- Damn, I think I like this one with a hint of orange the best
		"sainnhe/gruvbox-material",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			vim.g.gruvbox_material_background = "hard"
			vim.g.gruvbox_material_better_performance = 1
			-- load the colorscheme here
			vim.cmd([[colorscheme gruvbox-material]])
			-- vim.cmd([[colorscheme gruvbox-baby]])

			local original_highlight = vim.api.nvim_get_hl(0, { name = "Normal" })

			vim.keymap.set("n", "<leader>bga", '<cmd>lua vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" })<CR>')
			vim.keymap.set("n", "<leader>bgb", function()
				vim.api.nvim_set_hl(0, "Normal", original_highlight)
			end)
		end,
	},
	-- {
	--  -- Had potential because the vibe is cool, but I think it's just too monochromatic for me. Not enough difference in the highlighting
	-- 	"nyoom-engineering/oxocarbon.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.opt.background = "dark"
	-- 		vim.cmd.colorscheme("oxocarbon")
	-- 	end,
	-- },
	-- Good theme, but I don't like that the highlighting method picked up by vim-illuminate is underline instead of a highlight
	-- {
	-- 	"bluz71/vim-nightfly-guicolors",
	-- 	priority = 1000, -- make sure to load this before all the other start plugins
	-- 	config = function()
	-- 		-- load the colorscheme here
	-- 		vim.cmd([[colorscheme nightfly]])
	-- 	end,
	-- },
	-- {
	-- 	-- Solid theme, nothing objectionable, but it just feels a bit too cold for me, personally
	-- 	"folke/tokyonight.nvim",
	-- 	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	-- 	priority = 1000, -- make sure to load this before all the other start plugins
	-- 	config = function()
	-- 		-- load the colorscheme here
	-- 		vim.cmd([[colorscheme tokyonight]])
	-- 	end,
	-- },
	-- {
	-- Again, not too shabby, but the green is too much and too much contrast
	-- "EdenEast/nightfox.nvim",
	--lazy = false, -- make sure we load this during startup if it is your main colorscheme
	--priority = 1000, -- make sure to load this before all the other start plugins
	--config = function()
	--	-- load the colorscheme here
	--	vim.cmd([[colorscheme carbonfox]])
	--end,
	-- },
	-- {
	-- "marko-cerovac/material.nvim",
	--lazy = false, -- make sure we load this during startup if it is your main colorscheme
	--priority = 1000, -- make sure to load this before all the other start plugins
	--config = function()
	--	-- load the colorscheme here
	--	-- Not too bad
	--	-- vim.g.material_style = "darker"
	--	-- I like this one, but the contrast is just a bit too high
	--	vim.g.material_style = "deep ocean"
	--	vim.cmd([[colorscheme material]])
	--end,
	-- },
	-- {
	-- This one is pretty good, but suffers again from just too much orange
	-- "sainnhe/sonokai",
	--lazy = false, -- make sure we load this during startup if it is your main colorscheme
	--priority = 1000, -- make sure to load this before all the other start plugins
	--config = function()
	--	-- load the colorscheme here
	--	vim.g.sonokai_style = "espresso"
	--	vim.cmd([[colorscheme sonokai]])
	--end,
	-- },
	-- {
	-- 	-- https://github.com/rebelot/kanagawa.nvim
	-- 	-- Too much yellow, I don't love this one...
	-- 	-- On second thought, this one is not bad
	-- 	-- Unfortunately, it suffers from the same vim-illuminate issue as nightfly
	-- 	"rebelot/kanagawa.nvim",
	-- 	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	-- 	priority = 1000, -- make sure to load this before all the other start plugins
	-- 	config = function()
	-- 		-- load the colorscheme here
	-- 		-- vim.cmd([[colorscheme kanagawa-dragon]]) -- The darker version, but I find it a bit too dull and too low contrast
	-- 		vim.cmd([[colorscheme kanagawa-wave]]) -- Bluer, definitely easier to read. This is where the too much yellow really comes into play
	-- 	end,
	-- },
	-- {
	-- -- This one prides itself on the transparency support, but I don't have that set up for iTerm, turns out I prefer a consistent background
	-- 	"scottmckendry/cyberdream.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("cyberdream").setup({
	-- 			-- Enable transparent background
	-- 			transparent = true,
	-- 		})
	--
	-- 		vim.cmd([[colorscheme cyberdream]])
	-- 	end,
	-- },
	-- {
	-- 	-- This one is pretty sweet, especially with the pure black color overrides
	-- 	-- Unfortunately, it suffers from the same vim-illuminate issue as nightfly
	-- 	-- Custom catppuccin/nvim
	-- 	-- https://github.com/nullchilly/CatNvim/blob/bea18b53958627aff3051c22591a4f5771a882c8/lua/plugins/colorscheme.lua#L24-L30
	-- 	"catppuccin/nvim",
	-- 	name = "catppuccin",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("catppuccin").setup({
	-- 			flavour = "mocha", -- latte, frappe, macchiato, mocha
	-- 			term_colors = true,
	-- 			transparent_background = false,
	-- 			no_italic = false,
	-- 			no_bold = false,
	-- 			styles = {
	-- 				comments = {},
	-- 				conditionals = {},
	-- 				loops = {},
	-- 				functions = {},
	-- 				keywords = {},
	-- 				strings = {},
	-- 				variables = {},
	-- 				numbers = {},
	-- 				booleans = {},
	-- 				properties = {},
	-- 				types = {},
	-- 			},
	-- 			color_overrides = {
	-- 				mocha = {
	-- 					base = "#000000",
	-- 					mantle = "#000000",
	-- 					crust = "#000000",
	-- 				},
	-- 			},
	-- 			highlight_overrides = {
	-- 				mocha = function(C)
	-- 					return {
	-- 						TabLineSel = { bg = C.pink },
	-- 						CmpBorder = { fg = C.surface2 },
	-- 						Pmenu = { bg = C.none },
	-- 						TelescopeBorder = { link = "FloatBorder" },
	-- 					}
	-- 				end,
	-- 			},
	-- 		})
	--
	-- 		vim.cmd.colorscheme("catppuccin")
	-- 	end,
	-- },
	-- {
	-- This is catppuccin without any mods
	-- It's pretty good, but gives a bit too much VSCode vibes for me?
	-- Update 9/23/24: I tried using this theme for a few days. I got used to it and eventually began to enjoy it
	-- But then I went briefly back to gruvbox and when I flipped back to this one afterwards it felt way too intense
	-- I think this is a totally usable theme, but I vastly prefer the less in your face colors of gruvbox
	-- 	"catppuccin/nvim",
	-- 	name = "catppuccin",
	-- 	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.cmd.colorscheme("catppuccin-mocha")
	-- 	end,
	-- },
	-- {
	-- 	-- I don't love the blue or the green in this theme
	-- 	-- There is also too much white, which sometimes makes it harder to spot my cursor
	-- 	-- Sadly, I also hate the line hilight color. I think the normal / insert mode color is the same as the visual modes color, which is quite the oversight!
	-- 	"scottmckendry/cyberdream.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- },
}
