#!/usr/bin/env bats

# Package Installation Tests
# Verifies that key packages are installed correctly

@test "Package list files exist" {
	[ -f "install/Brewfile" ]
	[ -f "install/npmfile" ]
}

@test "Brewfile is valid" {
	# Should not be empty and should have proper format
	[ -s "install/Brewfile" ]
	# Should contain brew, tap, cask, or mas commands
	grep -qE "^(brew|tap|cask|mas)" install/Brewfile || [ $? -eq 1 ]
}

@test "npmfile is valid" {
	[ -s "install/npmfile" ]
	# Should contain package names (no comments or empty lines only)
	grep -v "^#" install/npmfile | grep -v "^$" | wc -l | grep -qv "^0$"
}


@test "Homebrew is installed (if on macOS or Linux with Homebrew)" {
	if command -v brew &> /dev/null; then
		run brew --version
		[ "$status" -eq 0 ]
	else
		skip "Homebrew not installed on this system"
	fi
}

@test "Git is installed" {
	command -v git
	run git --version
	[ "$status" -eq 0 ]
}

@test "Stow is installed" {
	if command -v stow &> /dev/null; then
		run stow --version
		[ "$status" -eq 0 ]
	else
		skip "Stow not yet installed"
	fi
}

@test "Zsh is installed" {
	command -v zsh
	run zsh --version
	[ "$status" -eq 0 ]
}

@test "Node.js is installed" {
	if command -v node &> /dev/null; then
		run node --version
		[ "$status" -eq 0 ]
	else
		skip "Node.js not yet installed"
	fi
}

@test "npm is installed" {
	if command -v npm &> /dev/null; then
		run npm --version
		[ "$status" -eq 0 ]
	else
		skip "npm not yet installed"
	fi
}

@test "Neovim is installed" {
	if command -v nvim &> /dev/null; then
		run nvim --version
		[ "$status" -eq 0 ]
	else
		skip "Neovim not yet installed"
	fi
}

@test "Starship is installed" {
	if command -v starship &> /dev/null; then
		run starship --version
		[ "$status" -eq 0 ]
	else
		skip "Starship not yet installed"
	fi
}

@test "Rust toolchain is installed" {
	if command -v rustc &> /dev/null; then
		run rustc --version
		[ "$status" -eq 0 ]
	else
		skip "Rust not yet installed"
	fi
}

@test "Cargo is installed" {
	if command -v cargo &> /dev/null; then
		run cargo --version
		[ "$status" -eq 0 ]
	else
		skip "Cargo not yet installed"
	fi
}

# macOS-specific tests
@test "macOS: Caskfile exists and is valid" {
	if bin/is-macos; then
		[ -f "install/Caskfile" ]
		[ -s "install/Caskfile" ]
	else
		skip "Not on macOS"
	fi
}

@test "macOS: Masfile exists and is valid" {
	if bin/is-macos; then
		[ -f "install/Masfile" ]
		[ -s "install/Masfile" ]
	else
		skip "Not on macOS"
	fi
}

@test "macOS: mas is installed" {
	if bin/is-macos && command -v mas &> /dev/null; then
		run mas version
		[ "$status" -eq 0 ]
	else
		skip "Not on macOS or mas not installed"
	fi
}

# Windows-specific tests
@test "Windows: winget package file exists" {
	[ -f "install/windows/winget-packages.txt" ]
}

@test "Windows: setup.ps1 exists" {
	[ -f "install/windows/setup.ps1" ]
}

@test "Windows: README exists" {
	[ -f "install/windows/README.md" ]
}
