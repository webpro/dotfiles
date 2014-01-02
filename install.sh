#!/bin/sh

# Get current dir (so run this script from anywhere)

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Update dotfiles itself first

git --work-tree="$DOTFILES_DIR" --git-dir="$DOTFILES_DIR/.git" pull origin master

# Bunch of symlinks

ln -sfhv "$DOTFILES_DIR/runcom/.bash_profile" ~
ln -sfhv "$DOTFILES_DIR/runcom/.inputrc" ~
ln -sfhv "$DOTFILES_DIR/git/.gitconfig" ~
ln -sfhv "$DOTFILES_DIR/git/.gitignore_global" ~

# "Confirm" function

function ask { while true; do read -p "$1 [Y/n] " REPLY; if [ -z "$REPLY" ]; then REPLY=Y; fi; case "$REPLY" in Y*|y*) return 0;; N*|n*) return 1;; esac; done }

# Install Homebrew & brew-cask

ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
brew doctor
brew tap phinze/homebrew-cask
brew install brew-cask
brew tap caskroom/versions

# Install Git, Node & npm with brew

brew install git
brew install node
brew install tree
brew install wget
brew install hub

# Install applications with brew-cask

brew cask install alfred
brew cask install dash
brew cask install divvy
brew cask install dropbox
brew cask install firefox
brew cask install google-chrome
brew cask install google-chrome-canary
brew cask install google-drive
brew cask install mou
brew cask install opera
brew cask install sourcetree
brew cask install spotify
brew cask install sublime-text3
brew cask install transmit
brew cask install virtualbox
brew cask install webstorm

# https://github.com/sindresorhus/quick-look-plugins
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql webp-quicklook suspicious-package && qlmanage -r

# Update Homebrew, formulae, and packages

brew update
brew upgrade

# Globally install with npm if not done yet (bower, grunt, http-server)

type -P bower &>/dev/null || ( ask "npm install -g bower" Y && npm install -g bower )
type -P grunt &>/dev/null || ( ask "npm install -g grunt-cli" Y && npm install -g grunt-cli )
type -P http-server &>/dev/null || ( ask "npm install -g http-server" Y && npm install -g http-server )
type -P nodemon &>/dev/null || ( ask "npm install -g nodemon" Y && npm install -g nodemon )

# Custom symlinks

# http://www.sublimetext.com/docs/3/osx_command_line.html
[ -f ~/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl ] && ln -sfhv ~/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl "$DOTFILES_DIR/bin/subl"

# Divvy prefs/shortcuts
cp "$DOTFILES_DIR/etc/com.mizage.direct.Divvy.plist" ~/Library/Preferences
