--
-- Key bindings
--

-- Global hyper key
hyper = { "ctrl", "alt", "cmd", "shift" }

-- Modifier shortcuts
local movekey = { "ctrl", "alt", "cmd" }
local nudgekey = { "ctrl", "alt" }
local yankkey = { "ctrl", "alt", "shift" }
local pushkey = { "ctrl", "cmd" }
local shiftpushkey= { "ctrl", "cmd", "shift" }

-- Window manager
spoon.SpoonInstall:andUse("MiroWindowsManager", {
  hotkeys = {
    up = { movekey, "up" },
    right = { movekey, "right" },
    down = { movekey, "down" },
    left = { movekey, "left" },
    fullscreen = { movekey, "f" }
  }
})

-- Move windows across screens
spoon.SpoonInstall:andUse("WindowScreenLeftAndRight", {
  hotkeys = {
    screen_left = { movekey, "[" },
    screen_right = { movekey, "]" },
  }
})

-- Keybinding cheatsheet for current application
spoon.SpoonInstall:andUse("KSheet", {
  hotkeys = {
    toggle = { hyper, "k" }
    -- show = { hyper, "k" },
    -- hide = { hyper, "k" }
  }
})

-- Center window with some room to see the desktop
hs.hotkey.bind(movekey, "c", function() centerWindow() end)

-- Movement hotkeys
hs.hotkey.bind(nudgekey, 'down', function() nudgeWindow(0, 100) end) 	--down
hs.hotkey.bind(nudgekey, "up", function() nudgeWindow(0, -100) end)	  --up
hs.hotkey.bind(nudgekey, "right", function() nudgeWindow(100, 0) end)	--right
hs.hotkey.bind(nudgekey, "left", function() nudgeWindow(-100, 0) end)	--left

-- Resize hotkeys
hs.hotkey.bind(yankkey, "up", function() yankWindow(0, -100) end)   -- yank bottom up
hs.hotkey.bind(yankkey, "down", function() yankWindow(0, 100) end)  -- yank bottom down
hs.hotkey.bind(yankkey, "right", function() yankWindow(100, 0) end) -- yank right side right
hs.hotkey.bind(yankkey, "left", function() yankWindow(-100, 0) end) -- yank right side left

-- Highlight the mouse pointer
hs.hotkey.bind(hyper, "w", mouseHighlight)

-- Reload config
hs.hotkey.bind(hyper, "r", function() hs.reload() end)

-- Launch or focus certain applications
-- hs.hotkey.bind(hyper, "c", function() hs.application.launchOrFocus("Google Chrome") end)
hs.hotkey.bind(hyper, "d", function() hs.application.launchOrFocus("Dash") end)
hs.hotkey.bind(hyper, "f", function() hs.application.launchOrFocus("Firefox Developer Edition") end)
hs.hotkey.bind(hyper, "j", function() hs.application.launchOrFocus("IntelliJ IDEA") end)
hs.hotkey.bind(hyper, "s", function() hs.application.launchOrFocus("Slack") end)
hs.hotkey.bind(hyper, "t", function() hs.application.launchOrFocus("iTerm") end)
hs.hotkey.bind(hyper, "v", function() hs.application.launchOrFocus("Visual Studio Code") end)

-- Keep the monitor from going to sleep
spoon.SpoonInstall:andUse("Caffeine", {
  start = true,
  hotkeys = {
    toggle = { hyper, "p" }
  }
})
