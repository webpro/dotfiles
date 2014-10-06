#!/bin/sh

# Install Vundle
mkdir -p ~/.vim/bundle && git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

# Install bundles
vim +PluginInstall +qall

# Compile YouCompleteMe
cd ~/.vim/bundle/YouCompleteMe && ./install.sh

cd -
