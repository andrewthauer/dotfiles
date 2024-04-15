-- neovim configuration in lua
-- https://neovim.io/doc/user/lua.html

local Util = require("util")

-- must be loaded before anything else
require("config.options")

-- load any local configuration options
if Util.is_mod_available("config.local") then
  require("config.local")
end

-- bootstrap config & plugins
require("config.lazy")
