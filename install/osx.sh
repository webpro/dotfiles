#!/usr/bin/env bash

# Install Homebrew & brew-cask

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap caskroom/cask
brew install brew-cask
brew tap homebrew/versions
brew tap caskroom/versions

# Install brew & brew-cask packages

. "$DOTFILES_DIR/install/brew.sh"
. "$DOTFILES_DIR/install/brew-cask.sh"

# Install bash (with Homebrew)

. "$DOTFILES_DIR/install/bash.sh"

# Install Ruby gems (SASS, Compass)
# Not OSX-only, but lazy.

sudo gem install consular
sudo gem install consular-osx
sudo gem install compass
sudo gem install lunchy
sudo gem install pygmentize
sudo gem install sass
sudo gem install sass-globbing

# Globally install with npm
# Not OSX-only, but npm was installed from this script as well.

npm install -g grunt
npm install -g gulp
npm install -g http-server
npm install -g nodemon
npm install -g spot
npm install -g svgo
npm install -g tldr
npm install -g underscore
npm install -g vtop

# Install extra stuff

if [ -d "$EXTRA_DIR" -a -f "$EXTRA_DIR/install/osx.sh" ]; then
    . "$EXTRA_DIR/install/osx.sh"
fi
