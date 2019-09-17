--
-- Key bindings
--

-- Modifier shortcuts
local hyper = { "ctrl", "alt", "cmd", "shift" }
-- local nudgekey = { "ctrl", "alt" }
-- local yankkey = { "ctrl", "alt", "shift" }
-- local pushkey = { "ctrl", "cmd" }
-- local shiftpushkey= { "ctrl", "cmd", "shift" }

-- Window manager
spoon.SpoonInstall:andUse("MiroWindowsManager", {
  hotkeys = {
    up = { hyper, "up" },
    right = { hyper, "right" },
    down = { hyper, "down" },
    left = { hyper, "left" },
    fullscreen = { hyper, "f" }
  }
})

-- Move windows across screens
spoon.SpoonInstall:andUse("WindowScreenLeftAndRight", {
  hotkeys = {
    screen_left = { hyper, "[" },
    screen_right = { hyper, "]" },
  }
})

-- Movement hotkeys
-- hs.hotkey.bind(nudgekey, 'down', function() nudge(0,100) end) 	--down
-- hs.hotkey.bind(nudgekey, "up", function() nudge(0,-100) end)	  --up
-- hs.hotkey.bind(nudgekey, "right", function() nudge(100,0) end)	--right
-- hs.hotkey.bind(nudgekey, "left", function() nudge(-100,0) end)	--left

-- Resize hotkeys
-- hs.hotkey.bind(yankkey, "up", function() yank(0,-100) end)   -- yank bottom up
-- hs.hotkey.bind(yankkey, "down", function() yank(0,100) end)  -- yank bottom down
-- hs.hotkey.bind(yankkey, "right", function() yank(100,0) end) -- yank right side right
-- hs.hotkey.bind(yankkey, "left", function() yank(-100,0) end) -- yank right side left

-- Move a window between monitors
-- hs.hotkey.bind(shiftpushkey, "left", function() hs.window.focusedWindow():moveOneScreenWest() end)
-- hs.hotkey.bind(shiftpushkey, "right", function() hs.window.focusedWindow():moveOneScreenEast() end)
-- hs.hotkey.bind(shiftpushkey, "down", function() hs.window.focusedWindow():moveOneScreenSouth() end)
-- hs.hotkey.bind(shiftpushkey, "up", function() hs.window.focusedWindow():moveOneScreenNorth() end)

-- Center window with some room to see the desktop
-- hs.hotkey.bind(pushkey, "m", function() push(0.05,0.05,0.9,0.9) end)

-- Put Messages.app where I like it
-- hs.hotkey.bind(pushkey, "1", function() push(0.02,0.02,0.4,0.5) end)

-- Reload config
-- hs.hotkey.bind(hyper, "r", function() hs.reload() end)

-- Highlight the mouse pointer
hs.hotkey.bind(hyper, "w", mouseHighlight)

-- Launch or focus certain applications
hs.hotkey.bind(hyper, 'b', function() hs.application.launchOrFocus('Firefox Developer Edition') end)
hs.hotkey.bind(hyper, 'c', function() hs.application.launchOrFocus('Visual Studio Code') end)
hs.hotkey.bind(hyper, 's', function() hs.application.launchOrFocus('Slack') end)
hs.hotkey.bind(hyper, 't', function() hs.application.launchOrFocus('Terminal') end)

--
-- Other
--

-- Help. Lists shortcuts, etc.
-- The terrible spacing looks fine when the alert is actually displayed
-- function showHelp()
--   helpstr = [[  Hyper                     ⌘⌥⌃⇧
--   Nudge                           ⌥⌃
--   Yank                          ⌥⌃⇧
--   Push                              ⌘⌃

--   Find pointer            Hyper-W]]
--   hs.alert.show(helpstr)
-- end

-- hs.hotkey.bind(hyper, "i", function() hs.hints.windowHints() end)
-- hs.hotkey.bind(hyper, "q", showHelp)
