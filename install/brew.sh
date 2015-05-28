#!/usr/bin/env bash

# Update Homebrew, formulae, and packages

brew update
brew upgrade

# Install packages

apps=(
    bash-completion2
    coreutils
    dockutil
    ffmpeg
    fsad
    gifsicle
    git
    gnu-sed --default-names
    grep --default-names
    hub
    imagemagick
    jq
    mackup
    node
    peco
    phantomjs
    psgrep
    python
    shellcheck
    ssh-copy-id
    svn
    tree
    vim
    wget
)

brew install "${apps[@]}"
