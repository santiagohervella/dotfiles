return {
	{
		-- Damn, I think I like this one with a hint of orange the best
		"sainnhe/gruvbox-material",
		enabled = true,
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			vim.g.gruvbox_material_background = "hard"
			vim.g.gruvbox_material_better_performance = 1
			-- load the colorscheme here
			vim.cmd([[colorscheme gruvbox-material]])

			local original_highlight = vim.api.nvim_get_hl(0, { name = "Normal" })

			vim.keymap.set("n", "<leader>bga", '<cmd>lua vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" })<CR>')
			vim.keymap.set("n", "<leader>bgb", function()
				vim.api.nvim_set_hl(0, "Normal", original_highlight)
			end)
		end,
	},
	-- {
	-- I don't love this one as much as I used to. I like the tint, but don't love the orange
	-- "ellisonleao/gruvbox.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	--    vim.cmd([[colorscheme gruvbox]])
	-- 	end,
	-- },
	-- {
	-- This version of gruvbox is better because the shitty orange is gone
	--  "luisiacc/gruvbox-baby",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	--    vim.cmd([[colorscheme gruvbox-baby]])
	-- 	end,
	-- },
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
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.cmd([[colorscheme nightfly]])
	-- 	end,
	-- },
	{
		-- Solid theme, nothing objectionable, but it just feels a bit too cold for me, personally
		-- Of the 4 different variations, I like the default one the best aka tokyonight-moon
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		-- config = function()
		-- 	vim.cmd([[colorscheme tokyonight]])
		-- end,
	},
	-- {
	-- Again, not too shabby, but the green is too much and too much contrast
	-- "EdenEast/nightfox.nvim",
	--lazy = false,
	--priority = 1000,
	--config = function()
	--	-- load the colorscheme here
	--	vim.cmd([[colorscheme carbonfox]])
	--end,
	-- },
	-- {
	-- "marko-cerovac/material.nvim",
	--lazy = false,
	--priority = 1000,
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
	--lazy = false,
	--priority = 1000,
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
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		-- vim.cmd([[colorscheme kanagawa-dragon]]) -- The darker version, but I find it a bit too dull and too low contrast
	-- 		vim.cmd([[colorscheme kanagawa-wave]]) -- Bluer, definitely easier to read. This is where the too much yellow really comes into play
	-- 	end,
	-- },
	-- {
	-- -- This one prides itself on the transparency support, but I don't have that set up for iTerm, turns out I prefer a consistent background
	-- 	-- I don't love the blue or the green in this theme
	-- 	-- There is also too much white, which sometimes makes it harder to spot my cursor
	-- 	-- Sadly, I also hate the line hilight color. I think the normal / insert mode color is the same as the visual modes color, which is quite the oversight!
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
	{
		-- This one is pretty sweet, especially with the pure black color overrides
		-- Unfortunately, it suffers from the same vim-illuminate issue as nightfly
		-- Custom catppuccin/nvim
		-- https://github.com/nullchilly/CatNvim/blob/bea18b53958627aff3051c22591a4f5771a882c8/lua/plugins/colorscheme.lua#L24-L30
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha", -- latte, frappe, macchiato, mocha
				term_colors = true,
				transparent_background = false,
				no_italic = false,
				no_bold = false,
				styles = {
					comments = {},
					conditionals = {},
					loops = {},
					functions = {},
					keywords = {},
					strings = {},
					variables = {},
					numbers = {},
					booleans = {},
					properties = {},
					types = {},
				},
				color_overrides = {
					mocha = {
						base = "#000000",
						mantle = "#000000",
						crust = "#000000",
					},
				},
				highlight_overrides = {
					mocha = function(C)
						return {
							TabLineSel = { bg = C.pink },
							CmpBorder = { fg = C.surface2 },
							Pmenu = { bg = C.none },
							TelescopeBorder = { link = "FloatBorder" },
						}
					end,
				},
			})

			-- vim.cmd.colorscheme("catppuccin")
		end,
	},
	-- {
	-- This is catppuccin without any mods
	-- It's pretty good, but gives a bit too much VSCode vibes for me?
	-- Update 9/23/24: I tried using this theme for a few days. I got used to it and eventually began to enjoy it
	-- But then I went briefly back to gruvbox and when I flipped back to this one afterwards it felt way too intense
	-- I think this is a totally usable theme, but I vastly prefer the less in your face colors of gruvbox
	-- 	"catppuccin/nvim",
	-- 	name = "catppuccin",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.cmd.colorscheme("catppuccin-mocha")
	-- 	end,
	-- },
	-- {
	--    -- This one is waaaaay too bright, feels like you're tripping on pink
	-- 	"samharju/synthweave.nvim",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.cmd([[colorscheme synthweave]])
	-- 	end,
	-- },
	-- {
	-- 	-- Not too shabby, I think this is largely usable. The only thing I don't like is the underlining to show occurrances of what's under the cursor.
	-- 	-- It makes me feel like it's a diagnostic
	-- 	"mhartington/oceanic-next",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.cmd([[colorscheme OceanicNext]])
	-- 	end,
	-- },
	-- {
	-- -- Not bad, but I don't love how the highlighting looks, sadly. It's too similar and I struggle to tell the difference
	-- 	"rose-pine/neovim",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.cmd([[colorscheme rose-pine]])
	-- 	end,
	-- },
	{
		-- My favorite synthwave style one yet! I used this for a few weeks at home
		"maxmx03/fluoromachine.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			local fm = require("fluoromachine")

			fm.setup({
				glow = false,
				theme = "delta",
				transparent = false,
			})

			-- vim.cmd.colorscheme("fluoromachine")
		end,
	},
	-- {
	-- 	-- Wow, farout-moon is quite nice regular theme!
	-- 	-- farout, farout-night, farout-storm all appear to be the same. And it looks cool for AVP work, but I just wish it wasn't so damn dark...
	-- 	"thallada/farout.nvim",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.cmd([[colorscheme farout]])
	-- 	end,
	-- },
	-- {
	-- 	-- Quite agressive, but it might be an AVP contendor haha
	-- 	"L-Colombo/oldschool.nvim",
	-- 	priority = 1000,
	-- 	config = true,
	-- 	config = function()
	-- 		vim.cmd([[colorscheme oldschool]])
	-- 	end,
	-- },
	{
		-- Excellent. It's just green and black Achieves what it set out to do. Of course, I lose most syntax highlighting, but it feels fun to try
		-- Update: I've been this one at home for Golang for a few weeks and I dig it!
		"julien/vim-colors-green",
		priority = 1000,
		-- config = function()
		-- 	vim.cmd([[colorscheme green]])
		-- 	vim.cmd([[set nocursorline]])
		-- end,
	},
	-- {
	-- -- This is the theme that Shruti Ray uses is her setup. I like it as a contender to use with the AVP
	-- -- But I don't think I like it more than the above flouromachine theme for this purpose
	-- 	"baliestri/aura-theme",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function(plugin)
	-- 		vim.opt.rtp:append(plugin.dir .. "/packages/neovim")
	-- 		vim.cmd([[colorscheme aura-dark]])
	-- 	end,
	-- },
	-- {
	-- 	-- Also quite good, but the shades make some of the text a bit too dark for my liking
	-- 	"linusng/green-shades.vim",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.cmd([[colorscheme green-shades]])
	-- 	end,
	-- },
	{
		-- Kinda Tron Ares vibes in a way, but it may be too agressively red to use for AVP? Hmm
		"DonJulve/NeoCyberVim",
		priority = 1000,
		-- config = function()
		-- 	vim.cmd([[colorscheme NeoCyberVim]])
		-- end,
	},
	{
		-- Daniel Cañas showed me this one. Looks like a mid 2000s theme in a good way
		"jnurmine/Zenburn",
		priority = 1000,
		-- config = function()
		-- 	vim.cmd.colorscheme("zenburn")
		-- end,
	},
	{
		-- Quite nice! I think the hard red color might be too harsh, but otherwise, pretty usable
		"paulfrische/reddish.nvim",
		priority = 1000,
		-- config = function()
		-- 	vim.cmd([[colorscheme reddish]])
		-- end,
	},
	-- {
	--    -- Totally fine, but it's too soft for my preference
	-- 	"thesimonho/kanagawa-paper.nvim",
	-- 	priority = 1000,
	-- 	opts = {},
	-- },
}
