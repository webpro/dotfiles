# Shortcuts

# Show/hide desktop icons
alias desktopshow="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"
alias desktophide="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"

# Show/hide hidden files in Finder
alias showdotfiles="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hidedotfiles="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# Empty trash on mounted volumes and main HDD, and clear system logs
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"
