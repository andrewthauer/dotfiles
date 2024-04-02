-- neovim configuration in lua
-- https://neovim.io/doc/user/lua.html

local Util = require("util")

-- set colorscheme
-- vim.g.colorscheme = "zenburn"
vim.g.colorscheme = "zenbones"
-- vim.g.zenbones_variant = "zendburned"

-- must be loaded before anything else
require("config.options")
if Util.is_mod_available("config.local") then
  require("config.local")
end

-- bootstrap config & plugins
require("config.lazy")
