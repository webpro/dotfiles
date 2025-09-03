# If not running interactively, don't do anything

[ -z "$PS1" ] && return

# Resolve DOTFILES_DIR (assuming ~/.dotfiles on distros without readlink and/or $BASH_SOURCE/$0)
CURRENT_SCRIPT=$BASH_SOURCE

if [[ -n $CURRENT_SCRIPT && -x readlink ]]; then
  SCRIPT_PATH=$(readlink -n $CURRENT_SCRIPT)
  DOTFILES_DIR="${PWD}/$(dirname $(dirname $SCRIPT_PATH))"
elif [ -d "$HOME/.dotfiles" ]; then
  DOTFILES_DIR="$HOME/.dotfiles"
else
  echo "Unable to find dotfiles, exiting."
  return
fi

# Make utilities available

PATH="$DOTFILES_DIR/bin:$PATH"

# Source the dotfiles (order matters)

if is-macos; then
  for DOTFILE in "$DOTFILES_DIR"/system/.{env,alias,function,path}.macos; do
    . "$DOTFILE"
  done
fi

for DOTFILE in "$DOTFILES_DIR"/system/.{function,function_*,n,env,exports,alias,fzf,grep,prompt,completion,fix,pnpm,zoxide}; do
  . "$DOTFILE"
done

# Set LSCOLORS

eval "$(dircolors -b "$DOTFILES_DIR"/system/.dir_colors)"

# Wrap up

unset CURRENT_SCRIPT SCRIPT_PATH DOTFILE
export DOTFILES_DIR
