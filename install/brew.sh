#!/bin/sh

# Update Homebrew, formulae, and packages

brew update
brew upgrade

# Install GNU packages (and override OSX version)

apps=(
    bash-completion
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
    ssh-copy-id
    svn
    tree
    vim
    wget
)

brew install ${apps[@]}
