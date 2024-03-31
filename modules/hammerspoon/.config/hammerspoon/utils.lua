--
-- hammerspoon utils
--

local utils = {}

function utils.fileExists(name)
  local f = io.open(name, "r")
  if f ~= nil then
    io.close(f)
    return true
  else
    return false
  end
end

-- Curried launch by app id
function utils.launchById(id)
  return function()
    hs.application.launchOrFocusByBundleID(id)
  end
end

-- Curried open path in finder
function utils.openWithFinder(path)
  return function()
    os.execute("open " .. path)
    hs.application.launchOrFocus("Finder")
  end
end

return utils
