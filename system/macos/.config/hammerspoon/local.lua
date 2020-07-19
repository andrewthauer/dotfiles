-- --------------------------------------------------------
-- Helper utilities
-- --------------------------------------------------------

function fileExists(name)
  local f=io.open(name,"r")
  if f~=nil then io.close(f) return true else return false end
end

-- load system specific keybinds (if available)
-- local initDir = os.getenv("HOME") .. "/.dotfiles/local/.config/hammerspoon"
-- local localKeybinds = initDir .. "/local.lua"
-- if hs.fs.displayName(localKeybinds) then
--   dofile(localKeybinds)
-- end
