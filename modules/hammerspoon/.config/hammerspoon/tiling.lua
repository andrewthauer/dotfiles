-- -- Hammerspoon Tiling Manager
--
---@diagnostic disable: undefined-global

local M = {}

-- Window grid
local windowGrid = { w = 6, h = 4 }

-- local movekey = { "alt", "cmd" }
local movekey = { "ctrl", "alt", "cmd" }

-- PaperWM state
-- local PaperWM
-- local paperWMEnabled = false

-- spoon.SpoonInstall.repos.PaperWM = {
--   url = "https://github.com/mogenson/PaperWM.spoon",
--   desc = "PaperWM.spoon repository",
--   branch = "release",
-- }

-- Temporary window inspector - add this to your init.lua
local function inspectWindows()
  local allWindows = hs.window.allWindows()

  for _, win in ipairs(allWindows) do
    local app = win:application()
    if app then
      local appName = app:name()
      local title = win:title() or ""
      local role = win:role() or ""
      local subrole = win:subrole() or ""
      local frame = win:frame()

      print(string.format([[
Window Info:
  App: %s
  Title: "%s"
  Role: %s
  Subrole: %s
  Size: %.0fx%.0f
  Position: %.0f,%.0f
  ]], appName, title, role, subrole, frame.w, frame.h, frame.x, frame.y))
    end
  end
end

function M.init(keys)
  local hyper = keys.hyper

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
      show_grid = { keys.hyper, "g" },
    },
    start = true,
  })

  -- PaperWM
  -- https://github.com/mogenson/PaperWM.spoon
  -- spoon.SpoonInstall:andUse("PaperWM", {
  --   enabled = false,
  --   repo = "PaperWM",
  --   config = {
  --     screen_margin = 16,
  --     window_gap = 4
  --   },
  --   -- start = true,
  --   hotkeys = {
  --     -- switch to a new focused window in tiled grid
  --     focus_left      = { { "alt", "cmd" }, "left" },
  --     focus_right     = { { "alt", "cmd" }, "right" },
  --     focus_up        = { { "alt", "cmd" }, "up" },
  --     focus_down      = { { "alt", "cmd" }, "down" },

  --     -- switch windows by cycling forward/backward
  --     -- (forward = down or right, backward = up or left)
  --     focus_prev      = { { "alt", "cmd" }, "k" },
  --     focus_next      = { { "alt", "cmd" }, "j" },

  --     -- move windows around in tiled grid
  --     swap_left       = { { "alt", "cmd", "shift" }, "left" },
  --     swap_right      = { { "alt", "cmd", "shift" }, "right" },
  --     swap_up         = { { "alt", "cmd", "shift" }, "up" },
  --     swap_down       = { { "alt", "cmd", "shift" }, "down" },

  --     -- alternative: swap entire columns, rather than
  --     -- individual windows (to be used instead of
  --     -- swap_left / swap_right bindings)
  --     -- swap_column_left = {{"alt", "cmd", "shift"}, "left"},
  --     -- swap_column_right = {{"alt", "cmd", "shift"}, "right"},

  --     -- position and resize focused window
  --     center_window   = { { "alt", "cmd" }, "c" },
  --     -- center_window        = { movekey, "c" },
  --     full_width      = { { "alt", "cmd" }, "f" },
  --     -- full_width           = { movekey, "f" },
  --     cycle_width     = { { "alt", "cmd" }, "r" },
  --     -- cycle_width          = { movekey, "r" },
  --     -- reverse_cycle_width  = { { "ctrl", "alt", "cmd" }, "r" },
  --     -- cycle_height         = { { "alt", "cmd", "shift" }, "r" },
  --     -- reverse_cycle_height = { { "ctrl", "alt", "cmd", "shift" }, "r" },
  --     -- center_window        = { { "alt", "cmd" }, "c" },
  --     -- full_width           = { { "alt", "cmd" }, "f" },
  --     -- cycle_width          = { { "alt", "cmd" }, "r" },
  --     -- reverse_cycle_width  = { { "ctrl", "alt", "cmd" }, "r" },
  --     -- cycle_height         = { { "alt", "cmd", "shift" }, "r" },
  --     -- reverse_cycle_height = { { "ctrl", "alt", "cmd", "shift" }, "r" },

  --     -- increase/decrease width
  --     increase_width  = { { "alt", "cmd" }, "l" },
  --     -- increase_width  = { movekey, "l" },
  --     decrease_width  = { { "alt", "cmd" }, "h" },
  --     -- decrease_width  = { movekey, "h" },

  --     -- move focused window into / out of a column
  --     -- slurp_in             = { { "alt", "cmd" }, "i" },
  --     slurp_in        = { movekey, "i" },
  --     -- barf_out             = { { "alt", "cmd" }, "o" },
  --     barf_out        = { movekey, "o" },

  --     -- move the focused window into / out of the tiling layer
  --     -- toggle_floating      = { { "alt", "cmd", "shift" }, "escape" },
  --     toggle_floating = { movekey, "escape" },

  --     -- focus the first / second / etc window in the current space
  --     -- focus_window_1       = { { "cmd", "shift" }, "1" },
  --     -- focus_window_2       = { { "cmd", "shift" }, "2" },
  --     -- focus_window_3       = { { "cmd", "shift" }, "3" },
  --     -- focus_window_4       = { { "cmd", "shift" }, "4" },
  --     -- focus_window_5       = { { "cmd", "shift" }, "5" },
  --     -- focus_window_6       = { { "cmd", "shift" }, "6" },
  --     -- focus_window_7       = { { "cmd", "shift" }, "7" },
  --     -- focus_window_8       = { { "cmd", "shift" }, "8" },
  --     -- focus_window_9       = { { "cmd", "shift" }, "9" },

  --     -- switch to a new Mission Control space
  --     -- switch_space_l       = { { "alt", "cmd" }, "," },
  --     -- switch_space_r       = { { "alt", "cmd" }, "." },
  --     -- switch_space_1       = { { "alt", "cmd" }, "1" },
  --     -- switch_space_2       = { { "alt", "cmd" }, "2" },
  --     -- switch_space_3       = { { "alt", "cmd" }, "3" },
  --     -- switch_space_4       = { { "alt", "cmd" }, "4" },
  --     -- switch_space_5       = { { "alt", "cmd" }, "5" },
  --     -- switch_space_6       = { { "alt", "cmd" }, "6" },
  --     -- switch_space_7       = { { "alt", "cmd" }, "7" },
  --     -- switch_space_8       = { { "alt", "cmd" }, "8" },
  --     -- switch_space_9       = { { "alt", "cmd" }, "9" },

  --     -- move focused window to a new space and tile
  --     -- move_window_1        = { { "alt", "cmd", "shift" }, "1" },
  --     -- move_window_2        = { { "alt", "cmd", "shift" }, "2" },
  --     -- move_window_3        = { { "alt", "cmd", "shift" }, "3" },
  --     -- move_window_4        = { { "alt", "cmd", "shift" }, "4" },
  --     -- move_window_5        = { { "alt", "cmd", "shift" }, "5" },
  --     -- move_window_6        = { { "alt", "cmd", "shift" }, "6" },
  --     -- move_window_7        = { { "alt", "cmd", "shift" }, "7" },
  --     -- move_window_8        = { { "alt", "cmd", "shift" }, "8" },
  --     -- move_window_9        = { { "alt", "cmd", "shift" }, "9" }
  --   }
  -- })

  -- -- PaperWM = hs.loadSpoon("PaperWM")

  -- -- Do not tile cretain windows
  -- -- PaperWM.window_filter:rejectApp("System Settings")

  -- Bind to a hotkey to inspect windows
  -- hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "i", inspectWindows)
end

return M
