--
-- Key bindings
--

-- hyper key
hyper = { "ctrl", "alt", "cmd", "shift" }
hyper2 = { "ctrl", "alt", "cmd" }

-- window manager
spoon.SpoonInstall:andUse("MiroWindowsManager", {
  hotkeys = {
    up = { hyper2, "up" },
    right = { hyper2, "right" },
    down = { hyper2, "down" },
    left = { hyper2, "left" },
    fullscreen = { hyper2, "f" }
  }
})

-- move windows across screens
spoon.SpoonInstall:andUse("WindowScreenLeftAndRight", {
  hotkeys = {
    screen_left = { hyper2, "[" },
    screen_right = { hyper2, "]" },
  }
})

-- reload on hyper + 0
hs.hotkey.bind(hyper, "r", function()
  hs.reload()
end)

--
-- Application Hotkeys
--

local applicationHotkeys = {
  b = 'Firefox Developer Edition'
}

for key, app in pairs(applicationHotkeys) do
  hs.hotkey.bind(hyper, key, function()
    hs.application.launchOrFocus(app)
    -- hs.application.get(app):unhide()
    -- app = hs.application.get(app)
    -- hs.logger:d(app.)
  end)
end
