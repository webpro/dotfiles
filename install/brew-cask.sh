apps=(
    alfred
    atom
    cornerstone
    dash
    dropbox
    firefox
    firefox-nightly
    flux
    glimmerblocker
    google-chrome
    google-chrome-canary
    google-drive
    hiarcs-chess-explorer
    iterm2
    kaleidoscope
    mou
    opera
    screenflow
    sonos
    sourcetree
    spotify
    sublime-text3
    transmit
    virtualbox
    vlc
    webstorm
)

brew cask install "${apps[@]}"

# Quick Look Plugins (https://github.com/sindresorhus/quick-look-plugins)
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql webp-quicklook suspicious-package && qlmanage -r
