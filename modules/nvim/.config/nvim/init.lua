-- neovim configuration in lua
-- https://neovim.io/doc/user/lua.html

Util = require("util")

-- set colorscheme
vim.g.colorscheme = "zenburn"

-- use full lazyvim
vim.g.lazyvim = false -- default
vim.g.lazyvim = Util.str_to_boolean(os.getenv("NVIM_LAZYVIM"), vim.g.lazyvim)

-- bootstrap config & plugins
require("config.lazy")
