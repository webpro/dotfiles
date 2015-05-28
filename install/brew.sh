#!/usr/bin/env bash

# Update Homebrew, formulae, and packages

brew update
brew upgrade

# Install packages

apps=(
    dockutil
    git
    mackup
    tree
    vim
)

brew install "${apps[@]}"
