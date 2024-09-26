-- https://wezfurlong.org/wezterm

local wezterm = require("wezterm")
local act = wezterm.action

local process_icons = {
  ["bash"] = wezterm.nerdfonts.cod_terminal_bash,
  ["cargo"] = wezterm.nerdfonts.dev_rust,
  ["curl"] = wezterm.nerdfonts.mdi_flattr,
  ["docker"] = wezterm.nerdfonts.linux_docker,
  ["docker-compose"] = wezterm.nerdfonts.linux_docker,
  ["gh"] = wezterm.nerdfonts.dev_github_badge,
  ["git"] = wezterm.nerdfonts.dev_git,
  ["go"] = wezterm.nerdfonts.seti_go,
  ["htop"] = wezterm.nerdfonts.mdi_chart_donut_variant,
  ["kubectl"] = wezterm.nerdfonts.linux_docker,
  ["lazydocker"] = wezterm.nerdfonts.linux_docker,
  ["lua"] = wezterm.nerdfonts.seti_lua,
  ["make"] = wezterm.nerdfonts.seti_makefile,
  ["node"] = wezterm.nerdfonts.mdi_hexagon,
  ["nvim"] = wezterm.nerdfonts.custom_vim,
  ["psql"] = "󱤢",
  ["python3"] = "",
  ["ruby"] = wezterm.nerdfonts.cod_ruby,
  ["ssh"] = wezterm.nerdfonts.fa_exchange,
  ["ssh-add"] = wezterm.nerdfonts.fa_exchange,
  ["sudo"] = wezterm.nerdfonts.fa_hashtag,
  ["vim"] = wezterm.nerdfonts.dev_vim,
  ["wget"] = wezterm.nerdfonts.mdi_arrow_down_box,
  ["zsh"] = wezterm.nerdfonts.dev_terminal,
}

local function get_current_working_dir(tab)
  local current_dir = tab.active_pane and tab.active_pane.current_working_dir or { file_path = "" }
  local HOME_DIR = os.getenv("HOME")

  return current_dir.file_path == HOME_DIR and "~" or string.gsub(current_dir.file_path, "(.*[/\\])(.*)", "%2")
end

local function get_process(tab)
  if not tab.active_pane or tab.active_pane.foreground_process_name == "" then
    return nil
  end

  local process_name = string.gsub(tab.active_pane.foreground_process_name, "(.*[/\\])(.*)", "%2")
  if string.find(process_name, "kubectl") then
    process_name = "kubectl"
  end

  return process_icons[process_name] or string.format("[%s]", process_name)
end

-- From https://github.com/protiumx/.dotfiles/blob/main/stow/wezterm/.config/wezterm/wezterm.lua
---@diagnostic disable-next-line: unused-local
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local has_unseen_output = false
  if not tab.is_active then
    for _, pane in ipairs(tab.panes) do
      if pane.has_unseen_output then
        has_unseen_output = true
        break
      end
    end
  end

  local cwd = wezterm.format({
    { Text = get_current_working_dir(tab) },
  })

  local process = get_process(tab)
  local title = process and string.format(" %s %s ", process, cwd) or " [?] "

  if has_unseen_output then
    return {
      { Foreground = { Color = "#28719c" } },
      { Text = title },
    }
  end

  return {
    { Text = title },
  }
end)

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
  tab_max_width = 24,

  initial_cols = 160,
  initial_rows = 50,

  font = wezterm.font("Fira Code"),
  font_size = 15.0,

  keys = {
    { key = "PageUp", mods = "SHIFT", action = act.ScrollByPage(-1) },
    { key = "PageDown", mods = "SHIFT", action = act.ScrollByPage(1) },
    { key = "LeftArrow", mods = "SHIFT|CMD", action = act.ActivateTabRelative(-1) },
    { key = "RightArrow", mods = "SHIFT|CMD", action = act.ActivateTabRelative(1) },
    { key = "LeftArrow", mods = "SHIFT|OPT", action = act.MoveTabRelative(-1) },
    { key = "RightArrow", mods = "SHIFT|OPT", action = act.MoveTabRelative(1) },
  },
}
