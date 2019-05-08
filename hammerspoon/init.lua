hyper = {"ctrl", "alt", "cmd"}
hypershift = {"ctrl", "alt", "cmd", "shift"}

require('watcher')
require('position')
require('screen')

-- turn off animation
hs.window.animationDuration = 0.0

-- Defeating paste blocking
-- hs.hotkey.bind({"cmd", "alt"}, "V", function()
--   hs.eventtap.keyStrokes(hs.pasteboard.getContents())
-- end)
