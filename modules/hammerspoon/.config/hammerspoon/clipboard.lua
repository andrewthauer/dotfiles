--
-- Hammerspoon Clipboard
--
---@diagnostic disable: undefined-global

local M = {}

function M.init(keys)
  -- Clipboard Tools
  spoon.SpoonInstall:andUse("ClipboardTool", {
    config = {
      -- hist_size = 100,
      paste_on_select = true,
      show_copied_alert = false,
      show_in_menubar = false,
    },
    hotkeys = {
      show_clipboard = { keys.hyper, "v" },
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
      toggle_clipboard = { keys.hyper, "u" },
    },
    start = true,
  })
end

return M
