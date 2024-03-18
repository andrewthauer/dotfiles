-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Remap leader key so its easier to reach
vim.g.mapleader = "'"
-- vim.g.maplocalleader = ' '

-- Enable .editorconfig (default is true in nvim)
vim.g.editorconfig = true

-- Use nerd font
vim.g.have_nerd_font = false

-- disable netrw at the very start of your init.lua
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- Enable auto format (custom / lazyvim)
vim.g.autoformat = true

-- See `:help vim.opt`

-- ------------------------------------
-- Turn Off Swap Files
-- ------------------------------------

vim.opt.swapfile = false          -- turn off swap file

vim.opt.autoread = true           -- Reload files changed outside vim
vim.opt.autowrite = true          -- Automatically write before running commands

vim.opt.confirm = true            -- Confirm to save changes before exiting modified buffer
vim.opt.cursorline = true         -- Highlight current line
vim.opt.laststatus = 3            -- global statusline
vim.opt.mouse = "a"               -- Enable mouse mode
vim.opt.number = true             -- Print line number
vim.opt.relativenumber = true     -- Relative line numbers are also good
vim.opt.pumblend = 10             -- Popup blend
vim.opt.pumheight = 10            -- Maximum number of entries in a popup
vim.opt.ruler = true              -- Show row/col number
vim.opt.scrolloff = 4             -- Lines of context
vim.opt.showcmd = true            -- Show incomplete cmds down the bottom
vim.opt.showmode = false          -- Show current mode down the bottom
vim.opt.termguicolors = true      -- True color support
vim.opt.visualbell = true         -- No sounds
vim.opt.virtualedit = "block"     -- Allow cursor to move where there is no text in visual block mode
vim.opt.winminwidth = 5           -- Minimum window width

vim.opt.signcolumn = "yes"        -- Keep signcolumn on by default
vim.opt.clipboard = "unnamedplus" -- Sync clipboard between OS and Neovim

vim.opt.timeoutlen = 500          -- Displays which-key popup sooner
-- vim.opt.updatetime = 250          -- Decrease update time

-- Undo/Redo
vim.opt.undofile = true   -- Use the undo file
vim.opt.undolevels = 1000 -- Lots of undo levels

-- Things to remember when restoring a session
vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }

-- Indentation
-- vim.opt.breakindent = true
vim.opt.expandtab = true   -- Use spaces instead of tabs
vim.opt.shiftround = true  -- Round indent
vim.opt.shiftwidth = 2     -- Size of an indent
vim.opt.smartindent = true -- Insert indents automatically
vim.opt.softtabstop = 2    -- How many columns of whitespace for tab keypress/backspace
vim.opt.tabstop = 2        -- Number of spaces tabs count for

-- Text Wrapping
vim.opt.wrap = false -- Disable line wrap
-- vim.opt.linebreak = true               -- Wrap lines at convenient points

-- Folds
-- vim.opt.foldexpr = "v:lua.require'lazyvim.util'.ui.foldexpr()"
-- vim.opt.foldlevel = 99
-- vim.opt.foldmethod = "expr"
-- vim.opt.foldtext = "v:lua.require'lazyvim.util'.ui.foldtext()"

-- vim.opt.wildmenu = true                -- Enable ctrl-n and ctrl-p to scroll thru matches
vim.opt.wildmode = "longest:full,full" -- Wildmenu automcomplete behaviour

-- Search
-- vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.grepprg = "rg --vimgrep"
vim.opt.hlsearch = true        -- Highlight searches
vim.opt.ignorecase = true      -- Ignore case when searching
vim.opt.inccommand = "nosplit" -- preview incremental substitute
vim.opt.incsearch = true       -- Show search matches as you type
vim.opt.smartcase = true       -- Do not ignore case with capitals

-- Split Panes
-- More natural split opening
vim.opt.splitbelow = true -- Put new windows below current
vim.opt.splitkeep = "screen"
vim.opt.splitright = true -- Put new windows right of current

-- ------------------------------------
-- Formatting
-- ------------------------------------

-- vim.opt.formatoptions = "jcroqlnt" -- tcqj
-- do not add comment on cr
-- vim.opt.formatoptions = "jcqlnt" -- tcqj
-- vim.o.formatexpr = "v:lua.require'lazyvim.util'.format.formatexpr()"
