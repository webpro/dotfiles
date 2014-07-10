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
ln -sfhv "$DOTFILES_DIR/etc/hydra" ~/.hydra

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
brew cask install dropbox
brew cask install firefox
brew cask install google-chrome
brew cask install google-chrome-canary
brew cask install google-drive
brew cask install hydra
brew cask install mou
brew cask install opera
# brew cask install skype
# brew cask install sonos
brew cask install sourcetree
brew cask install spotify
brew cask install sublime-text3
# brew cask install things
brew cask install transmit
brew cask install virtualbox
brew cask install vlc
brew cask install webstorm

# https://github.com/sindresorhus/quick-look-plugins
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql webp-quicklook suspicious-package && qlmanage -r

# Update Homebrew, formulae, and packages

brew update
brew upgrade

## Install Ruby gems (SASS, Compass)

function _install-gem() {
    # Unacceptable way to check if sass-globbing was installed (it's not in `gem list`)
    [ -n "$2" ] && CHECK_GEM="$2" || CHECK_GEM="$1"
    type -P "$CHECK_GEM" &>/dev/null && sudo gem update $1 || sudo gem install $1
}

sudo gem update --system
_install-gem "compass"
_install-gem "sass"
_install-gem "sass-globbing" "sass"

# Globally install or update with npm

function _install-npm() {
    type -P $1 &>/dev/null && npm update -g $1 || npm install -g $1
}

_install-npm "bower"
_install-npm "grunt"
_install-npm "gulp"
_install-npm "http-server"
_install-npm "nodemon"
_install-npm "spot"
_install-npm "svgo"

# Custom symlinks

# http://www.sublimetext.com/docs/3/osx_command_line.html
[ -f ~/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl ] && ln -sfhv ~/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl "$DOTFILES_DIR/bin/subl"
