#!/bin/sh

brew cask install mjolnir

brew install lua
brew install luarocks

luarocks install mjolnir.hotkey
luarocks install mjolnir.application

ln -sfv "$DOTFILES_DIR/etc/mjolnir" ~/.mjolnir
