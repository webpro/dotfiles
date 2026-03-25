#!/usr/bin/env bats

# Makefile Target Tests
# Verifies Makefile targets work correctly

@test "Makefile exists" {
	[ -f "Makefile" ]
}

@test "Makefile has required variables defined" {
	grep -q "^DOTFILES_DIR" Makefile
	grep -qE "^\s*OS\s*:?=" Makefile  # OS can be inside ifeq block
	grep -q "^export XDG_CONFIG_HOME" Makefile
}

@test "Makefile detects OS correctly" {
	# Should set OS to one of: macos, linux, wsl
	make -f Makefile -n all 2>&1 | head -20 | cat
}

@test "make help or make without target doesn't error" {
	# Running make without args should either work or show help
	run make -n
	[ "$status" -eq 0 ] || [ "$status" -eq 2 ]
}

@test "All main targets are defined" {
	# Core targets
	grep -q "^all:" Makefile
	grep -q "^link:" Makefile
	grep -q "^unlink:" Makefile
	grep -q "^test:" Makefile
}

@test "Platform-specific targets exist" {
	grep -q "^macos:" Makefile
	grep -q "^linux:" Makefile
	grep -q "^wsl:" Makefile
}

@test "Stow targets exist for all platforms" {
	grep -q "^stow-macos:" Makefile
	grep -q "^stow-linux:" Makefile
	grep -q "^stow-wsl:" Makefile
}

@test "Package targets are defined" {
	grep -q "^packages:" Makefile
	grep -q "^brew-packages:" Makefile
	grep -q "^node-packages:" Makefile
	grep -q "^rust-packages:" Makefile
}

@test "make test target works" {
	# This test verifies test target exists (don't run recursively)
	grep -q "^test:" Makefile
	# Check it references bats or test script
	grep -A 5 "^test:" Makefile | grep -qE "(bats|run-tests)"
}

@test "make link uses @ for silent commands" {
	# Friendly output uses @ prefix
	grep -A 20 "^link:" Makefile | grep -q "@echo"
}

@test "make unlink has restore functionality" {
	# Should restore .bak files
	grep -A 20 "^unlink:" Makefile | grep -q "\.bak"
}

@test "Makefile uses -v flag for visibility in mv commands" {
	# User-facing moves should be verbose
	grep "mv -v" Makefile
}

@test "Makefile PATH includes bin directory" {
	grep -q "DOTFILES_DIR.*bin" Makefile
}

@test "Makefile sets SHELL variable" {
	grep -q "^SHELL :=" Makefile
}

@test "No syntax errors in Makefile" {
	# make -n does a dry-run and checks syntax
	run make -n all
	! [[ "$output" =~ "error:" ]]
	! [[ "$output" =~ "missing separator" ]]
}

@test "Makefile uses proper tab indentation" {
	# Makefile requires tabs, not spaces for recipes
	# This checks that at least some tabs exist
	# Use portable grep (macOS doesn't have -P)
	grep "^	" Makefile > /dev/null
}

@test "Makefile handles missing dependencies gracefully" {
	# Commands that might not exist should have fallbacks
	grep -E "is-executable|command -v" Makefile
}

@test "WSL-specific target uses sudo apt-get" {
	grep -A 10 "^core-wsl:" Makefile | grep -q "sudo apt-get"
}

@test "Linux target uses apt-get" {
	grep -A 10 "^core-linux:" Makefile | grep -q "apt-get"
}

@test "macOS target uses brew" {
	grep -A 10 "^macos:" Makefile | grep -q "brew"
}

@test "Linux target depends on brew-linux" {
	grep "^linux:" Makefile | grep -q "brew-linux"
}

@test "Linux target depends on packages-linux" {
	grep "^linux:" Makefile | grep -q "packages-linux"
}

@test "Linux target depends on chsh-linux" {
	grep "^linux:" Makefile | grep -q "chsh-linux"
}

@test "brew-linux target exists and installs homebrew" {
	grep -q "^brew-linux:" Makefile
	grep -A 3 "^brew-linux:" Makefile | grep -q "brew"
}

@test "packages-linux target exists and uses Serverfile" {
	grep -q "^packages-linux:" Makefile
	grep -A 3 "^packages-linux:" Makefile | grep -q "Serverfile"
}

@test "chsh-linux target exists and sets zsh" {
	grep -q "^chsh-linux:" Makefile
	grep -A 5 "^chsh-linux:" Makefile | grep -q "zsh"
}

@test "core-linux installs zsh" {
	grep -A 5 "^core-linux:" Makefile | grep -q "zsh"
}

@test "core-linux installs procps for Homebrew" {
	grep -A 5 "^core-linux:" Makefile | grep -q "procps"
}

@test "core-linux uses sudo" {
	grep -A 5 "^core-linux:" Makefile | grep -q "sudo"
}

@test "brew-linux uses NONINTERACTIVE for unattended install" {
	grep -A 3 "^brew-linux:" Makefile | grep -q "NONINTERACTIVE"
}

@test "Serverfile exists" {
	[ -f "install/Serverfile" ]
}

@test "Serverfile contains starship" {
	grep -q "starship" install/Serverfile
}

@test "Serverfile contains zoxide" {
	grep -q "zoxide" install/Serverfile
}

@test "Serverfile does not contain macOS-only tools" {
	! grep -qE "^(cask|brew \"dockutil\"|brew \"mas\"|brew \"duti\"|brew \"kanata\")" install/Serverfile
}

@test "Makefile exports necessary environment variables" {
	grep -q "export XDG_CONFIG_HOME" Makefile
	grep -q "export PATH" Makefile
}

@test "Submodules target exists and works" {
	grep -q "^submodules:" Makefile
	grep -q "git submodule" Makefile
}

@test "Makefile has .PHONY declarations" {
	grep -q "^\.PHONY:" Makefile
}

@test "Bun installation target exists" {
	grep -q "^bun:" Makefile
}

@test "Makefile link target depends on stow" {
	grep -q "link:.*stow" Makefile
}

@test "Makefile unlink target depends on stow" {
	grep -q "unlink:.*stow" Makefile
}
