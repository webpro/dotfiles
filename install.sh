#!/bin/sh

# Update dotfiles itself first

git pull origin master

# Grab the latest git-completion

curl https://raw.github.com/git/git/master/contrib/completion/git-completion.bash > "$PWD/.git-completion"

# Bunch of symlinks

ln -sfhv "$PWD/runcom/.bash_profile" ~
ln -sfhv "$PWD/runcom/.inputrc" ~
ln -sfhv "$PWD/git/.gitconfig" ~
ln -sfhv "$PWD/git/.gitignore_global" ~

# Custom symlinks

mkdir -p ~/Projects && ln -sfhv ~/Projects ~/p
[ -f "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" ] && ln -sfhv "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" "$PWD/bin/subl"

# "Confirm" function borrowed from https://gist.github.com/davejamesmiller/1965569

function ask { while true; do read -p "$1 [Y/n] " REPLY; if [ -z "$REPLY" ]; then REPLY=Y; fi; case "$REPLY" in Y*|y*) return 0;; N*|n*) return 1;; esac; done }

# Globally install with npm if not done yet (bower, grunt, http-server)

type -P bower &>/dev/null || ( ask "npm install -g bower" Y && npm install -g bower )
type -P grunt &>/dev/null || ( ask "npm install -g grunt-cli" Y && npm install -g grunt-cli )
type -P http-server &>/dev/null || ( ask "npm install -g http-server" Y && npm install -g http-server )
