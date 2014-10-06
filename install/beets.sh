#!/bin/sh

pip install beets requests flask pylast --upgrade

CONFIG_PATH=$(beet config -p)
ln -sfv "$DOTFILES_DIR/etc/beets/config.yml" "$CONFIG_PATH"
mkdir -p ~/MUSICLIB
alias mountmusic="mount -t nfs 192.168.178.18:/MUSIC ~/MUSICLIB"
unset CONFIG_PATH
