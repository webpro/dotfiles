#!/usr/bin/env bash

if [ ! -d "$HOME/.dotfiles" ]; then
    echo "Installing dotfiles"
    mkdir -p "$HOME/.dotfiles" && \
    curl -#L https://github.com/webpro/dotfiles/tarball/master | tar -xzv --directory ~/.dotfiles --strip-components=1 --exclude="{.gitignore}"
    . "$HOME/.dotfiles/install.sh"
else
    echo "The dotfiles are already installed."
fi
