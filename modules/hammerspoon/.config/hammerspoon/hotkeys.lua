--
-- hammerspoon hotkeys
--
---@diagnostic disable: undefined-global

local M = {}

local apps = require("apps")

-- Curried launch by app id
local function launchById(id)
  return function()
    hs.application.launchOrFocusByBundleID(id)
  end
end

-- Curried open path in finder
local function openWithFinder(path)
  return function()
    os.execute("open " .. path)
    hs.application.launchOrFocus("Finder")
  end
end

function M.init(keys)
  M.init_hotkeys(keys)
  M.init_recursive_keybinder(keys)
end

function M.init_hotkeys(keys)
  -- stylua: ignore start
  hs.hotkey.bind(keys.hyper, "1", launchById(apps.ONEPASSWORD))
  hs.hotkey.bind(keys.hyper, "b", launchById(apps.BROWSER))
  hs.hotkey.bind(keys.hyper, "c", launchById(apps.EDITOR))
  hs.hotkey.bind(keys.hyper, "d", launchById(apps.TODOIST))
  hs.hotkey.bind(keys.hyper, "f", launchById(apps.FINDER))
  hs.hotkey.bind(keys.hyper, "l", launchById(apps.EDITOR))
  hs.hotkey.bind(keys.hyper, "m", launchById(apps.SLACK))
  hs.hotkey.bind(keys.hyper, "n", launchById(apps.NOTION))
  hs.hotkey.bind(keys.hyper, "t", launchById(apps.TERMINAL))
  -- stylua: ignore end
end

function M.init_recursive_keybinder(keys)
  spoon.SpoonInstall:andUse("RecursiveBinder", {
    config = {},
    fn = function(s)
      local app_keymap = {
        [s.singleKey("1", "1Password")] = launchById(apps.ONEPASSWORD),
        [s.singleKey("c", "Chrome")] = launchById(apps.CHROME),
        [s.singleKey("f", "Firefox")] = launchById(apps.FIREFOX),
        [s.singleKey("h", "Home Assistant")] = launchById(apps.HOME_ASSISTANT),
        [s.singleKey("g", "Ghostty")] = launchById(apps.GHOSTTY),
        [s.singleKey("i", "IDEA")] = launchById(apps.INTELLIJ),
        [s.singleKey("o", "OneNote")] = launchById(apps.ONENOTE),
        [s.singleKey("n", "Notion")] = launchById(apps.NOTION),
        [s.singleKey("s", "Slack")] = launchById(apps.SLACK),
        [s.singleKey("t", "Todoist")] = launchById(apps.TODOIST),
        [s.singleKey("v", "VS Code")] = launchById(apps.VSCODE),
        [s.singleKey("z", "Zed")] = launchById(apps.ZED),
      }
      -- hs.hotkey.bind(hyper, "o", s.recursiveBind(app_keymap))

      local finder_keymap = {
        [s.singleKey("f", "Finder")] = launchById(apps.FINDER),
        [s.singleKey("a", "Applications")] = openWithFinder("~/Applications"),
        [s.singleKey("c", "Code")] = openWithFinder("~/src"),
        [s.singleKey("D", "Desktop")] = openWithFinder("~/Desktop"),
        [s.singleKey("d", "Downloads")] = openWithFinder("~/Downloads"),
        [s.singleKey("h", "Home")] = openWithFinder("~"),
        [s.singleKey("l", "Library")] = openWithFinder("~/Library"),
      }
      -- hs.hotkey.bind(hyper, "f", s.recursiveBind(finder_keymap))

      local keymap = {
        [s.singleKey("a", "apps+")] = app_keymap,
        [s.singleKey("f", "find+")] = finder_keymap,
        [s.singleKey("u", "update spoons")] = function()
          spoon.SpoonInstall:updateAllRepos()
        end,
      }
      hs.hotkey.bind(keys.hyper, "space", s.recursiveBind(keymap))
    end,
  })
end

return M
