local opt = vim.opt

-- line numbers
opt.number = true -- set numbered lines
opt.relativenumber = true -- set relative numbers

-- No vertical lines in splits
vim.opt.fillchars = "vert:⠀"

-- tabs & indentation
opt.tabstop = 2 -- insert 2 spaces for a tab
opt.shiftwidth = 2 -- the number of spaces inserted for each indentation
opt.expandtab = true -- convert tabs to spaces
opt.autoindent = true -- TODO: Not in my old config, do I need this?

-- line wrapping
opt.wrap = false -- display lines as one long line

opt.scrolloff = 8 -- Minimal number of screen lines to keep above and below the cursor

-- search settings
opt.ignorecase = true -- ignore case in search patterns
opt.smartcase = true -- smart case means that case matters if you use any capital letters as part of the search

-- cursor line
opt.cursorline = true -- highlight the current line
opt.showmode = false

-- appearance
opt.termguicolors = true -- set term gui colors
opt.background = "dark"
opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time

-- backspace
opt.backspace = "indent,eol,start" -- allows you to delete more things using backspace

-- clipboard
opt.clipboard = "unnamedplus"

-- split windows
opt.splitbelow = true -- force all horizontal splits to go below current window
opt.splitright = true -- force all vertical splits to go to the right of current window

-- highlight yanked text for 150ms using the "Visual" highlight group
vim.cmd([[
  augroup highlight_yank
  autocmd!
  au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=150})
  augroup END
]])
