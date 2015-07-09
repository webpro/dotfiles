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

-- Push window to the right with 50% width
hotkey.bind({"ctrl", "alt", "cmd"}, "right", function()
  moveTo(0.5, 0, 0.5, 1)
end)

-- Push window at the top with 50% height
hotkey.bind({"ctrl", "alt", "cmd"}, "up", function()
  moveTo(0, 0, 1, 0.5)
end)

-- Push window at the bottom with 50% height
hotkey.bind({"ctrl", "alt", "cmd"}, "down", function()
  moveTo(0, 0.5, 1, 0.5)
end)

-- Push window to the left with 67% width
hotkey.bind({"ctrl", "alt", "cmd"}, "1", function()
    moveTo(0, 0, 0.67, 1)
end)

-- Push window to the left with 33% width
hotkey.bind({"ctrl", "alt", "cmd"}, "2", function()
    moveTo(0, 0, 0.33, 1)
end)

-- Push window to the right with 67% width
hotkey.bind({"ctrl", "alt", "cmd"}, "8", function()
    moveTo(0.33, 0, 0.67, 1)
end)

-- Push window to the right with 33% width
hotkey.bind({"ctrl", "alt", "cmd"}, "9", function()
    moveTo(0.67, 0, 0.33, 1)
end)

-- Push window to the upper left
hotkey.bind({"ctrl", "alt", "cmd"}, "a", function()
    moveTo(0, 0, 0.5, 0.5)
end)

-- Push window to the lower left
hotkey.bind({"ctrl", "alt", "cmd"}, "z", function()
    moveTo(0, 0.5, 0.5, 0.5)
end)

-- Push window to the upper right
hotkey.bind({"ctrl", "alt", "cmd"}, "s", function()
    moveTo(0.5, 0, 0.5, 0.5)
end)

-- Push window to the lower right
hotkey.bind({"ctrl", "alt", "cmd"}, "x", function()
    moveTo(0.5, 0.5, 0.5, 0.5)
end)

-- Push window to the middle
hotkey.bind({"ctrl", "alt", "cmd"}, "c", function()
    moveTo(0.25, 0.15, 0.5, 0.7)
end)

-- Push window full screen to first screen
hotkey.bind({"ctrl", "alt", "cmd"}, "m", function()
  throw(window.focusedwindow(), 1)
end)

-- Push window full screen to second screen
hotkey.bind({"ctrl", "alt", "cmd"}, "n", function()
  throw(window.focusedwindow(), 2)
end)
