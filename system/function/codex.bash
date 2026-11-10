# Temporarily trust the launch directory and run without approvals or sandboxing.
# Upstream tracking: https://github.com/openai/codex/issues/53018

codex() (
  local directory content=""
  directory=$(git rev-parse --show-toplevel 2>/dev/null || pwd -P) || return
  local config="$DOTFILES_DIR/config/_home/.codex/config.toml"
  mkdir -p "$(dirname "$config")" || return
  touch "$config" || return

  content=$(CODEX_PROJECT_DIR="$directory" yq -p toml -o toml '.projects[strenv(CODEX_PROJECT_DIR)].trust_level = "trusted"' "$config") || return
  printf '%s\n' "$content" > "$config" || return
  trap '
    content=$(CODEX_PROJECT_DIR="$directory" yq -p toml -o toml "del(.projects[strenv(CODEX_PROJECT_DIR)]) | del(.projects | select(length == 0))" "$config") &&
      printf "%s\n" "$content" > "$config"
  ' EXIT
  trap 'exit 129' HUP
  trap 'exit 143' TERM
  command codex --dangerously-bypass-approvals-and-sandbox "$@"
)
