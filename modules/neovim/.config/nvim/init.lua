-- neovim configuration in lua
-- https://neovim.io/doc/user/lua.html

Util = require("util")

-- set colorscheme
-- vim.g.colorscheme = "zenburn"
vim.g.colorscheme = "zenbones"
-- vim.g.zenbones_variant = "zendburned"

-- bootstrap config & plugins
require("config.lazy")
