mash = {"⌘", "⌥", "⌃"}

require "apps"
require "grid"

hs.hotkey.bind(mash, "r", function() hs.reload(); end)
hs.hotkey.bind(mash, "w", function() hs.eventtap.keyStrokes('¯\\_(ツ)_/¯'); end)
hs.hotkey.bind(mash, "a", function() hs.caffeinate.lockScreen(); end)
hs.alert("Hammerspoon config loaded")
