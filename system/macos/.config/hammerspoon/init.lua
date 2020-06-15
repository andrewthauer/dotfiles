--
-- Initialize hammerspoon
--
-- http://www.hammerspoon.org
-- http://www.hammerspoon.org/Spoons/index.html
--

function fileExists(name)
  local f=io.open(name,"r")
  if f~=nil then io.close(f) return true else return false end
end

-- disable window animations
hs.window.animationDuration = 0.0

-- load the spoon install manager
hs.loadSpoon("SpoonInstall")

-- load various modules
require('mouse')
require('window')
require('keybinds')

-- load system specific keybinds (if available)
-- local initDir = os.getenv("HOME") .. "/.dotfiles/local/.config/hammerspoon"
-- local localKeybinds = initDir .. "/local.lua"
-- if hs.fs.displayName(localKeybinds) then
--   dofile(localKeybinds)
-- end

-- load file watcher
require('watcher')

-- notification that config was loaded
hs.alert.show("Config loaded")
-- hs.notify.new({ title="Hammerspoon", informativeText="Config loaded" }):send()
