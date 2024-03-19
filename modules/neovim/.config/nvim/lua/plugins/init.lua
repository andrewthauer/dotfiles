-- Must be loaded before anything else
require("config.options")

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
