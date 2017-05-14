#!/usr/bin/env bash

if [ -x "`command -v curl`" ]; then
  CMD="curl -#L"
elif [ -x "`command -v wget`" ]; then
  CMD="wget --no-check-certificate -O -"
fi

if [ -z "$CMD" ]; then
  echo "No curl or wget available. Aborting."
else
  echo "Installing dotfiles"
  mkdir -p "$HOME/.dotfiles" && \
  eval "$CMD https://github.com/webpro/dotfiles/tarball/master | tar -xzv -C ~/.dotfiles --strip-components=1 --exclude='{.gitignore}'"
  . "$HOME/.dotfiles/install.sh"
fi
