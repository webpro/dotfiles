BREW_PREFIX=$(brew --prefix)

# Bash

if is-executable brew; then
  . "$BREW_PREFIX/share/bash-completion/bash_completion"
fi

# Dotfiles

_dotfiles_completions() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=( $(compgen -W 'clean dock edit help macos test update' -- $cur ) );
}

complete -o default -F _dotfiles_completions dot

# npm (https://docs.npmjs.com/cli/completion)

if is-executable npm; then
  . <(npm completion)
fi

# fnm

if is-executable fnm; then
  . <(fnm completions)
fi

# Git

if is-executable git; then
  . "$BREW_PREFIX/etc/bash_completion.d/git-completion.bash"
fi
