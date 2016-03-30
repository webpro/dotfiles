mash = {"⌘", "⌥", "⌃"}

require "apps"
require "grid"

hs.hotkey.bind(mash, "r", function() hs.reload(); hs.alert.show('Config reloaded'); end)
