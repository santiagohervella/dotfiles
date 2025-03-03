-- Found out about this and lifted the config from
-- https://github.com/Wansmer/nvim-config/blob/main/lua/config/plugins/typescript-tools.lua
return {
	"pmizio/typescript-tools.nvim",
	enabled = true, -- TODO: If this is trash, come delete this plugin
	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	ft = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
	},
	opts = {
		on_attach = function(client, _)
			client.server_capabilities.documentFormattingProvider = false
			client.server_capabilities.documentRangeProvider = false
		end,
	},
}
