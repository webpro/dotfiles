if ! is-macos -o ! is-executable brew; then
  echo "Skipped: Bash 4"
  return
fi

brew install bash bash-completion2

grep "/usr/local/bin/bash" /private/etc/shells &>/dev/null || sudo bash -c "echo /usr/local/bin/bash >> /private/etc/shells"
chsh -s /usr/local/bin/bash
