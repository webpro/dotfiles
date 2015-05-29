#!/bin/sh

## COLORS
VIM_COLORS_DIR=~/.vim/colors
TERMINAL_COLORS_DIR=~/.terminal/colors
TMP_DIR=~/Downloads/install_tmp

# Set up Vim with Solarized

mkdir -p "$TMP_DIR" && cd "$TMP_DIR" && git clone git://github.com/altercation/vim-colors-solarized.git

mkdir -p "$VIM_COLORS_DIR" && cp "$TMP_DIR/vim-colors-solarized/colors/solarized.vim" "$VIM_COLORS_DIR/solarized.vim"

# Set up Terminal with Solarized

mkdir -p "$TMP_DIR" && cd "$TMP_DIR" && git clone git://github.com/altercation/solarized.git

SOLARIZED_TERM_TMP_DIR="$TMP_DIR/solarized/osx-terminal.app-colors-solarized"

mkdir -p "$TERMINAL_COLORS_DIR/osx-terminal.app-colors-solarized" && cp "$SOLARIZED_TERM_TMP_DIR/Solarized Dark ansi.terminal" "$TERMINAL_COLORS_DIR/osx-terminal.app-colors-solarized/Solarized Dark ansi.terminal"
cp "$SOLARIZED_TERM_TMP_DIR/Solarized Light ansi.terminal" "$TERMINAL_COLORS_DIR/osx-terminal.app-colors-solarized/Solarized Light ansi.terminal"

cd ~/ && rm -rf "$TMP_DIR"

cd -
