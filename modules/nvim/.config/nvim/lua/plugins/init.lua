require("config.options")

return {
  dir = ".",
  priority = 10000,
  init = function()
    require("config.keymaps")
    require("config.autocmds")
  end,
}
