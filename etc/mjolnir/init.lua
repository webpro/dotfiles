local hotkey = require "mjolnir.hotkey"
local window = require "mjolnir.window"
local grid = require "mjolnir.bg.grid"

grid.GRIDHEIGHT = 3
grid.GRIDWIDTH = 3
grid.MARGINX = 0
grid.MARGINY = 0

--- arrows: move window
hotkey.bind({"ctrl", "alt", "cmd"}, "left", function() grid.pushwindow_left() end)
hotkey.bind({"ctrl", "alt", "cmd"}, "right", function() grid.pushwindow_right() end)
hotkey.bind({"ctrl", "alt", "cmd"}, "up", function() grid.pushwindow_up() end)
hotkey.bind({"ctrl", "alt", "cmd"}, "down", function() grid.pushwindow_down() end)

--- ikjl: resize window
hotkey.bind({"ctrl", "alt", "cmd"}, "i", function() grid.resizewindow_shorter() end)
hotkey.bind({"ctrl", "alt", "cmd"}, "k", function() grid.resizewindow_taller() end)
hotkey.bind({"ctrl", "alt", "cmd"}, "j", function() grid.resizewindow_thinner() end)
hotkey.bind({"ctrl", "alt", "cmd"}, "l", function() grid.resizewindow_wider() end)

--- szxc: resize grid
hotkey.bind({"ctrl", "alt", "cmd"}, "s", function() grid.adjustheight(-1) end)
hotkey.bind({"ctrl", "alt", "cmd"}, "x", function() grid.adjustheight(1) end)
hotkey.bind({"ctrl", "alt", "cmd"}, "z", function() grid.adjustwidth(-1) end)
hotkey.bind({"ctrl", "alt", "cmd"}, "c", function() grid.adjustwidth(1) end)

--- /: move window to next screen
hotkey.bind({"ctrl", "alt", "cmd"}, "/", function() grid.pushwindow_nextscreen() end)

--- ,: snap window to grid
hotkey.bind({"ctrl", "alt", "cmd"}, ",", function() local win = window.focusedwindow(); grid.snap(win) end)

--- m: maximize window
hotkey.bind({"ctrl", "alt", "cmd"}, "m", function() grid.maximize_window() end)
