#!/bin/sh

# Get current dir (so run this script from anywhere)

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Update dotfiles itself first

git --work-tree="$DOTFILES_DIR" --git-dir="$DOTFILES_DIR/.git" pull origin master

# Grab the latest git-completion

curl https://raw.github.com/git/git/master/contrib/completion/git-completion.bash > "$DOTFILES_DIR/git/.git-completion"

# Bunch of symlinks

ln -sfhv "$DOTFILES_DIR/runcom/.bash_profile" ~
ln -sfhv "$DOTFILES_DIR/runcom/.inputrc" ~
ln -sfhv "$DOTFILES_DIR/git/.gitconfig" ~
ln -sfhv "$DOTFILES_DIR/git/.gitignore_global" ~

# Custom symlinks

mkdir -p ~/Projects && ln -sfhv ~/Projects ~/p
[ -f "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" ] && ln -sfhv "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" "$DOTFILES_DIR/bin/subl"

# "Confirm" function borrowed from https://gist.github.com/davejamesmiller/1965569

function ask { while true; do read -p "$1 [Y/n] " REPLY; if [ -z "$REPLY" ]; then REPLY=Y; fi; case "$REPLY" in Y*|y*) return 0;; N*|n*) return 1;; esac; done }

# Globally install with npm if not done yet (bower, grunt, http-server)

type -P bower &>/dev/null || ( ask "npm install -g bower" Y && npm install -g bower )
type -P grunt &>/dev/null || ( ask "npm install -g grunt-cli" Y && npm install -g grunt-cli )
type -P http-server &>/dev/null || ( ask "npm install -g http-server" Y && npm install -g http-server )
