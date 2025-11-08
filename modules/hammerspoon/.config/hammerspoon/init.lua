--
-- hammerspoon config
--
-- http://www.hammerspoon.org
-- http://www.hammerspoon.org/Spoons/index.html
--
---@diagnostic disable: undefined-global

-- Disable window animations
hs.window.animationDuration = 0.1

-- Load the spoon install manager
hs.loadSpoon("SpoonInstall")
spoon.SpoonInstall.use_syncinstall = true

-- Global keys
local keys = {
  hyper = { "ctrl", "alt", "cmd", "shift" }
}

-- Load modules
require("hotkeys").init(keys)
require("clipboard").init(keys)
require("palette").init(keys)
require("tiling").init(keys)

-- Caffeine: Keep the monitor from going to sleep
spoon.SpoonInstall:andUse("Caffeine", {
  hotkeys = {
    toggle = { keys.hyper, "0" },
  },
  start = false,
})

-- Load local config if found
local localfile = hs.configdir .. "/init-local.lua"
if hs.fs.attributes(localfile) then
  dofile(localfile)
end

-- Config Reloading
spoon.SpoonInstall:andUse("ReloadConfiguration", {
  watch_paths = os.getenv("HOME") .. "/.config/hammerspoon/",
  hotkeys = {
    reloadConfiguration = { keys.hyper, "r" },
  },
  start = true,
})

-- Notification that config was loaded
spoon.SpoonInstall:andUse("FadeLogo", {
  config = {
    image_size = hs.geometry.size({ w = 75, h = 75 }),
    run_time = 0.5,
    zoom = false,
  },
  start = true,
})
