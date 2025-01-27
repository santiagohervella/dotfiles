return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	-- TODO: Confirm these dependencies with existing setup
	dependencies = {
		"nvim-lua/plenary.nvim",
		-- Fuzzy Finder Algorithm which requires local dependencies to be built.
		-- Only load if `make` is available. Make sure you have the system
		-- requirements installed.
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			-- TODO: Is this check still something I should keep?
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		"nvim-telescope/telescope-ui-select.nvim",
		"nvim-tree/nvim-web-devicons",
		"ThePrimeagen/harpoon",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local themes = require("telescope.themes")

		-- ------------------------------------------------------------------------------------------------
		-- 100% lifted from here: https://github.com/adibhanna/nvim/blob/main/lua/plugins/telescope.lua#L181
		local function document_symbols_for_selected(prompt_bufnr)
			local action_state = require("telescope.actions.state")
			local entry = action_state.get_selected_entry()

			if entry == nil then
				print("No file selected")
				return
			end

			actions.close(prompt_bufnr)

			vim.schedule(function()
				local bufnr = vim.fn.bufadd(entry.path)
				vim.fn.bufload(bufnr)

				local params = { textDocument = vim.lsp.util.make_text_document_params(bufnr) }

				vim.lsp.buf_request(bufnr, "textDocument/documentSymbol", params, function(err, result, _, _)
					if err then
						print("Error getting document symbols: " .. vim.inspect(err))
						return
					end

					if not result or vim.tbl_isempty(result) then
						print("No symbols found")
						return
					end

					local function flatten_symbols(symbols, parent_name)
						local flattened = {}
						for _, symbol in ipairs(symbols) do
							local name = symbol.name
							if parent_name then
								name = parent_name .. "." .. name
							end
							table.insert(flattened, {
								name = name,
								kind = symbol.kind,
								range = symbol.range,
								selectionRange = symbol.selectionRange,
							})
							if symbol.children then
								local children = flatten_symbols(symbol.children, name)
								for _, child in ipairs(children) do
									table.insert(flattened, child)
								end
							end
						end
						return flattened
					end

					local flat_symbols = flatten_symbols(result)

					-- Define highlight group for symbol kind
					vim.cmd([[highlight TelescopeSymbolKind guifg=#61AFEF]])

					require("telescope.pickers")
						.new({}, {
							prompt_title = "Document Symbols: " .. vim.fn.fnamemodify(entry.path, ":t"),
							finder = require("telescope.finders").new_table({
								results = flat_symbols,
								entry_maker = function(symbol)
									local kind = vim.lsp.protocol.SymbolKind[symbol.kind] or "Other"
									return {
										value = symbol,
										display = function(entry)
											local display_text = string.format("%-50s %s", entry.value.name, kind)
											return display_text,
												{ { { #entry.value.name + 1, #display_text }, "TelescopeSymbolKind" } }
										end,
										ordinal = symbol.name,
										filename = entry.path,
										lnum = symbol.selectionRange.start.line + 1,
										col = symbol.selectionRange.start.character + 1,
									}
								end,
							}),
							sorter = require("telescope.config").values.generic_sorter({}),
							previewer = require("telescope.config").values.qflist_previewer({}),
							attach_mappings = function(_, map)
								map("i", "<CR>", function(prompt_bufnr)
									local selection = action_state.get_selected_entry()
									actions.close(prompt_bufnr)
									vim.cmd("edit " .. selection.filename)
									vim.api.nvim_win_set_cursor(0, { selection.lnum, selection.col - 1 })
								end)
								return true
							end,
						})
						:find()
				end)
			end)
		end
		-- ------------------------------------------------------------------------------------------------

		-- configure telescope
		telescope.setup({
			-- configure custom mappings
			defaults = {
				prompt_prefix = " ",
				selection_caret = " ",
				path_display = { "truncate" },
				sorting_strategy = "ascending",
				file_ignore_patterns = { ".git/", "node_modules", ".stubs/" },
				-- make the layout like jetbrains global search
				layout_strategy = "vertical",
				layout_config = {
					vertical = {
						prompt_position = "top",
						mirror = true,
					},
				},
				mappings = {
					i = {
						["<Down>"] = actions.cycle_history_next,
						["<Up>"] = actions.cycle_history_prev,
						["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
						["<C-s>"] = document_symbols_for_selected,
					},
				},
			},
			extensions = {
				["ui-select"] = {
					themes.get_dropdown({}),
				},
			},
			pickers = {
				oldfiles = {
					only_cwd = true,
				},
				lsp_references = {
					fname_width = 100,
				},
			},
		})

		-- Enable telescope fzf native, if installed
		telescope.load_extension("fzf")
		telescope.load_extension("ui-select")
		telescope.load_extension("harpoon")

		-- set line numbers in the telescope window
		vim.cmd("autocmd User TelescopePreviewerLoaded setlocal number")

		-- Shorten function name
		local keymap = vim.keymap.set

		-- find files within current working directory, respects .gitignore
		keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd", silent = true })
		-- find string in current working directory as you type
		keymap("n", "<leader>ft", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd", silent = true })
		-- find string under cursor in current working directory
		keymap(
			"n",
			"<leader>fc",
			"<cmd>Telescope grep_string<cr>",
			{ desc = "Find string under cursor in cwd", silent = true }
		)
		keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Show open buffers", silent = true })
		-- keymap("n", "<leader>fh", "<cmd>Telescope harpoon marks<cr>", { desc = "Show harpoon marks" })
		keymap("n", "<leader>km", "<cmd>Telescope keymaps<cr>", { desc = "Show keymaps" })
		keymap("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Show recent files" })

		-- TODO: Consider trying these out
		-- list all git commits (use <cr> to checkout) ["gc" for git commits]
		keymap("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", { desc = "Show git commits" })
		-- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
		keymap("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>", { desc = "Show git commits for current buffer" })
		-- list current changes per file with diff preview ["gs" for git status]
		keymap("n", "<leader>gs", "<cmd>Telescope git_status<cr>", { desc = "Show current git changes per file" })
		keymap("n", "<leader>fn", "<cmd>TodoTelescope<cr>", { desc = "Find Notes: Show all TODOs in cwd" })
		keymap("n", "<leader>rr", "<cmd>Telescope registers<CR>", { desc = "Show registers" })
	end,
}
