-- https://wezfurlong.org

local wezterm = require("wezterm")
local act = wezterm.action

return {
  color_scheme = "zenburned",

  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },

  use_fancy_tab_bar = true,

  initial_cols = 160,
  initial_rows = 60,

  font = wezterm.font("Fira Code"),
  font_size = 15.0,

  keys = {
    { key = "LeftArrow", mods = "SHIFT|CMD", action = act.MoveTabRelative(-1) },
    { key = "RightArrow", mods = "SHIFT|CMD", action = act.MoveTabRelative(1) },
  },
}
