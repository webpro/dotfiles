# If not running interactively, don't do anything

[ -z "$PS1" ] && return

# Resolve path until file is no longer a symlink, and export DOTFILES_DIR so we can use it anywhere

PROFILE_SOURCE="${BASH_SOURCE[0]}"
while [ -h "$PROFILE_SOURCE" ]; do
	DOTFILES_DIR="$( cd -P "$( dirname "$PROFILE_SOURCE" )" && pwd )"
	PROFILE_SOURCE="$(readlink "$PROFILE_SOURCE")"
	[[ $PROFILE_SOURCE != /* ]] && PROFILE_SOURCE="$DIR/$PROFILE_SOURCE"
done
export DOTFILES_DIR="$( cd -P "$( dirname "$PROFILE_SOURCE" )/.." && pwd )"

# Finally we can source the dotfiles (make sure path & env are sourced first)

for DOTFILE in "$DOTFILES_DIR"/system/.{path,env,alias,colors,completion,function,prompt,custom}; do
	[ -f "$DOTFILE" ] && source "$DOTFILE";
done;

# Clean up

unset DOTFILE PROFILE_SOURCE
