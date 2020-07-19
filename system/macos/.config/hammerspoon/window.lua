-- --------------------------------------------------------
-- Borrowed from https://github.com/exark/dotfiles/tree/master/.hammerspoon
-- --------------------------------------------------------
-- Helper functions - these do all the heavy lifting below.
-- Names are roughly stolen from same functions in Slate :)
-- --------------------------------------------------------

-- Center window
function centerWindow()
  toScreen = nil
  inBounds = true
  hs.window.focusedWindow():centerOnScreen(toScreen, inBounds)
end

-- Move a window a number of pixels in x and y
function nudgeWindow(xpos, ypos)
	local win = hs.window.focusedWindow()
  local f = win:frame()

	f.x = f.x + xpos
	f.y = f.y + ypos
	win:setFrame(f)
end

-- Resize a window by moving the bottom
function yankWindow(xpixels,ypixels)
	local win = hs.window.focusedWindow()
	local f = win:frame()

	f.w = f.w + xpixels
	f.h = f.h + ypixels
	win:setFrame(f)
end

-- Resize window for chunk of screen.
-- For x and y: use 0 to expand fully in that dimension, 0.5 to expand halfway
-- For w and h: use 1 for full, 0.5 for half
function pushWindow(x, y, w, h)
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	f.x = max.x + (max.w*x)
	f.y = max.y + (max.h*y)
	f.w = max.w*w
	f.h = max.h*h
	win:setFrame(f)
end
