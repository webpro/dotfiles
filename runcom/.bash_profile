# If not running interactively, don't do anything

[ -z "$PS1" ] && return

# OS

if [ "$(uname)" == "Darwin" ]; then
    OS="OSX"
else
    OS=`uname`
fi

# Resolve DOTFILES_DIR (assuming ~/.dotfiles on distros without readlink and/or $BASH_SOURCE)

READLINK=$(type -p greadlink readlink | head -1)

if [[ -n $BASH_SOURCE && -x "$READLINK" ]]; then
    SCRIPT_PATH=$($READLINK -f ${BASH_SOURCE})
    DOTFILES_DIR=$(dirname $(dirname ${SCRIPT_PATH}))
elif [ -d "$HOME/.dotfiles" ]; then
    DOTFILES_DIR="$HOME/.dotfiles"
else
    echo "Unable to find dotfiles, exiting."
    return # `exit 1` would quit the shell itself
fi

# Finally we can source the dotfiles (make sure path & env are sourced first)

for DOTFILE in "$DOTFILES_DIR"/system/.{path,env,alias,colors,completion,function,prompt,custom}; do
	[ -f "$DOTFILE" ] && source "$DOTFILE"
done

if [ $OS == "OSX" ]; then
	for DOTFILE in "$DOTFILES_DIR"/system/.{env,alias,completion,function}-osx; do
		[ -f "$DOTFILE" ] && source "$DOTFILE"
	done
fi

# Clean up

unset READLINK SCRIPT_PATH DOTFILE

# Export

export OS BASH_VERSION_MAJOR DOTFILES_DIR
