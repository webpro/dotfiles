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
brew tap caskroom/cask
brew install brew-cask
brew tap caskroom/versions

# Install brew & brew-cask packages

brew bundle "$DOTFILES_DIR/Brewfile"
brew bundle "$DOTFILES_DIR/Caskfile"

# Configure bash (installed with brew)

grep "/usr/local/bin/bash" /private/etc/shells &>/dev/null || sudo bash -c "echo /usr/local/bin/bash >> /private/etc/shells"
chsh -s /usr/local/bin/bash

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
