-- -- ------------------------------------
-- -- Globals
-- -- ------------------------------------

-- Remap leader key so its easier to reach
vim.g.mapleader = "'"
-- vim.g.mapleader = ' '
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

-- set encoding=utf-8
-- set fileencoding=utf-8
-- set fileencodings=utf-8

-- ------------------------------------
-- UI Config
-- ------------------------------------

vim.o.syntax = true                        -- Enable syntax highlighting
vim.opt.number = true                      -- Line numbers are good
vim.opt.relativenumber = true               -- Relative line numbers are also good
vim.opt.ruler = true                       -- Show row/col number
vim.opt.showcmd = true                     -- Show incomplete cmds down the bottom
vim.opt.showmode = true                    -- Show current mode down the bottom
vim.opt.cursorline = true                  -- Highlight current line
vim.opt.visualbell = true                  -- No sounds
vim.opt.autoread = true                    -- Reload files changed outside vim
-- vim.wo.number = true                       -- Line numbers "   "
-- vim.opt.showmatch = true                   -- Highlight matching [{()}]
-- vim.opt.cursorcolumn = true                -- Highlight cursor column vertically
-- vim.opt.autowrite = true                   -- Automatically write before running commands
-- vim.opt.backspace = "indent,eol,start"     -- Allow backspace in insert mode
-- vim.opt.lazyredraw = true                  -- Redraw only when we need to

-- search
vim.opt.hlsearch = true                    -- Highlight searches
vim.opt.ignorecase = true                  -- Ignore case when searching
vim.opt.incsearch = true                   -- Show search matches as you type

-- maybe
-- vim.opt.laststatus = 2                     -- ??

-- ------------------------------------
-- Persistent Undo
-- ------------------------------------

-- maybe
-- Keep undo history across sessions, by storing in file
-- if has('persistent_undo') && !isdirectory(expand('~').'/.vim/backups')
--   silent !mkdir ~/.vim/backups > /dev/null 2>&1
--   set undodir=~/.vim/backups
--   set undofile
-- endif

-- ------------------------------------
-- Indentation
-- ------------------------------------

vim.opt.shiftwidth = 2       -- How many columns of whitespace a “level of indentation” is worth.
vim.opt.softtabstop = 2      -- How many columns of whitespace a tab keypress or a backspace keypress is worth
vim.opt.tabstop = 2          -- How many columns of whitespace a \t is worth
vim.opt.expandtab = true     -- Never see a \t in files
vim.opt.autoindent = true
-- vim.opt.smartindent = true
-- vim.opt.smarttab = true

-- Display tabs and trailing spaces visually
-- set list listchars=tab:\ \ ,trail:·

-- ------------------------------------
-- Text Wrapping
-- ------------------------------------

-- set nowrap                      -- Don't wrap lines
-- set linebreak                   -- Wrap lines at convenient points

-- Set color column guide
-- set colorcolumn=120
-- highlight ColorColumn ctermbg=0 guibg=lightgrey

-- ------------------------------------
-- Folds
-- ------------------------------------

-- set foldmethod=syntax            -- fold based on syntax
-- set foldnestmax=3                -- deepest fold is 3 levels
-- set nofoldenable                 -- dont fold by default

-- ------------------------------------
-- Completion
-- ------------------------------------

-- set wildmenu                     -- Enable ctrl-n and ctrl-p to scroll thru matches
-- set wildmode=longest:list,full   -- Wildmenu automcomplete behaviour
-- -- set wildignore=               -- Stuff to ignore when tab completing (e.g. *.jpg,*.png,*.gif,*.pdf,*.pyc)

-- ------------------------------------
-- Scrolling
-- ------------------------------------

-- set scrolloff=8                  -- Start scrolling when we're 8 lines away from margins
-- set sidescrolloff=15
-- set sidescroll=1

-- ------------------------------------
-- Search
-- ------------------------------------

-- set incsearch                    -- Find the next match as we type the search
-- set hlsearch                     -- Highlight searches by default
-- set ignorecase                   -- Ignore case when searching...
-- set smartcase                    -- ...unless we type a capital

-- ------------------------------------
-- Split Panes
-- ------------------------------------

-- " More natural split opening
-- set splitbelow
-- set splitright

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
