--
-- hammerspoon config
--
-- http://www.hammerspoon.org
-- http://www.hammerspoon.org/Spoons/index.html
--

-- Disable window animations
hs.window.animationDuration = 0.0

-- Load the spoon install manager
hs.loadSpoon('SpoonInstall')
spoon.SpoonInstall.use_syncinstall = true

-- Load require modules
require('window')
local window = require 'hs.window'

-- Global hyper key
local hyper = { 'ctrl', 'alt', 'cmd', 'shift' }
local ctrl_cmd = {'ctrl', 'cmd' }

-- Modifier shortcuts
local movekey = { 'ctrl', 'alt', 'cmd' }
local nudgekey = { 'ctrl', 'alt' }
local yankkey = { 'ctrl', 'shift' }

-- Window grid
local windowGrid = { w = 6, h = 4 }

-- Window manager
spoon.SpoonInstall:andUse('MiroWindowsManager', {
  -- disable = true,
  config = {
    GRID = windowGrid,
  },
  hotkeys = {
    up = { movekey, 'up' },
    right = { movekey, 'right' },
    down = { movekey, 'down' },
    left = { movekey, 'left' },
    fullscreen = { movekey, 'f' },
  },
})

-- Create a window grid
spoon.SpoonInstall:andUse('WindowGrid', {
  config = {
    gridGeometries = {
      { windowGrid.w ..'x' .. windowGrid.h },
    },
  },
  hotkeys = {
    show_grid = { hyper, 'g' },
  },
  start = true,
})

-- Move windows across screens
spoon.SpoonInstall:andUse('WindowScreenLeftAndRight', {
  config = {
    animationDuration = 0.0,
  },
  hotkeys = {
    screen_left = { movekey, '[' },
    screen_right = { movekey, ']' },
  },
})

spoon.SpoonInstall:andUse('ToggleScreenRotation', {
  hotkeys = {
    first = { hyper, 'f15' },
  },
})

-- Clipboard history
spoon.SpoonInstall:andUse('TextClipboardHistory', {
  config = {
    -- hist_size = 100,
    show_copied_alert = false,
    show_in_menubar = true,
  },
  hotkeys = {
    toggle_clipboard = { ctrl_cmd, 'v' },
  },
  start = true,
})

-- Cheatsheet for current application
spoon.SpoonInstall:andUse('KSheet', {
  hotkeys = {
    toggle = { hyper, ';' },
  },
})

spoon.SpoonInstall:andUse('DismissNotifications', {
  hotkeys = {
    all = { hyper, "'" },
  },
})

-- Mouse circle cheatsheet for current application
spoon.SpoonInstall:andUse('MouseCircle', {
  disable = true,
  hotkeys = {
    show = { hyper, 'm' },
  },
})

-- Colour picker
spoon.SpoonInstall:andUse('ColorPicker', {
  disable = true,
  config = {
    show_in_menubar = false,
  },
  hotkeys = {
    show = { hyper, 'z' },
  },
  start = true,
})

-- Reload config
spoon.SpoonInstall:andUse('ReloadConfiguration', {
  watch_paths = os.getenv('HOME') .. '/.config/hammerspoon/',
  hotkeys = {
    reloadConfiguration = { hyper, 'r' },
  },
  start = true,
})

-- Keep the monitor from going to sleep
spoon.SpoonInstall:andUse('Caffeine', {
  hotkeys = {
    toggle = { hyper, '0' },
  },
  start = true,
})

-- Calendar and clokc
spoon.SpoonInstall:andUse('CircleClock', { disable = true })
spoon.SpoonInstall:andUse('HCalendar', { disable = false })

-- Count down timer
spoon.SpoonInstall:andUse('CountDown')

-- Curried launch by app id
launchById = function(id)
  return function()
    hs.application.launchOrFocusByBundleID(id)
  end
end

-- Curried open path in finder
openWithFinder = function(path)
  return function()
    os.execute('open '..path)
    hs.application.launchOrFocus('Finder')
  end
end

-- Application hotkeys
hs.hotkey.bind(hyper, '1', launchById('com.agilebits.onepassword7'))
hs.hotkey.bind(hyper, 'c', launchById('com.microsoft.VSCode'))
hs.hotkey.bind(hyper, 'd', launchById('com.kapeli.dashdoc'))
hs.hotkey.bind(hyper, 'f', launchById('org.mozilla.firefoxdeveloperedition'))
hs.hotkey.bind(hyper, 's', launchById('com.tinyspeck.slackmacgap'))
hs.hotkey.bind(hyper, 't', launchById('com.googlecode.iterm2'))

-- Center window with some room to see the desktop
hs.hotkey.bind(movekey, 'c', function() centerWindow() end)

-- Movement hotkeys
hs.hotkey.bind(nudgekey, 'down', function() nudgeWindow(0, 100) end) 	--down
hs.hotkey.bind(nudgekey, 'up', function() nudgeWindow(0, -100) end)	  --up
hs.hotkey.bind(nudgekey, 'right', function() nudgeWindow(100, 0) end)	--right
hs.hotkey.bind(nudgekey, 'left', function() nudgeWindow(-100, 0) end)	--left

-- Resize hotkeys
hs.hotkey.bind(yankkey, 'up', function() yankWindow(0, -100) end)   -- yank bottom up
hs.hotkey.bind(yankkey, 'down', function() yankWindow(0, 100) end)  -- yank bottom down
hs.hotkey.bind(yankkey, 'right', function() yankWindow(100, 0) end) -- yank right side right
hs.hotkey.bind(yankkey, 'left', function() yankWindow(-100, 0) end) -- yank right side left

-- Recursive hotkeys
spoon.SpoonInstall:andUse('RecursiveBinder', {
  config = {},
  fn = function(s)
    app_keymap = {
      [s.singleKey('1', '1Password')] = launchById('com.agilebits.onepassword7'),
      [s.singleKey('c', 'VS Code')] = launchById('com.microsoft.VSCode'),
      [s.singleKey('d', 'Dash')] = launchById('com.kapeli.dashdoc'),
      [s.singleKey('f', 'Firefox')] = launchById('org.mozilla.firefoxdeveloperedition'),
      [s.singleKey('i', 'IDEA')] = launchById('com.jetbrains.intellij'),
      [s.singleKey('o', 'OneNote')] = launchById('com.microsoft.onenote.mac'),
      [s.singleKey('p', 'Postman')] = launchById('com.postmanlabs.mac'),
      [s.singleKey('s', 'Slack')] = launchById('com.tinyspeck.slackmacgap'),
      [s.singleKey('t', 'iTerm')] = launchById('com.googlecode.iterm2'),
      [s.singleKey('y', 'Spotify')] = launchById('com.spotify.client'),
    }
    hs.hotkey.bind(hyper, 'o', s.recursiveBind(app_keymap))

    resize_keymap = {}
    hs.hotkey.bind('alt', 'r', s.recursiveBind(resize_keymap))

    bookmarks_keymap = {}
    hs.hotkey.bind('alt', 'b', s.recursiveBind(bookmarks_keymap))

    finder_keymap = {
      [s.singleKey('a', 'Applications')] = openWithFinder('~/Applications'),
      [s.singleKey('c', 'Code')] = openWithFinder('~/Code'),
      [s.singleKey('D', 'Desktop')] = openWithFinder('~/Desktop'),
      [s.singleKey('d', 'Downloads')] = openWithFinder('~/Downloads'),
      [s.singleKey('h', 'Home')] = openWithFinder('~'),
      [s.singleKey('l', 'Library')] = openWithFinder('~/Library'),
    }
    hs.hotkey.bind('alt', 'f', s.recursiveBind(finder_keymap))

    keymap = {
      [s.singleKey('a', 'apps+')] = app_keymap,
      [s.singleKey('b', 'bookmarks+')] = bookmarks_keymap,
      [s.singleKey('f', 'find+')] = finder_keymap,
      [s.singleKey('r', 'resize+')] = resize_keymap,
    }
    hs.hotkey.bind(hyper, 'space', s.recursiveBind(keymap))
  end
})

-- Commander (palette)
spoon.SpoonInstall:andUse('Commander', {
  config = {
    commandTable = {
      hello = function() hs.alert.show('Hello!') end,
      hammerspoonConsole = function() hs.toggleConsole() end,
      spotifySong = function() hs.spotify.displayCurrentTrack() end,
      toggleHiddenFiles = function() hs.eventtap.keyStroke({'cmd', 'shift'}, '.') end,
      pasteUnblocker = function() hs.eventtap.keyStrokes(hs.pasteboard.getContents()) end,
    },
  },
  fn = function(s)
    hs.hotkey.bind(hyper, 'p', function() s.show() end)
  end
})

-- Tunnelblick
-- spoon.SpoonInstall:andUse('Tunnelblick', {
--   config = {
--   }
-- })

-- Notification that config was loaded
spoon.SpoonInstall:andUse('FadeLogo', {
  config = {
    image_size = hs.geometry.size({w=75, h=75}),
    run_time = 0.5,
    zoom = false
  },
  start = true
})
