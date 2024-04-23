-- neovim configuration in lua
-- https://neovim.io/doc/user/lua.html

local Util = require("util")

-- must be loaded before anything else
require("config.options")

-- load any local configuration options
Util.try_require("config.local")

-- bootstrap config & plugins
require("config.lazy")
