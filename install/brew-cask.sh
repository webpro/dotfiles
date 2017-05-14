if ! is-executable brew; then
  echo "Skipping: Homebrew-Cask (not found: brew)"
  return
fi

brew tap caskroom/cask
brew install brew-cask
brew tap caskroom/versions

# Install packages

apps=(
  alfred
  atom
  dash2
  dropbox
  firefox
  firefox-nightly
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
[ -d ~/.hammerspoon ] || ln -sfv "$DOTFILES_DIR/etc/hammerspoon/" ~/.hammerspoon
