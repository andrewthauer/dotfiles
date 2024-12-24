--
-- hammerspoon config
--
-- http://www.hammerspoon.org
-- http://www.hammerspoon.org/Spoons/index.html
--

-- Disable window animations
hs.window.animationDuration = 0.0

-- Load the spoon install manager
hs.loadSpoon("SpoonInstall")
spoon.SpoonInstall.use_syncinstall = true

-- Load require modules
local utils = require("utils")

-- Global hyper key
local hyper = { "ctrl", "alt", "cmd", "shift" }

-------------------------------------------------------------------------------
-- Window Layouts
-------------------------------------------------------------------------------

-- Modifier shortcuts
local movekey = { "ctrl", "alt", "cmd" }

-- Window grid
local windowGrid = { w = 6, h = 4 }

-- Window manager
spoon.SpoonInstall:andUse("MiroWindowsManager", {
  -- disable = true,
  config = {
    GRID = windowGrid,
  },
  hotkeys = {
    up = { movekey, "up" },
    right = { movekey, "right" },
    down = { movekey, "down" },
    left = { movekey, "left" },
    fullscreen = { movekey, "f" },
  },
})

-- Move windows across screens
spoon.SpoonInstall:andUse("WindowScreenLeftAndRight", {
  config = {
    animationDuration = 0.0,
  },
  hotkeys = {
    screen_left = { movekey, "[" },
    screen_right = { movekey, "]" },
  },
})

-- Create a window grid
spoon.SpoonInstall:andUse("WindowGrid", {
  config = {
    gridGeometries = {
      { windowGrid.w .. "x" .. windowGrid.h },
    },
  },
  hotkeys = {
    show_grid = { hyper, "g" },
  },
  start = true,
})

--
-- Window Resizing/Moving
--
-- local nudgekey = { "ctrl", "shift" }
-- local yankkey = { "ctrl", "shift", "alt" }
--
-- require("window")
--
-- -- Center window with some room to see the desktop
-- hs.hotkey.bind(movekey, "c", function()
--   window.centerWindow()
-- end)
--
-- -- Movement hotkeys
-- -- stylua: ignore start
-- hs.hotkey.bind(nudgekey, "down", function() window.nudgeWindow(0, 100) end) --down
-- hs.hotkey.bind(nudgekey, "up", function() window.nudgeWindow(0, -100) end) --up
-- hs.hotkey.bind(nudgekey, "right", function() window.nudgeWindow(100, 0) end) --right
-- hs.hotkey.bind(nudgekey, "left", function() window.nudgeWindow(-100, 0) end) --left
-- -- stylua: ignore end
--
-- -- Resize hotkeys
-- -- stylua: ignore start
-- hs.hotkey.bind(yankkey, "up", function() window.yankWindow(0, -100) end) -- yank bottom up
-- hs.hotkey.bind(yankkey, "down", function() window.yankWindow(0, 100) end) -- yank bottom down
-- hs.hotkey.bind(yankkey, "right", function() window.yankWindow(100, 0) end) -- yank right side right
-- hs.hotkey.bind(yankkey, "left", function() window.yankWindow(-100, 0) end) -- yank right side left
-- -- stylua: ignore end

-------------------------------------------------------------------------------
-- Clipboard
-------------------------------------------------------------------------------

-- Clipboard Tools
spoon.SpoonInstall:andUse("ClipboardTool", {
  config = {
    -- hist_size = 100,
    paste_on_select = true,
    show_copied_alert = false,
    show_in_menubar = false,
  },
  hotkeys = {
    show_clipboard = { hyper, "v" },
  },
  start = true,
})

-- Clipboard history
spoon.SpoonInstall:andUse("TextClipboardHistory", {
  config = {
    -- hist_size = 100,
    paste_on_select = true,
    show_copied_alert = false,
    show_in_menubar = false,
  },
  hotkeys = {
    toggle_clipboard = { hyper, "u" },
  },
  start = true,
})

-------------------------------------------------------------------------------
-- Emojis
-------------------------------------------------------------------------------

-- List of emojis
spoon.SpoonInstall:andUse("Emojis", {
  hotkeys = {
    toggle = { hyper, "e" },
  },
})

-------------------------------------------------------------------------------
-- Caffeine
-------------------------------------------------------------------------------

-- Keep the monitor from going to sleep
spoon.SpoonInstall:andUse("Caffeine", {
  hotkeys = {
    toggle = { hyper, "0" },
  },
  start = false,
})

-------------------------------------------------------------------------------
-- Command Palette
-------------------------------------------------------------------------------

-- Commander (palette)
spoon.SpoonInstall:andUse("Commander", {
  config = {
    commandTable = {
      hello = function()
        hs.alert.show("Hello!")
      end,
      hammerspoonConsole = function()
        hs.toggleConsole()
      end,
      toggleHiddenFiles = function()
        hs.eventtap.keyStroke({ "cmd", "shift" }, ".")
      end,
      pasteUnblocker = function()
        hs.eventtap.keyStrokes(hs.pasteboard.getContents())
      end,
    },
  },
  fn = function(s)
    hs.hotkey.bind(hyper, "p", function()
      s.show()
    end)
  end,
})

-------------------------------------------------------------------------------
-- Fuzzy Finder
-------------------------------------------------------------------------------

-- Seal
spoon.SpoonInstall:andUse("Seal", {
  hotkeys = {
    show = { hyper, "o" },
  },
  fn = function(s)
    s:loadPlugins({
      "apps",
      "calc",
      -- "safari_bookmarks",
      "screencapture",
      "urlformats",
      "useractions",
    })
    -- s.plugins.safari_bookmarks.always_open_with_safari = false
    s.plugins.urlformats.providersTable({
      gh = { name = "GitHub", url = "https://github.com/%s" },
    })
    s.plugins.useractions.actions = {
      ["Hammerspoon Docs"] = {
        url = "http://hammerspoon.org/docs/",
        icon = hs.image.imageFromName(hs.image.systemImageNames.ApplicationIcon),
      },
    }
    s:refreshAllCommands()
  end,
  start = true,
})

-------------------------------------------------------------------------------
-- Application hot keys
-------------------------------------------------------------------------------

-- stylua: ignore start
hs.hotkey.bind(hyper, "1", utils.launchById("com.1password.1password"))
hs.hotkey.bind(hyper, "m", utils.launchById("md.obsidian"))
hs.hotkey.bind(hyper, "c", utils.launchById("com.google.Chrome"))
hs.hotkey.bind(hyper, "d", utils.launchById("com.todoist.mac.Todoist"))
hs.hotkey.bind(hyper, "f", utils.launchById("org.mozilla.firefoxdeveloperedition"))
hs.hotkey.bind(hyper, "h", utils.launchById("io.robbie.HomeAssistant"))
hs.hotkey.bind(hyper, "n", utils.launchById("notion.id"))
hs.hotkey.bind(hyper, "s", utils.launchById("com.tinyspeck.slackmacgap"))
hs.hotkey.bind(hyper, "t", utils.launchById("com.mitchellh.ghostty"))
hs.hotkey.bind(hyper, "w", utils.launchById("com.apple.finder"))
hs.hotkey.bind(hyper, "l", utils.launchById("dev.zed.Zed"))
-- stylua: ignore end

-------------------------------------------------------------------------------
-- Recursive key binder
-------------------------------------------------------------------------------

spoon.SpoonInstall:andUse("RecursiveBinder", {
  config = {},
  fn = function(s)
    local app_keymap = {
      [s.singleKey("1", "1Password")] = utils.launchById("com.agilebits.onepassword7"),
      [s.singleKey("c", "Chrome")] = utils.launchById("com.google.Chrome"),
      [s.singleKey("f", "Firefox")] = utils.launchById("org.mozilla.firefoxdeveloperedition"),
      [s.singleKey("i", "IDEA")] = utils.launchById("com.jetbrains.intellij"),
      [s.singleKey("m", "Obsidian")] = utils.launchById("md.obsidian"),
      [s.singleKey("o", "OneNote")] = utils.launchById("com.microsoft.onenote.mac"),
      [s.singleKey("s", "Slack")] = utils.launchById("com.tinyspeck.slackmacgap"),
      [s.singleKey("t", "Terminal")] = utils.launchById("com.mitchellh.ghostty"),
      [s.singleKey("v", "VS Code")] = utils.launchById("com.microsoft.VSCode"),
    }
    -- hs.hotkey.bind(hyper, "o", s.recursiveBind(app_keymap))

    local finder_keymap = {
      [s.singleKey("f", "Finder")] = utils.launchById("com.apple.finder"),
      [s.singleKey("a", "Applications")] = utils.openWithFinder("~/Applications"),
      [s.singleKey("c", "Code")] = utils.openWithFinder("~/src"),
      [s.singleKey("D", "Desktop")] = utils.openWithFinder("~/Desktop"),
      [s.singleKey("d", "Downloads")] = utils.openWithFinder("~/Downloads"),
      [s.singleKey("h", "Home")] = utils.openWithFinder("~"),
      [s.singleKey("l", "Library")] = utils.openWithFinder("~/Library"),
    }
    -- hs.hotkey.bind(hyper, "f", s.recursiveBind(finder_keymap))

    local keymap = {
      [s.singleKey("a", "apps+")] = app_keymap,
      [s.singleKey("f", "find+")] = finder_keymap,
      [s.singleKey("u", "update spoons")] = function()
        spoon.SpoonInstall:updateAllRepos()
      end,
    }
    hs.hotkey.bind(hyper, "space", s.recursiveBind(keymap))
  end,
})

-------------------------------------------------------------------------------
-- Local machine configuration
-------------------------------------------------------------------------------

-- Load local config if found
local localfile = hs.configdir .. "/init-local.lua"
if hs.fs.attributes(localfile) then
  dofile(localfile)
end

-------------------------------------------------------------------------------
-- Config Reloading
-------------------------------------------------------------------------------

spoon.SpoonInstall:andUse("ReloadConfiguration", {
  watch_paths = os.getenv("HOME") .. "/.config/hammerspoon/",
  hotkeys = {
    reloadConfiguration = { hyper, "r" },
  },
  start = true,
})

-------------------------------------------------------------------------------
-- Config loading logo
-------------------------------------------------------------------------------

-- Notification that config was loaded
spoon.SpoonInstall:andUse("FadeLogo", {
  config = {
    image_size = hs.geometry.size({ w = 75, h = 75 }),
    run_time = 0.5,
    zoom = false,
  },
  start = true,
})
