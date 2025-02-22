return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		gitbrowse = { enabled = true },
		indent = {
			enabled = false,
			animate = {
				enabled = false,
			},
			chunk = {
				enabled = true,
			},
		},
		bigfile = {
			enabled = true,
		},
		dashboard = {
			enabled = true,
			preset = {
				---@type snacks.dashboard.Item[]
				keys = {
					{
						desc = "Find File",
						action = "<leader>ff",
						key = "f",
						hidden = true,
					},
					{
						desc = "Find Text",
						action = "<leader>ft",
						key = "t",
						hidden = true,
					},
					{
						desc = "Find Recent",
						action = "<leader>fr",
						key = "r",
						hidden = true,
					},
					{
						desc = "Quit",
						action = ":qa",
						key = "q",
						hidden = true,
					},
				},
				header = vim.fn.execute("version"),
			},
			formats = {
				-- The only reason I have a custom formatter for files is because the
				-- path shown started from the home directory which is useless!

				-- Remove current working directory from the beginning of the path
				file = function(item, ctx)
					local cwd = vim.fn.getcwd()
					local fname = vim.fn.fnamemodify(item.file, ":p")

					if fname:sub(1, #cwd) == cwd then
						fname = fname:sub(#cwd + 2) -- Remove the cwd and the leading "/"
					end

					fname = ctx.width and #fname > ctx.width and vim.fn.pathshorten(fname) or fname
					if #fname > ctx.width then
						local dir = vim.fn.fnamemodify(fname, ":h")
						local file = vim.fn.fnamemodify(fname, ":t")
						if dir and file then
							file = file:sub(-(ctx.width - #dir - 2))
							fname = dir .. "/…" .. file
						end
					end
					local dir, file = fname:match("^(.*)/(.+)$")
					return dir and { { dir .. "/", hl = "dir" }, { file, hl = "file" } } or { { fname, hl = "file" } }
				end,
			},
			sections = {
				{ section = "header", padding = 1 },
				{ section = "keys" },
				{ section = "recent_files", cwd = true, limit = 4, padding = 1 },
				{ section = "startup" },
			},
		},
	},
	keys = {
		{
			"<leader>gw",
			"<cmd>lua require('snacks').gitbrowse()<CR>",
			desc = "Open current file in the browser",
		},
		{
			"<leader>ib",
			function()
				local snacks = require("snacks")
				if snacks.indent.enabled then
					snacks.indent.disable()
				else
					snacks.indent.enable()
				end
			end,
			desc = "Toggle indenting blank lines",
		},
		{
			"<leader>fh",
			function()
				Snacks.picker.help()
			end,
			desc = "Help Pages for anything in your nvim config",
		},
	},
}
