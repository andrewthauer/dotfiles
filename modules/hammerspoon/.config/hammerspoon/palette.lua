--
-- Command Palette
--
---@diagnostic disable: undefined-global

local M = {}

function M.init(keys)
  -- List of emojis
  -- spoon.SpoonInstall:andUse("Emojis", {
  --   hotkeys = {
  --     toggle = { keys.hyper, "e" },
  --   },
  -- })

  -- Seal
  -- https://www.hammerspoon.org/Spoons/Seal.html
  spoon.SpoonInstall:andUse("Seal", {
    hotkeys = {
      show = { keys.hyper, "o" },
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

  -- Commander
  -- https://www.hammerspoon.org/Spoons/Commander.html
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
      hs.hotkey.bind(keys.hyper, "p", function()
        s.show()
      end)
    end,
  })
end

return M
