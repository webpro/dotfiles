# Don't display the annoying prompt when quitting iTerm
defaults write com.googlecode.iterm2 PromptOnQuit -bool false

# Set (smaller) font
plistbuddy com.googlecode.iterm2 Set ":'New Bookmarks':0:'Normal Font'" "Monaco 10"
plistbuddy com.googlecode.iterm2 Set ":'New Bookmarks':0:'Non Ascii Font'" "Monaco 10"
plistbuddy com.googlecode.iterm2 Set ":'New Bookmarks':0:'Silence Bell'" 1
