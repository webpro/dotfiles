# Show line, optionally show surrounding lines

line() {
  local LINE_NUMBER=$1
  local LINES_AROUND=${2:-0}
  sed -n "`expr $LINE_NUMBER - $LINES_AROUND`,`expr $LINE_NUMBER + $LINES_AROUND`p"
}

# Show duplicate/unique lines
# Source: https://github.com/ain/.dotfiles/commit/967a2e65a44708449b6e93f87daa2721929cb87a

duplines() {
  sort $1 | uniq -d
}

uniqlines() {
  sort $1 | uniq -u
}
