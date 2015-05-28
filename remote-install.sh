#!/usr/bin/env bash

is-executable wget && CMD="wget --no-check-certificate -O -"
is-executable curl && CMD="curl -#L"

if [ -z "$CMD" ]; then
    echo "No curl or wget available. Aborting."
else
    echo "Installing dotfiles"
    mkdir -p "$HOME/.dotfiles" && \
    eval "$CMD https://github.com/webpro/dotfiles/tarball/master | tar -xzv -C ~/.dotfiles --strip-components=1 --exclude='{.gitignore}'"
    . "$HOME/.dotfiles/install.sh"
fi
