## Prompt

_bash_prompt_config() {

  local USER_SYMBOL="\u"
  local HOST_SYMBOL="\h"
  local ESC_OPEN="\["
  local ESC_CLOSE="\]"

  if tput setaf >/dev/null 2>&1 ; then
    _setaf () { tput setaf "$1" ; }
    local RESET="${ESC_OPEN}$( { tput sgr0 || tput me ; } 2>/dev/null )${ESC_CLOSE}"
    local BOLD="$( { tput bold || tput md ; } 2>/dev/null )"
  else
    # Fallback
    _setaf () { echo "\033[0;$(($1+30))m" ; }
    local RESET="\033[m"
    local BOLD=""
    ESC_OPEN=""
    ESC_CLOSE=""
  fi

  # Normal colors
  local BLACK="${ESC_OPEN}$(_setaf 0)${ESC_CLOSE}"
  local RED="${ESC_OPEN}$(_setaf 1)${ESC_CLOSE}"
  local GREEN="${ESC_OPEN}$(_setaf 2)${ESC_CLOSE}"
  local YELLOW="${ESC_OPEN}$(_setaf 3)${ESC_CLOSE}"
  local BLUE="${ESC_OPEN}$(_setaf 4)${ESC_CLOSE}"
  local VIOLET="${ESC_OPEN}$(_setaf 5)${ESC_CLOSE}"
  local CYAN="${ESC_OPEN}$(_setaf 6)${ESC_CLOSE}"
  local WHITE="${ESC_OPEN}$(_setaf 7)${ESC_CLOSE}"

  # Bright colors
  local BRIGHT_GREEN="${ESC_OPEN}$(_setaf 10)${ESC_CLOSE}"
  local BRIGHT_YELLOW="${ESC_OPEN}$(_setaf 11)${ESC_CLOSE}"
  local BRIGHT_BLUE="${ESC_OPEN}$(_setaf 12)${ESC_CLOSE}"
  local BRIGHT_VIOLET="${ESC_OPEN}$(_setaf 13)${ESC_CLOSE}"
  local BRIGHT_CYAN="${ESC_OPEN}$(_setaf 14)${ESC_CLOSE}"
  local BRIGHT_WHITE="${ESC_OPEN}$(_setaf 15)${ESC_CLOSE}"

  # Bold colors
  local BLACK_BOLD="${ESC_OPEN}${BOLD}$(_setaf 0)${ESC_CLOSE}"
  local RED_BOLD="${ESC_OPEN}${BOLD}$(_setaf 1)${ESC_CLOSE}"
  local GREEN_BOLD="${ESC_OPEN}${BOLD}$(_setaf 2)${ESC_CLOSE}"
  local YELLOW_BOLD="${ESC_OPEN}${BOLD}$(_setaf 3)${ESC_CLOSE}"
  local BLUE_BOLD="${ESC_OPEN}${BOLD}$(_setaf 4)${ESC_CLOSE}"
  local VIOLET_BOLD="${ESC_OPEN}${BOLD}$(_setaf 5)${ESC_CLOSE}"
  local CYAN_BOLD="${ESC_OPEN}${BOLD}$(_setaf 6)${ESC_CLOSE}"
  local WHITE_BOLD="${ESC_OPEN}${BOLD}$(_setaf 7)${ESC_CLOSE}"

  # Expose the variables we need in prompt command
  P_USER=${BRIGHT_GREEN}${USER_SYMBOL}
  P_HOST=${CYAN}${HOST_SYMBOL}
  P_WHITE=${WHITE}
  P_GREEN=${BRIGHT_GREEN}
  P_YELLOW=${YELLOW}
  P_RED=${RED}
  P_RESET=${RESET}

}

bash_prompt_command() {

  local EXIT_CODE=$?
  local P_EXIT=""
  local MAXLENGTH=35
  local TRUNC_SYMBOL=".."
  local DIR=${PWD##*/}
  local P_PWD=${PWD/#$HOME/\~}

  MAXLENGTH=$(( ( MAXLENGTH < ${#DIR} ) ? ${#DIR} : MAXLENGTH ))

  local OFFSET=$(( ${#P_PWD} - MAXLENGTH ))

  if [ ${OFFSET} -gt "0" ]; then
    P_PWD=${P_PWD:$OFFSET:$MAXLENGTH}
    P_PWD=${TRUNC_SYMBOL}/${P_PWD#*/}
  fi

  # Update terminal title
  if [[ $TERM == xterm* ]]; then
    echo -ne "\033]0;${P_PWD}\007"
  fi

  # Parse Git branch name
  P_GIT=$(parse_git_branch)

  # Exit code
  if [[ $EXIT_CODE != 0 ]]; then
    P_EXIT+="${P_RED}✘ "
  fi

  PS1="${P_EXIT}${P_USER}${P_WHITE}@${P_HOST} ${P_YELLOW}${P_PWD}${P_GREEN}${P_GIT}${P_YELLOW} ❯ ${P_RESET}"
}

parse_git_branch() {
  local OUT=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
  if [ "$OUT" != "" ]; then echo " $OUT"; fi
}

_bash_prompt_config
unset _bash_prompt_config

PROMPT_COMMAND=bash_prompt_command
