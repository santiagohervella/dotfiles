-- Started from this config and removed basically everything
-- because so much is taken care of by ./markdown.lua
-- https://github.com/Feel-ix-343/Neovim-Config/blob/ddc0edd0a8046b896be9b4433b1ef45cbb8dad60/lua/plugin/Pencil.lua#L4
return {
	{
		"preservim/vim-pencil",
		ft = { "markdown" },
		config = function()
			vim.cmd([[autocmd Filetype markdown PencilSoft]])
		end,
	},
}
