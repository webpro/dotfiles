if [ -z "$HOMEBREW_PREFIX" ] && is-executable brew; then
  HOMEBREW_PREFIX=$(brew --prefix)
fi

# Bash

if [ -f "/usr/share/bash-completion/bash_completion" ]; then
  . "/usr/share/bash-completion/bash_completion"
elif [ -n "$HOMEBREW_PREFIX" ] && [ -f "$HOMEBREW_PREFIX/share/bash-completion/bash_completion" ]; then
  . "$HOMEBREW_PREFIX/share/bash-completion/bash_completion"
fi

# dot

_dotfiles_completions() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=( $(compgen -W 'clean dock duti edit help macos test update' -- $cur ) );
}

complete -o default -F _dotfiles_completions dot

# tmux

if is-executable tmux; then
  if [ -f "/usr/share/bash-completion/completions/tmux" ]; then
    . "/usr/share/bash-completion/completions/tmux"
  elif [ -n "$HOMEBREW_PREFIX" ] && [ -f "$HOMEBREW_PREFIX/etc/bash_completion.d/tmux" ]; then
    . "$HOMEBREW_PREFIX/etc/bash_completion.d/tmux"
  fi
fi

# npm (https://docs.npmjs.com/cli/completion)

if is-executable npm; then
  . <(npm completion)
fi

# Git

if is-executable git; then
  if [ -f "/usr/share/git/completion/git-completion.bash" ]; then
    . "/usr/share/git/completion/git-completion.bash"
  elif [ -n "$HOMEBREW_PREFIX" ] && [ -f "$HOMEBREW_PREFIX/etc/bash_completion.d/git-completion.bash" ]; then
    . "$HOMEBREW_PREFIX/etc/bash_completion.d/git-completion.bash"
  fi
fi

# pnpm (https://pnpm.io/completion)

_pnpm_completion () {
  local words cword
  if type _get_comp_words_by_ref &>/dev/null; then
    _get_comp_words_by_ref -n = -n @ -n : -w words -i cword
  else
    cword="$COMP_CWORD"
    words=("${COMP_WORDS[@]}")
  fi

  local si="$IFS"
  IFS=$'\n' COMPREPLY=($(COMP_CWORD="$cword" \
                          COMP_LINE="$COMP_LINE" \
                          COMP_POINT="$COMP_POINT" \
                          SHELL=bash \
                          pnpm completion-server -- "${words[@]}" \
                          2>/dev/null)) || return $?
  IFS="$si"

  if [ "$COMPREPLY" = "__tabtab_complete_files__" ]; then
    COMPREPLY=($(compgen -f -- "$cword"))
  fi

  if type __ltrim_colon_completions &>/dev/null; then
    __ltrim_colon_completions "${words[cword]}"
  fi
}
complete -o default -F _pnpm_completion pnpm
