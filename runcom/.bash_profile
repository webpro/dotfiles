# If not running interactively, don't do anything

[ -z "$PS1" ] && return

# OS

if [ "$(uname -s)" = "Darwin" ]; then
    OS="OSX"
else
    OS=$(uname -s)
fi

# Resolve DOTFILES_DIR (assuming ~/.dotfiles on distros without readlink and/or $BASH_SOURCE/$0)

READLINK=$(which greadlink || which readlink)
CURRENT_SCRIPT=$BASH_SOURCE

if [[ -n $CURRENT_SCRIPT && -x "$READLINK" ]]; then
    SCRIPT_PATH=$($READLINK -f "$CURRENT_SCRIPT")
    DOTFILES_DIR=$(dirname "$(dirname "$SCRIPT_PATH")")
elif [ -d "$HOME/.dotfiles" ]; then
    DOTFILES_DIR="$HOME/.dotfiles"
else
    echo "Unable to find dotfiles, exiting."
    return # `exit 1` would quit the shell itself
fi

# Finally we can source the dotfiles (order matters)

for DOTFILE in "$DOTFILES_DIR"/system/.{function,function_*,path,env,alias,completion,grep,prompt,nvm,rvm,custom}; do
    [ -f "$DOTFILE" ] && . "$DOTFILE"
done

if [ "$OS" = "OSX" ]; then
    for DOTFILE in "$DOTFILES_DIR"/system/.{env,alias,function}.osx; do
        [ -f "$DOTFILE" ] && . "$DOTFILE"
    done
fi

# Set LSCOLORS

eval "$(dircolors "$DOTFILES_DIR"/system/.dir_colors)"

# Hook for extra/custom stuff

EXTRA_DIR="$HOME/.extra"

if [ -d "$EXTRA_DIR" ]; then
    for EXTRAFILE in "$EXTRA_DIR"/runcom/*.sh; do
        [ -f "$EXTRAFILE" ] && . "$EXTRAFILE"
    done
fi

# Clean up

unset READLINK CURRENT_SCRIPT SCRIPT_PATH DOTFILE

# Export

export OS DOTFILES_DIR EXTRA_DIR
