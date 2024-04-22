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
local window = require("window")

-- Global hyper key
local hyper = { "ctrl", "alt", "cmd", "shift" }

-- Modifier shortcuts
local movekey = { "ctrl", "alt", "cmd" }
local nudgekey = { "ctrl", "shift" }
local yankkey = { "ctrl", "shift", "alt" }

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

-- Cheatsheet for current application
spoon.SpoonInstall:andUse("KSheet", {
	hotkeys = {
		toggle = { hyper, ";" },
	},
})

-- Keep the monitor from going to sleep
spoon.SpoonInstall:andUse("Caffeine", {
	hotkeys = {
		toggle = { hyper, "0" },
	},
	start = false,
})

-- List of emojis
spoon.SpoonInstall:andUse("Emojis", {
	hotkeys = {
		toggle = { hyper, "e" },
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

-- Clipboard history
spoon.SpoonInstall:andUse("TextClipboardHistory", {
	config = {
		-- hist_size = 100,
		show_copied_alert = false,
		show_in_menubar = false,
	},
	hotkeys = {
		toggle_clipboard = { hyper, "u" },
	},
	start = true,
})

-- Reload config
spoon.SpoonInstall:andUse("ReloadConfiguration", {
	watch_paths = os.getenv("HOME") .. "/.config/hammerspoon/",
	hotkeys = {
		reloadConfiguration = { hyper, "r" },
	},
	start = true,
})

-- Center window with some room to see the desktop
-- hs.hotkey.bind(movekey, "c", function()
--   window.centerWindow()
-- end)

-- stylua: ignore start

-- Movement hotkeys
-- hs.hotkey.bind(nudgekey, "down", function() window.nudgeWindow(0, 100) end) --down
-- hs.hotkey.bind(nudgekey, "up", function() window.nudgeWindow(0, -100) end) --up
-- hs.hotkey.bind(nudgekey, "right", function() window.nudgeWindow(100, 0) end) --right
-- hs.hotkey.bind(nudgekey, "left", function() window.nudgeWindow(-100, 0) end) --left

-- Resize hotkeys
-- hs.hotkey.bind(yankkey, "up", function() window.yankWindow(0, -100) end) -- yank bottom up
-- hs.hotkey.bind(yankkey, "down", function() window.yankWindow(0, 100) end) -- yank bottom down
-- hs.hotkey.bind(yankkey, "right", function() window.yankWindow(100, 0) end) -- yank right side right
-- hs.hotkey.bind(yankkey, "left", function() window.yankWindow(-100, 0) end) -- yank right side left

-- Application hotkeys
-- hs.hotkey.bind(hyper, 'space', utils.launchById('com.raycast.macos'))
hs.hotkey.bind(hyper, "1", utils.launchById("com.1password.1password"))
hs.hotkey.bind(hyper, "m", utils.launchById("md.obsidian"))
hs.hotkey.bind(hyper, "c", utils.launchById("com.google.Chrome"))
hs.hotkey.bind(hyper, "d", utils.launchById("com.todoist.mac.Todoist"))
hs.hotkey.bind(hyper, "f", utils.launchById("org.mozilla.firefoxdeveloperedition"))
hs.hotkey.bind(hyper, "h", utils.launchById("io.robbie.HomeAssistant"))
hs.hotkey.bind(hyper, "n", utils.launchById("notion.id"))
hs.hotkey.bind(hyper, "s", utils.launchById("com.tinyspeck.slackmacgap"))
hs.hotkey.bind(hyper, "t", utils.launchById("com.github.wez.wezterm"))
-- hs.hotkey.bind(hyper, "t", utils.launchById("net.kovidgoyal.kitty"))
-- hs.hotkey.bind(hyper, "t", utils.launchById("org.alacritty"))
-- hs.hotkey.bind(hyper, 'v', utils.launchById('com.microsoft.VSCode'))
hs.hotkey.bind(hyper, "w", utils.launchById("com.apple.finder"))
-- hs.hotkey.bind(hyper, "z", utils.launchById("dev.zed.Zed"))

-- stylua: ignore end

-- Recursive hotkeys
spoon.SpoonInstall:andUse("RecursiveBinder", {
	config = {},
	fn = function(s)
		local app_keymap = {
			[s.singleKey("1", "1Password")] = utils.launchById("com.agilebits.onepassword7"),
			[s.singleKey("c", "Chrome")] = utils.launchById("com.google.Chrome"),
			[s.singleKey("d", "Dash")] = utils.launchById("com.kapeli.dashdoc"),
			[s.singleKey("f", "Firefox")] = utils.launchById("org.mozilla.firefoxdeveloperedition"),
			[s.singleKey("i", "IDEA")] = utils.launchById("com.jetbrains.intellij"),
			[s.singleKey("m", "Obsidian")] = utils.launchById("md.obsidian"),
			[s.singleKey("o", "OneNote")] = utils.launchById("com.microsoft.onenote.mac"),
			[s.singleKey("s", "Slack")] = utils.launchById("com.tinyspeck.slackmacgap"),
			[s.singleKey("t", "iTerm")] = utils.launchById("com.googlecode.iterm2"),
			[s.singleKey("v", "VS Code")] = utils.launchById("com.microsoft.VSCode"),
			[s.singleKey("y", "Spotify")] = utils.launchById("com.spotify.client"),
		}
		hs.hotkey.bind(hyper, "o", s.recursiveBind(app_keymap))

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

-- Load system specific keybinds (if available)
-- local initDir = os.getenv("HOME") .. "/.dotfiles/local/.config/hammerspoon"
-- local localKeybinds = initDir .. "/local.lua"
-- if hs.fs.displayName(localKeybinds) then
--   dofile(localKeybinds)
-- end

-- Notification that config was loaded
spoon.SpoonInstall:andUse("FadeLogo", {
	config = {
		image_size = hs.geometry.size({ w = 75, h = 75 }),
		run_time = 0.5,
		zoom = false,
	},
	start = true,
})
