#!/bin/sh

# Install Homebrew & brew-cask

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap caskroom/cask
brew install brew-cask
brew tap homebrew/versions
brew tap caskroom/versions

# Install brew & brew-cask packages

source "$DOTFILES_DIR/install/brew.sh"
source "$DOTFILES_DIR/install/brew-cask.sh"

# Install bash (with Homebrew)

source "$DOTFILES_DIR/install/bash.sh"

# Install Ruby gems (SASS, Compass)

sudo gem install compass
sudo gem install lunchy
sudo gem install pygmentize
sudo gem install sass
sudo gem install sass-globbing

# Globally install with npm

npm install -g bower
npm install -g grunt
npm install -g gulp
npm install -g http-server
npm install -g nodemon
npm install -g tldr
npm install -g spot
npm install -g svgo
npm install -g vtop

# http://www.sublimetext.com/docs/3/osx_command_line.html
[ -f ~/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl ] && ln -sfv ~/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl "$DOTFILES_DIR/bin/subl"
