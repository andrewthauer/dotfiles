--
-- Initialize hammerspoon
--
-- http://www.hammerspoon.org
-- http://www.hammerspoon.org/Spoons/index.html
--

-- disable window animations
hs.window.animationDuration = 0.0

-- load the spoon install manager
hs.loadSpoon("SpoonInstall")

-- load various modules
require('mouse')
require('window')
require('keybinds')
-- require('cheatsheet')
require('watcher')

-- notification that config was loaded
hs.alert.show("Config loaded")
-- hs.notify.new({ title="Hammerspoon", informativeText="Config loaded" }):send()
