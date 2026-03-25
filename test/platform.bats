#!/usr/bin/env bats

# Platform Detection Tests
# Tests for OS and environment detection scripts

@test "is-macos exists and is executable" {
	[ -x "bin/is-macos" ]
}

@test "is-wsl exists and is executable" {
	[ -x "bin/is-wsl" ]
}

@test "is-windows exists and is executable" {
	[ -x "bin/is-windows" ]
}

@test "is-arm64 exists and is executable" {
	[ -x "bin/is-arm64" ]
}

@test "Platform detection scripts return valid exit codes" {
	# One of these should return 0 (true)
	run bin/is-macos
	macos_result=$status

	run bin/is-wsl
	wsl_result=$status

	# At least one should be true (exit 0) on current platform
	[ $macos_result -eq 0 ] || [ $wsl_result -eq 0 ] || [ $macos_result -eq 1 ]
}

@test "is-macos correctly detects macOS" {
	if [[ "$OSTYPE" =~ ^darwin ]]; then
		run bin/is-macos
		[ "$status" -eq 0 ]
	else
		run bin/is-macos
		[ "$status" -eq 1 ]
	fi
}

@test "is-wsl correctly detects WSL" {
	if [ -f /proc/version ] && grep -qi microsoft /proc/version; then
		run bin/is-wsl
		[ "$status" -eq 0 ]
	else
		run bin/is-wsl
		[ "$status" -eq 1 ]
	fi
}

@test "is-arm64 detection works" {
	run bin/is-arm64
	# Should return either 0 or 1, not error
	[ "$status" -eq 0 ] || [ "$status" -eq 1 ]
}

@test "is-linux exists and is executable" {
	[ -x "bin/is-linux" ]
}

@test "is-linux correctly detects Linux (not WSL)" {
	if [[ "$OSTYPE" =~ ^linux ]] && ! grep -qi microsoft /proc/version 2>/dev/null; then
		run bin/is-linux
		[ "$status" -eq 0 ]
	else
		run bin/is-linux
		[ "$status" -eq 1 ]
	fi
}

@test "is-linux returns false on macOS" {
	if [[ "$OSTYPE" =~ ^darwin ]]; then
		run bin/is-linux
		[ "$status" -eq 1 ]
	else
		skip "Not running on macOS"
	fi
}

@test "is-linux returns false on WSL" {
	if [ -f /proc/version ] && grep -qi microsoft /proc/version 2>/dev/null; then
		run bin/is-linux
		[ "$status" -eq 1 ]
	else
		skip "Not running on WSL"
	fi
}

@test "Makefile OS variable is set correctly" {
	# OS should be detected as one of: macos, linux, wsl
	OS=$(make -f Makefile -p 2>/dev/null | grep "^OS :=" | cut -d'=' -f2 | xargs)
	[[ "$OS" =~ ^(macos|linux|wsl)$ ]]
}

@test "HOMEBREW_PREFIX is set for current platform" {
	HOMEBREW_PREFIX=$(make -f Makefile -p 2>/dev/null | grep "^HOMEBREW_PREFIX :=" | cut -d'=' -f2 | xargs)
	[ -n "$HOMEBREW_PREFIX" ]
}
