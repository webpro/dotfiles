#!/bin/sh

BUNDLE_DIR=~/.vim/bundle

# Install/update Vundle
mkdir -p "$BUNDLE_DIR" && (git clone https://github.com/gmarik/Vundle.vim.git "$BUNDLE_DIR/Vundle.vim" || (cd "$BUNDLE_DIR/Vundle.vim" && git pull origin master))

# Install bundles
vim +PluginInstall +qall

# Compile YouCompleteMe
cd "$BUNDLE_DIR/YouCompleteMe" && ./install.sh

cd -
