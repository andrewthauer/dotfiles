-- --------------------------------------
-- Move windows across screens
-- --------------------------------------

hs.hotkey.bind(hyper, "[", function ()
  local win = hs.window.focusedWindow()
  win:moveOneScreenWest()
end)

hs.hotkey.bind(hyper, "]", function ()
  local win = hs.window.focusedWindow()
  win:moveOneScreenEast()
end)
