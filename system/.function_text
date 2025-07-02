# Show line in file with surrounding lines

line() {
  local FILE LINE_NUMBER LINES_AROUND=0
  local NAME="${FUNCNAME[0]}"

  if [[ ! -t 0 ]]; then
    LINE_NUMBER=$1
    LINES_AROUND=${2:-$LINES_AROUND}
  elif [[ $1 =~ ^([^:]+):([0-9]+)(:[0-9]+)?$ ]]; then
    FILE="${BASH_REMATCH[1]}"
    LINE_NUMBER="${BASH_REMATCH[2]}"
    LINES_AROUND=${2:-$LINES_AROUND}
  else
    FILE=$1
    LINE_NUMBER=$2
    LINES_AROUND=${3:-$LINES_AROUND}
  fi

  if [[ -t 0 && -z "$FILE" || -z "$LINE_NUMBER" ]]; then
    echo "Usage: ${NAME} <file> <line_number> [lines_around=0]
       ${NAME} <file:line_number[:column]>
       cat <file> | ${NAME} <line_number> [lines_around=0]"
    return 1
  fi

  if [[ -t 0 && -n "$FILE" && ! -f "$FILE" ]]; then
    echo "${NAME}: $FILE: No such file or directory"
    return 1
  fi

  sed -n "`expr $LINE_NUMBER - $LINES_AROUND`,`expr $LINE_NUMBER + $LINES_AROUND`p" ${FILE}
}

# Show duplicate/unique lines
# Source: https://github.com/ain/.dotfiles/commit/967a2e65a44708449b6e93f87daa2721929cb87a

duplines() {
  sort $1 | uniq -d
}

uniqlines() {
  sort $1 | uniq -u
}
