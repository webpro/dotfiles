hs.grid.setGrid'3x3'
hs.grid.setMargins("0,0")
hs.window.animationDuration = 0

function getWin()
    return hs.window.focusedWindow()
end

--- arrows: move window
hs.hotkey.bind({"⌃", "⌥", "⌘"}, "left", function() hs.grid.pushWindowLeft() end)
hs.hotkey.bind({"⌃", "⌥", "⌘"}, "right", function() hs.grid.pushWindowRight() end)
hs.hotkey.bind({"⌃", "⌥", "⌘"}, "up", function() hs.grid.pushWindowUp() end)
hs.hotkey.bind({"⌃", "⌥", "⌘"}, "down", function() hs.grid.pushWindowDown() end)

--- ikjl: resize window
hs.hotkey.bind({"⌃", "⌥", "⌘"}, "i", function() hs.grid.resizeWindowShorter() end)
hs.hotkey.bind({"⌃", "⌥", "⌘"}, "k", function() hs.grid.resizeWindowTaller() end)
hs.hotkey.bind({"⌃", "⌥", "⌘"}, "j", function() hs.grid.resizeWindowThinner() end)
hs.hotkey.bind({"⌃", "⌥", "⌘"}, "l", function() hs.grid.resizeWindowWider() end)

--- 234: resize grid
hs.hotkey.bind({"⌃", "⌥", "⌘"}, "2", function() hs.grid.setGrid('2x2') end)
hs.hotkey.bind({"⌃", "⌥", "⌘"}, "3", function() hs.grid.setGrid('3x3') end)
hs.hotkey.bind({"⌃", "⌥", "⌘"}, "4", function() hs.grid.setGrid('4x4') end)

--- /: move window to next screen
hs.hotkey.bind({"⌃", "⌥", "⌘"}, "/", function() local win = getWin(); win:moveToScreen(win:screen():next()) end)

--- ,: snap window to grid
hs.hotkey.bind({"⌃", "⌥", "⌘"}, ",", function() hs.grid.snap(getWin()) end)

--- m: maximize window
hs.hotkey.bind({"⌃", "⌥", "⌘"}, "m", function() hs.grid.maximizeWindow() end)
