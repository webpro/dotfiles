#!/usr/bin/env bash

# Get current dir (so run this script from anywhere)

export DOTFILES_DIR
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Update dotfiles itself first

[ -d "$DOTFILES_DIR/.git" ] && git --work-tree="$DOTFILES_DIR" --git-dir="$DOTFILES_DIR/.git" pull origin master

# Bunch of symlinks

ln -sfv "$DOTFILES_DIR/runcom/.bash_profile" ~
ln -sfv "$DOTFILES_DIR/runcom/.inputrc" ~
ln -sfv "$DOTFILES_DIR/git/.gitconfig" ~
ln -sfv "$DOTFILES_DIR/git/.gitignore_global" ~

if [ "$(uname)" == "Darwin" ]; then
    ln -sfv "$DOTFILES_DIR/etc/mackup/.mackup.cfg" ~
    if [ -f "$DOTFILES_DIR/install/osx.sh" ]; then
        . "$DOTFILES_DIR/install/osx.sh"
    fi
fi
