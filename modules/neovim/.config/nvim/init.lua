-- neovim configuration in lua
-- https://neovim.io/doc/user/lua.html

Util = require("util")

-- set colorscheme
vim.g.colorscheme = "zenburn"

-- bootstrap config & plugins
require("config.lazy")
