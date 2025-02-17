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
	},
	keys = {
		{
			"<leader>ff",
			"<cmd>Telescope find_files<CR>",
			desc = "Fuzzy find files in cwd, respects .gitignore",
		},
		{
			"<leader>ft",
			"<cmd>Telescope live_grep<CR>",
			desc = "Find string in cwd",
		},
		{
			"<leader>fc",
			"<cmd>Telescope grep_string<CR>",
			desc = "Find string under cursor in cwd",
		},
		{
			"<leader>km",
			"<cmd>Telescope keymaps<CR>",
			desc = "Show keymaps",
		},
		{
			"<leader>fr",
			"<cmd>Telescope oldfiles<CR>",
			desc = "Show recent files",
		},
		-- Trying out snip.nvim instead of Telescope for finding open buffers
		-- Check out ./snipe.lua
		-- {
		-- 	"<leader>fb",
		-- 	"<cmd>Telescope buffers<CR>",
		-- 	desc = "Show open buffers",
		-- },
		-- Experimental keymaps (TODO: Try these out!)
		{
			"<leader>fs",
			":lua document_symbols_for_current_buffer()<CR>",
			desc = "Show LSP symbols for current buffer",
		},
		{
			"<leader>gc",
			"<cmd>Telescope git_commits<CR>",
			desc = "List all git commits (use <CR> to checkout)",
		},
		{
			"<leader>gfc",
			"<cmd>Telescope git_bcommits<CR>",
			desc = "List git commits for current buffer (use <CR> to checkout)",
		},
		{
			"<leader>gs",
			"<cmd>Telescope git_status<CR>",
			desc = "List current git changes per file with diff preview",
		},
		{
			"<leader>fn",
			"<cmd>TodoTelescope<CR>",
			desc = "Find Notes: Show all TODOs in cwd",
		},
		{
			"<leader>rr",
			"<cmd>Telescope registers<CR>",
			desc = "Show registers",
		},
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local themes = require("telescope.themes")

		-- ------------------------------------------------------------------------------------------------
		-- ------------------------------------------------------------------------------------------------
		-- ------------------------------------------------------------------------------------------------
		-- ------------------------------------------------------------------------------------------------
		-- ------------------------------------------------------------------------------------------------
		-- ------------------------------------------------------------------------------------------------
		-- Originally lifted from here: https://github.com/adibhanna/nvim/blob/main/lua/plugins/telescope.lua#L181
		-- Then used an LLM to help me write this functionality. Honestly, shocked that it works
		local action_state = require("telescope.actions.state")

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

		local function get_document_symbols(bufnr, callback)
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

				callback(flatten_symbols(result))
			end)
		end

		local function display_symbols(flat_symbols, prompt_title, entry)
			vim.cmd([[highlight TelescopeSymbolKind guifg=#61AFEF]])

			require("telescope.pickers")
				.new({}, {
					prompt_title = prompt_title,
					finder = require("telescope.finders").new_table({
						results = flat_symbols,
						entry_maker = function(symbol)
							local kind = vim.lsp.protocol.SymbolKind[symbol.kind] or "Other"
							return {
								value = symbol,
								display = function(e)
									local display_text = string.format("%-50s %s", e.value.name, kind)
									return display_text,
										{ { { #e.value.name + 1, #display_text }, "TelescopeSymbolKind" } }
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
		end

		local function document_symbols_for_selected(prompt_bufnr)
			-- local action_state = require("telescope.actions.state")
			local entry = action_state.get_selected_entry()

			if entry == nil then
				print("No file selected")
				return
			end

			actions.close(prompt_bufnr)

			vim.schedule(function()
				local bufnr = vim.fn.bufadd(entry.path)
				vim.fn.bufload(bufnr)

				get_document_symbols(bufnr, function(flat_symbols)
					display_symbols(flat_symbols, "Document Symbols: " .. vim.fn.fnamemodify(entry.path, ":t"), entry)
				end)
			end)
		end

		local function document_symbols_for_current_buffer()
			local bufnr = vim.api.nvim_get_current_buf()

			get_document_symbols(bufnr, function(flat_symbols)
				display_symbols(flat_symbols, "Document Symbols", { path = vim.api.nvim_buf_get_name(bufnr) })
			end)
		end

		_G.document_symbols_for_current_buffer = document_symbols_for_current_buffer

		-- ------------------------------------------------------------------------------------------------
		-- ------------------------------------------------------------------------------------------------
		-- ------------------------------------------------------------------------------------------------
		-- ------------------------------------------------------------------------------------------------
		-- ------------------------------------------------------------------------------------------------
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
				find_files = {
					hidden = true,
				},
				-- A big thank you to this person for finally getting this to work the way I've always wanted
				-- https://github.com/nvim-telescope/telescope.nvim/issues/855#issuecomment-1032325327
				live_grep = {
					additional_args = function(_)
						return { "--hidden" }
					end,
				},
				grep_string = {
					additional_args = function(_)
						return { "--hidden" }
					end,
				},
			},
		})

		-- Enable telescope fzf native, if installed
		telescope.load_extension("fzf")
		telescope.load_extension("ui-select")

		-- set line numbers in the telescope window
		vim.cmd("autocmd User TelescopePreviewerLoaded setlocal number")
	end,
}
