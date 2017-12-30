if ! is-macos -o ! is-executable brew; then
  echo "Skipped: Homebrew-Cask"
  return
fi

brew tap caskroom/cask
brew tap caskroom/fonts

# Install packages

apps=(
  alfred
  dash2
  dropbox
  firefox
  firefoxnightly
  flux
  font-fira-code
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
  visual-studio-code
  vlc
)

brew cask install "${apps[@]}"

# Quick Look Plugins (https://github.com/sindresorhus/quick-look-plugins)
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql qlimagesize webpquicklook suspicious-package

# Link Hammerspoon config
if [ ! -d ~/.hammerspoon ]; then ln -sfv "$DOTFILES_DIR/etc/hammerspoon/" ~/.hammerspoon; fi
