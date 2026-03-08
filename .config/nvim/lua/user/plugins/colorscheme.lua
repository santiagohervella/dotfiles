-- Use the github path when setting default_theme
local default_theme = "sainnhe/gruvbox-material"

-- Map of github paths to colorscheme names (only needed when they don't derive automatically)
local colorscheme_names = {
	["julien/vim-colors-green"] = "green",
	["baliestri/aura-theme"] = "aura-dark",
	["catppuccin/nvim"] = "catppuccin-mocha",
	["jnurmine/Zenburn"] = "zenburn",
	-- Most themes derive automatically: "foo/bar.nvim" → "bar", "foo/vim-colors-bar" → "bar"
}

local function apply_default(themes, default)
	local function get_colorscheme_name(repo)
		if colorscheme_names[repo] then
			return colorscheme_names[repo]
		end
		-- "user/plugin-name.nvim" → "plugin-name"
		local name = repo:match(".*/(.+)$"):gsub("%.nvim$", ""):gsub("^vim%-colors%-", "")
		return name
	end

	for _, spec in ipairs(themes) do
		local is_default = spec[1] == default
		local colorscheme = get_colorscheme_name(spec[1])
		local original_config = spec.config

		-- All themes loaded (not lazy) so Telescope can discover them
		spec.lazy = false
		spec.priority = is_default and 1000 or nil

		if is_default then
			-- Default theme: run config immediately and apply colorscheme
			spec.config = function(plugin, opts)
				if original_config then
					original_config(plugin, opts)
				end
				vim.cmd.colorscheme(colorscheme)
			end
		elseif original_config then
			-- Non-default theme with config: defer until colorscheme is selected
			spec.config = function(plugin, opts)
				vim.api.nvim_create_autocmd("ColorSchemePre", {
					pattern = colorscheme,
					once = true,
					callback = function()
						original_config(plugin, opts)
					end,
				})
			end
		end
		-- Non-default themes without config: no changes needed
	end

	return themes
end

local themes = {
	{
		-- Damn, I think I like this one with a hint of orange the best
		"sainnhe/gruvbox-material",
		config = function()
			vim.g.gruvbox_material_background = "hard"
			vim.g.gruvbox_material_better_performance = 1

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
	{
		--  -- Had potential because the vibe is cool, but I think it's just too monochromatic for me. Not enough difference in the highlighting
		"nyoom-engineering/oxocarbon.nvim",
		config = function()
			vim.opt.background = "dark"
		end,
	},
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
		-- lazy = false,
		-- priority = 1000,
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
		-- This is catppuccin without any mods
		-- It's pretty good, but gives a bit too much VSCode vibes for me?
		-- Update 9/23/24: I tried using this theme for a few days. I got used to it and eventually began to enjoy it
		-- But then I went briefly back to gruvbox and when I flipped back to this one afterwards it felt way too intense
		-- I think this is a totally usable theme, but I vastly prefer the less in your face colors of gruvbox
		"catppuccin/nvim",
		name = "catppuccin",
	},
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
		config = function()
			local fm = require("fluoromachine")

			fm.setup({
				glow = false,
				theme = "delta",
				transparent = false,
			})
		end,
	},
	{
		-- 	-- Wow, farout-moon is quite nice regular theme!
		-- 	-- farout, farout-night, farout-storm all appear to be the same. And it looks cool for AVP work, but I just wish it wasn't so damn dark...
		"thallada/farout.nvim",
	},
	{
		-- 	-- Quite agressive, but it might be an AVP contendor haha
		"L-Colombo/oldschool.nvim",
		config = function()
			require("oldschool").setup()
		end,
	},
	{
		-- Excellent. It's just green and black Achieves what it set out to do. Of course, I lose most syntax highlighting, but it feels fun to try
		-- Update: I've been this one at home for Golang for a few weeks and I dig it!
		"julien/vim-colors-green",
		config = function()
			vim.cmd([[set nocursorline]])
		end,
	},
	{
		-- This is the theme that Shruti Ray uses is her setup. I like it as a contender to use with the AVP
		-- But I don't think I like it more than the above flouromachine theme for this purpose
		"baliestri/aura-theme",
	},
	-- {
	-- 	-- Also quite good, but the shades make some of the text a bit too dark for my liking
	-- 	"linusng/green-shades.vim",
	-- },
	{
		-- Kinda Tron Ares vibes in a way, but it may be too agressively red to use for AVP? Hmm
		"DonJulve/NeoCyberVim",
	},
	{
		-- Daniel Cañas showed me this one. Looks like a mid 2000s theme in a good way
		"jnurmine/Zenburn",
	},
	{
		-- Quite nice! I think the hard red color might be too harsh, but otherwise, pretty usable
		"paulfrische/reddish.nvim",
	},
	{
		-- Totally fine, but it's too soft for my preference
		"thesimonho/kanagawa-paper.nvim",
	},
	{
		-- This theme is quite nice. The screenshot in the git repo made it an easy sell.
		-- Will definitely keep in as one I can switch to
		"bachiitter/orng.nvim",
		config = function()
			require("orng").setup({
				integrations = {
					lualine = true,
				},
			})
		end,
	},
	{
		-- Found out about this one here: https://www.youtube.com/post/UgkxYydF-aM2J7j_mhuzw-e4R63O1ZsDsHxK
		-- These are really quite nice! This is a contendor for my go-to green theme
		-- There are even multiple green versions in here that I'm enjoying!
		"kungfusheep/mfd.nvim",
	},
	-- {
	--  -- Too muted, my eyes struggle to differentiate
	-- 	"vague-theme/vague.nvim",
	-- },
	{
		-- Found out about this one from this interview: https://people.zsa.io/jackson-hayes
		-- A bit too dull for my taste. Thing is that this theme still differentiates certain syntax with multiple colors.
		-- But the colors are so close to each other that it becomes solely an aesthetic choice rather than actually practical
		-- Not bad but still propably a bit too muted for my taste
		"webhooked/kanso.nvim",
	},
	{
		-- Ooo, this one is legitimately quite nice, I like the red. It's tasteful! Might take this one for a spin!
		"ficcdaf/ashen.nvim",
	},
}

return apply_default(themes, default_theme)
