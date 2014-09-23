-- Source: https://github.com/octalmind/dotfiles/blob/809cb0c7feb8f4beadd8824e97e4e77fc2f2182d/.mjolnir/init.lua

local application = require "mjolnir.application"
local hotkey = require "mjolnir.hotkey"
local window = require "mjolnir.window"
local fnutils = require "mjolnir.fnutils"
local screens = require "mjolnir.screen"
local geometry = require "mjolnir.geometry"

-- Move the focused window to the specific position
function moveTo(x, y, h, w)
  local win = window.focusedwindow()
  local rect = geometry.rect(x, y, h, w)
  win:movetounit(rect)
end

-- throw a window to the next screen
function throw(win, screen_number)
  local screens_count = # screens.allscreens()
  if screen_number <= screens_count then
    local screen = screens.allscreens()[screen_number]:frame()
    local frame = win:frame()
    frame.x = screen.x
    frame.y = screen.y
    win:setframe(frame)
    win:maximize()
    win:focus()
  end
end

-- Push window to the left with 50% width
hotkey.bind({"ctrl", "alt", "cmd"}, "left", function()
  moveTo(0, 0, 0.5, 1)
end)

-- Push focused window to the right with 50% width
hotkey.bind({"ctrl", "alt", "cmd"}, "right", function()
  moveTo(0.5, 0, 0.5, 1)
end)

-- Push focused window at the top with 50% height
hotkey.bind({"ctrl", "alt", "cmd"}, "up", function()
  moveTo(0, 0, 1, 0.5)
end)

-- Push focused window at the bottom with 50% height
hotkey.bind({"ctrl", "alt", "cmd"}, "down", function()
  moveTo(0, 0.5, 1, 0.5)
end)

-- Push window full screen to first screen
hotkey.bind({"ctrl", "alt", "cmd"}, "m", function()
  throw(window.focusedwindow(), 1)
end)

-- Push window full screen to second screen
hotkey.bind({"ctrl", "alt", "cmd"}, "n", function()
  throw(window.focusedwindow(), 2)
end)
