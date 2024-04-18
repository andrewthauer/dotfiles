-- https://wezfurlong.org/wezterm

local wezterm = require("wezterm")
local act = wezterm.action

return {
  -- color_scheme = "zenburned",
  color_scheme = "Catppuccin Frappe",

  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },

  use_fancy_tab_bar = false,

  initial_cols = 160,
  initial_rows = 50,

  font = wezterm.font("Fira Code"),
  font_size = 15.0,

  keys = {
    { key = "LeftArrow", mods = "SHIFT|CMD", action = act.ActivateTabRelative(-1) },
    { key = "RightArrow", mods = "SHIFT|CMD", action = act.ActivateTabRelative(1) },
  },
}
