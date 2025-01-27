return {
	"hrsh7th/nvim-cmp", -- completion plugin
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer", -- source for text in buffer
		"hrsh7th/cmp-path", -- source for file system paths
		{
			"L3MON4D3/LuaSnip", -- snippet engine
			-- follow latest release.
			version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
			-- install jsregexp (optional!).
			build = "make install_jsregexp",
		},
		"saadparwaiz1/cmp_luasnip", -- for autocompletion
		"rafamadriz/friendly-snippets", -- useful snippets
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		-- load friendly-snippets
		require("luasnip/loaders/from_vscode").lazy_load()

		vim.opt.completeopt = "menu,menuone,noselect"

		cmp.setup({
			snippet = { -- configure how nvim-cmp interacts with snippet engine
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				-- I can't seem to get these two scroll commands to do anything. I wonder if they're conflicting with somethingr
				["<Up>"] = cmp.mapping.scroll_docs(-4), -- old lunarvim config had this as -1
				["<Down>"] = cmp.mapping.scroll_docs(4), -- old lunarvim config had this as 1
				["<C-Space>"] = cmp.mapping.complete(), -- TODO: Remove? I use <C-n> to do this
				["<C-e>"] = cmp.mapping.abort(), -- TODO: Remove? I use <C-c> even though that takes me out of insert mode. <C-e> conflicts with tmux so I have to hit it twice
				["<CR>"] = cmp.mapping.confirm({ select = false }), -- When nothing is highlighted in the menu, pressing Enter actually sends <CR> instead of accepting the first option
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" }, -- lsp
				{ name = "luasnip" }, -- snippets
				{ name = "buffer" }, -- text within current buffer
				{ name = "path" }, -- file system paths
			}),
		})
	end,
}
