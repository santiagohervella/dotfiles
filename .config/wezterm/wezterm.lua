local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.font = wezterm.font("MesloLGS Nerd Font Mono")
config.font_size = 12.8
config.line_height = 1.3

config.color_scheme = "Gruvbox dark, hard (base16)"

config.enable_tab_bar = false

config.window_decorations = "RESIZE"

config.window_padding = {
	left = 10,
	right = 10,
	top = 8,
	bottom = 0,
}
-- config.use_resize_increments = true

config.keys = {
	-- By default, ctrl + shift + p will open some WezTerm command palette. This is how you disable it
	{
		key = "P",
		mods = "CTRL|SHIFT",
		action = wezterm.action.DisableDefaultAssignment,
	},
}

return config
