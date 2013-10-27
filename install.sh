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

ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)" && brew doctor
brew tap phinze/homebrew-cask
brew install brew-cask

# Install Git, Node & npm with brew

brew install git
brew install node

# Install applications with brew-cask

brew cask install alfred
brew cask install dash
brew cask install firefox
brew cask install google-chrome
brew cask install google-chrome-canary
brew cask install opera
brew cask install sourcetree
brew cask install sublime-text-3
brew cask install transmit
brew cask install virtualbox
brew cask install webstorm

# Update Homebrew, formulae, and packages

brew update
brew upgrade

# Globally install with npm if not done yet (bower, grunt, http-server)

type -P bower &>/dev/null || ( ask "npm install -g bower" Y && npm install -g bower )
type -P grunt &>/dev/null || ( ask "npm install -g grunt-cli" Y && npm install -g grunt-cli )
type -P http-server &>/dev/null || ( ask "npm install -g http-server" Y && npm install -g http-server )

# Install hub for git

curl https://hub.github.com/standalone -Lo "$DOTFILES_DIR/bin/hub" && chmod +x "$DOTFILES_DIR/bin/hub"

# Custom symlinks

mkdir -p ~/Projects && ln -sfhv ~/Projects ~/p
[ -f "~/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" ] && ln -sfhv "~/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" "$DOTFILES_DIR/bin/subl"
