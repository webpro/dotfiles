if ! is-macos -o ! is-executable brew; then
  echo "Skipped: Homebrew-Cask"
  return
fi

brew tap caskroom/cask

# Install packages

apps=(
  alfred
  dash2
  dropbox
  firefox
  firefoxnightly
  flux
  glimmerblocker
  google-chrome
  google-chrome-canary
  google-drive
  hammerspoon
  kaleidoscope
  macdown
  opera
  screenflow
  slack
  sourcetree
  spotify
  sublime-text
  transmit
  virtualbox
  vlc
  webstorm
)

brew cask install "${apps[@]}"

# Quick Look Plugins (https://github.com/sindresorhus/quick-look-plugins)
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql qlimagesize webpquicklook suspicious-package

# Link Hammerspoon config
if [ ! -d ~/.hammerspoon ]; then ln -sfv "$DOTFILES_DIR/etc/hammerspoon/" ~/.hammerspoon; fi
