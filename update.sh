#!/bin/sh

sudo -v

sudo softwareupdate -i -a
brew update
brew upgrade
npm update npm -g
npm update -g
sudo gem update --system
sudo gem update
