-- Found out about this one from Ike Isenhour (https://github.com/ikeisenhour)
return {
	"hat0uma/csvview.nvim",
	---@module "csvview"
	ft = { "csv", "tsv" },
	---@type CsvView.Options
	opts = {
		parser = { comments = { "#", "//" } },
		view = { display_mode = "border" },
	},
	config = function(_, opts)
		require("csvview").setup(opts)
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "csv", "tsv" },
			callback = function()
				vim.cmd("CsvViewEnable")
			end,
		})
	end,
}
