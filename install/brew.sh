#!/usr/bin/env bash

# Update Homebrew, formulae, and packages

brew update
brew upgrade

# Install packages

apps=(
    bash-completion2
    chruby
    cmake
    coreutils
    dockutil
    ag
    git
    mackup
    python
    ruby-install
    tree
    vim
)

brew install "${apps[@]}"
