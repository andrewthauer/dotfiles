-- neovim configuration in lua
-- https://neovim.io/doc/user/lua.html

Util = require("util")

-- set colorscheme
vim.g.colorscheme = "zenburn"
-- vim.g.colorscheme = "zenburned"
-- vim.g.colorscheme = "catppuccin"

-- bootstrap config & plugins
require("config.lazy")
