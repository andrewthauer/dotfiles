-- Must be loaded before anything else
require("config.options")

-- load local options if they exist
local Util = require("util")
if Util.is_module_available("config.local") then
  require("config.local")
end

return {
  -- This plugin loads our base setup before other plugins are loaded
  {
    name = "core-local",
    dir = ".", -- tell lazy this is not a remote plugin
    dev = true,
    priority = 10001, -- load before everything
    lazy = false,
    init = function()
      -- load configuration manually
      require("config.keymaps")
      require("config.autocmds")
    end,
  },
}
