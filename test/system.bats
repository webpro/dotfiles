#!/usr/bin/env bats

setup() {
	STUBS="$(mktemp -d)"
	ln -s "$BASH" "$STUBS/bash"
	cp "$BATS_TEST_DIRNAME/../bin/is-executable" "$STUBS/is-executable"
}

teardown() {
	rm -rf "$STUBS"
}

stub() {
	printf '#!%s\n%s\n' "$BASH" "$2" > "$STUBS/$1"
	chmod +x "$STUBS/$1"
}

# Source a system file with only the stubs on PATH, then run a command
source_system() {
	local file="$BATS_TEST_DIRNAME/../system/$1"
	local after="$2"
	shift 2
	run /usr/bin/env -i PATH="$STUBS" "$@" "$BASH" --noprofile --norc -c '. "$0"; eval "$1"' "$file" "$after"
}

copy_command() {
	source_system fzf.bash 'printf "%s" "$FZF_CTRL_R_OPTS"' "$@"
	[[ "$output" =~ \|\ ([^\)]*)\)\+abort ]] && echo "${BASH_REMATCH[1]}"
}

@test "fzf.bash is silent without fzf" {
	source_system fzf.bash 'printf "%s" "$FZF_CTRL_R_OPTS"'
	[ "$output" = "" ]
}

@test "fzf.bash loads fzf key bindings" {
	stub fzf 'echo "FZF_LOADED=yes"'
	source_system fzf.bash 'echo "$FZF_LOADED"'
	[ "$output" = "yes" ]
}

@test "fzf.bash is silent when fzf predates --bash" {
	stub fzf 'echo "unknown option: --bash" >&2; exit 2'
	source_system fzf.bash 'true'
	[ "$output" = "" ]
}

@test "fzf.bash copies with pbcopy" {
	stub fzf ':'
	stub pbcopy ':'
	[ "$(copy_command)" = "pbcopy" ]
}

@test "fzf.bash copies with wl-copy on Wayland" {
	stub fzf ':'
	stub wl-copy ':'
	stub xclip ':'
	[ "$(copy_command WAYLAND_DISPLAY=wayland-0 DISPLAY=:0)" = "wl-copy" ]
}

@test "fzf.bash copies with xclip on X11" {
	stub fzf ':'
	stub xclip ':'
	[ "$(copy_command DISPLAY=:0)" = "xclip -selection clipboard" ]
}

@test "fzf.bash offers no copy binding without a usable clipboard" {
	stub fzf ':'
	stub wl-copy ':'
	stub xclip ':'
	source_system fzf.bash 'printf "%s" "$FZF_CTRL_R_OPTS"'
	[ "$output" = "" ]
}

@test "zoxide.bash is silent without zoxide" {
	source_system zoxide.bash 'true'
	[ "$output" = "" ]
}

@test "zoxide.bash loads zoxide" {
	stub zoxide 'echo "ZOXIDE_LOADED=yes"'
	source_system zoxide.bash 'echo "$ZOXIDE_LOADED"'
	[ "$output" = "yes" ]
}
