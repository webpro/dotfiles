if is-executable fzf; then
  eval "$(fzf --bash 2>/dev/null)"

  if is-executable pbcopy; then
    FZF_COPY="pbcopy"
  elif [ -n "$WAYLAND_DISPLAY" ] && is-executable wl-copy; then
    FZF_COPY="wl-copy"
  elif [ -n "$DISPLAY" ] && is-executable xclip; then
    FZF_COPY="xclip -selection clipboard"
  fi

  if [ -n "$FZF_COPY" ]; then
    export FZF_CTRL_R_OPTS="
  --bind 'ctrl-y:execute-silent(echo -n {2..} | $FZF_COPY)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"
  fi

  unset FZF_COPY
fi
