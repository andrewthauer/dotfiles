-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Remap leader key so its easier to reach
vim.g.mapleader = "'"
-- vim.g.maplocalleader = ' '

-- Enable .editorconfig (default is true in nvim)
vim.g.editorconfig = true

-- ------------------------------------
-- Turn Off Swap Files
-- ------------------------------------

vim.opt.swapfile = false
-- vim.cmd [[ set nowritebackup ]]
-- vim.cmd [[ set nowb ]]

-- ------------------------------------
-- Encoding
-- ------------------------------------

-- vim.opt.encoding=utf-8 = true
-- vim.opt.fileencoding=utf-8 = true
-- vim.opt.fileencodings=utf-8 = true
vim.opt.spelllang = { "en" }

-- ------------------------------------
-- UI Config
-- ------------------------------------

vim.opt.confirm = true                 -- Confirm to save changes before exiting modified buffer
vim.opt.cursorline = true              -- Highlight current line
vim.opt.laststatus = 3                 -- global statusline
vim.opt.mouse = "a"                    -- Enable mouse mode
vim.opt.number = true                  -- Print line number
-- vim.opt.pumblend = 10                  -- Popup blend
-- vim.opt.pumheight = 10                 -- Maximum number of entries in a popup
vim.opt.relativenumber = true          -- Relative line numbers are also good
vim.opt.ruler = true                   -- Show row/col number
vim.opt.scrolloff = 4                  -- Lines of context
vim.opt.showcmd = true                 -- Show incomplete cmds down the bottom
vim.opt.showmode = true                -- Show current mode down the bottom
vim.opt.termguicolors = true           -- True color support
vim.opt.visualbell = true              -- No sounds
vim.opt.virtualedit = "block"          -- Allow cursor to move where there is no text in visual block mode
vim.opt.winminwidth = 5                -- Minimum window width

vim.opt.autoread = true                -- Reload files changed outside vim
vim.opt.autowrite = true               -- Automatically write before running commands

-- vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }

-- ------------------------------------
-- Status Line
-- ------------------------------------

-- vim.opt.statuscolumn = [[%!v:lua.require'lazyvim.util'.ui.statuscolumn()]]

-- ------------------------------------
-- Undo/Redo
-- ------------------------------------

vim.opt.undofile = true
vim.opt.undolevels = 10000

-- ------------------------------------
-- Indentation
-- ------------------------------------

-- vim.opt.autoindent = true
vim.opt.expandtab = true               -- Use spaces instead of tabs
vim.opt.shiftround = true              -- Round indent
vim.opt.shiftwidth = 2                 -- Size of an indent
vim.opt.smartindent = true             -- Insert indents automatically
vim.opt.softtabstop = 2                -- How many columns of whitespace for tab keypress/backspace
vim.opt.tabstop = 2                    -- Number of spaces tabs count for

-- ------------------------------------
-- Text Wrapping
-- ------------------------------------

vim.opt.wrap = false                   -- Disable line wrap
-- vim.opt.linebreak = true               -- Wrap lines at convenient points

-- ------------------------------------
-- Folds
-- ------------------------------------

-- vim.opt.foldexpr = "v:lua.require'lazyvim.util'.ui.foldexpr()"
-- vim.opt.foldlevel = 99
-- vim.opt.foldmethod = "expr"
-- vim.opt.foldtext = "v:lua.require'lazyvim.util'.ui.foldtext()"

-- ------------------------------------
-- Completion
-- ------------------------------------

-- vim.opt.wildmenu = true                -- Enable ctrl-n and ctrl-p to scroll thru matches
vim.opt.wildmode = "longest:full,full" -- Wildmenu automcomplete behaviour

-- ------------------------------------
-- Search
-- ------------------------------------

-- vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.grepprg = "rg --vimgrep"
vim.opt.hlsearch = true                -- Highlight searches
vim.opt.ignorecase = true              -- Ignore case when searching
vim.opt.inccommand = "nosplit"         -- preview incremental substitute
vim.opt.incsearch = true               -- Show search matches as you type
vim.opt.smartcase = true               -- Don't ignore case with capitals

-- ------------------------------------
-- Split Panes
-- ------------------------------------

-- More natural split opening
vim.opt.splitbelow = true              -- Put new windows below current
vim.opt.splitkeep = "screen"
vim.opt.splitright = true              -- Put new windows right of current

-- ------------------------------------
-- Formatting
-- ------------------------------------

-- vim.o.formatexpr = "v:lua.require'lazyvim.util'.format.formatexpr()"

-- ------------------------------------
-- File Types
-- ------------------------------------

-- filetype on
-- filetype plugin on
-- filetype indent on

-- augroup filetype_gitcommit
--   autocmd!
--   autocmd FileType gitcommit set textwidth=72  " Word wrap long git messages
-- augroup END

-- augroup filetype_json
--   autocmd!
--   autocmd FileType json syntax match Comment +\/\/.\+$+
-- augroup END

-- augroup filetype_markdown
--   autocmd!
--   autocmd FileType markdown set wrap linebreak
-- augroup END
