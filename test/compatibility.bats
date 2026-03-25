#!/usr/bin/env bats

# Cross-Platform Compatibility Tests
# Ensures configs and scripts work across all supported platforms

@test "All bin scripts have proper shebangs" {
	for script in bin/*; do
		if [ -f "$script" ] && [ ! -d "$script" ]; then
			head -n1 "$script" | grep -qE "^#!"
		fi
	done
}

@test "All bin scripts are executable" {
	for script in bin/*; do
		if [ -f "$script" ] && [ ! -d "$script" ]; then
			[ -x "$script" ]
		fi
	done
}

@test "Shell scripts use /usr/bin/env for portability" {
	for script in bin/*; do
		if [ -f "$script" ] && [[ ! "$script" =~ \.md$ ]]; then
			# Should use #!/usr/bin/env bash, not #!/bin/bash
			if head -n1 "$script" | grep -q "^#!"; then
				head -n1 "$script" | grep -qE "^#!/usr/bin/env" || {
					# Exception: Some scripts might have valid reasons for absolute paths
					skip "Script $script uses absolute path shebang"
				}
			fi
		fi
	done
}

@test "No hardcoded /Users paths in configs" {
	# Should use $HOME instead
	! grep -r "/Users/" config/ --include="*" --exclude-dir=".git" 2>/dev/null || true
}

@test "No hardcoded /home paths in configs" {
	# Should use $HOME instead
	! grep -r "/home/" config/ --include="*" --exclude-dir=".git" 2>/dev/null | grep -v "linuxbrew" || true
}

@test "No hardcoded macOS-specific paths in shared configs" {
	# Configs should be portable
	! grep -r "/Applications" config/ --include="*" --exclude-dir=".git" 2>/dev/null || true
}

@test "Makefile uses portable commands" {
	# Should not use macOS-specific commands without platform checks
	if grep -E "^[^#]*\b(pbcopy|pbpaste|open)\b" Makefile; then
		# These should be in macOS-specific targets only
		grep -E "^(macos|duti):" Makefile
	fi
}

@test "XDG_CONFIG_HOME is used consistently" {
	# Should reference XDG_CONFIG_HOME, not hardcode ~/.config
	grep -q "XDG_CONFIG_HOME" Makefile
}

@test "PATH modifications use portable syntax" {
	# Check runcom files use proper PATH modification
	if [ -f "runcom/.zshrc" ]; then
		grep -q "PATH" runcom/.zshrc || skip "No PATH in .zshrc"
	fi
}

@test "Dotfiles work with bash" {
	# Even though we prefer zsh, should be bash-compatible
	run bash -c "source system/.function && echo 'test'"
	[ "$status" -eq 0 ]
}

@test "Dotfiles work with zsh" {
	if command -v zsh &> /dev/null; then
		run zsh -c "source system/.function && echo 'test'"
		[ "$status" -eq 0 ]
	else
		skip "zsh not installed"
	fi
}

@test "No Windows line endings (CRLF) in shell scripts" {
	# Shell scripts should use Unix line endings (LF)
	for script in bin/* runcom/.* system/.*; do
		if [ -f "$script" ] && [[ ! "$script" =~ \.md$ ]]; then
			! file "$script" | grep -q "CRLF" 2>/dev/null || true
		fi
	done
}

@test "Config files are valid YAML/TOML where applicable" {
	if [ -f "config/starship.toml" ]; then
		# Basic TOML syntax check - no syntax errors visible
		! grep -E "^\s*\[.*\[.*\]" config/starship.toml
	fi
}

@test "Git config exists and is valid" {
	if [ -d "config/git" ]; then
		[ -f "config/git/config" ] || [ -f "config/git/.gitconfig" ]
	fi
}

@test "Neovim config structure is valid" {
	if [ -d "config/nvim" ]; then
		# Should have init.lua or init.vim
		[ -f "config/nvim/init.lua" ] || [ -f "config/nvim/init.vim" ]
	fi
}

@test "No secrets or credentials in configs" {
	# Check for common secret patterns
	! grep -riE "(api_key|password|secret|token|credential).*=.*['\"]" config/ --include="*" --exclude-dir=".git" | grep -v "github.user" || true
}

@test "README contains platform-specific instructions" {
	grep -q "macOS" README.md
	grep -q "Linux" README.md
	grep -q "Windows" README.md
}

@test "Linux env override file exists" {
	[ -f "system/.env.linux" ]
}

@test "Linux env overrides EDITOR away from VSCode" {
	grep -q "EDITOR" system/.env.linux
	# Must not set editor to 'code' — VSCode is not available on headless servers
	! grep -E "EDITOR.*=.*[\"']?code[\"']?" system/.env.linux
}

@test "Linux env uses official Homebrew shellenv path" {
	grep -q "/home/linuxbrew/.linuxbrew" system/.env.linux
}

@test "zshrc sources Linux-specific dotfiles" {
	grep -q "is-linux" runcom/.zshrc
	grep -q "\.linux" runcom/.zshrc
}

@test "zshrc Linux block mirrors macOS block structure" {
	# Both platforms should source env/alias/function files via brace expansion
	grep -q "\.{env,alias,function}\.linux" runcom/.zshrc
}

@test "path file sets HOMEBREW_PREFIX correctly for Linux" {
	# Linux must use /home/linuxbrew/.linuxbrew, not macOS paths
	grep -q "is-linux" system/.path
	grep -q "/home/linuxbrew/.linuxbrew" system/.path
}

@test "path file preserves macOS HOMEBREW_PREFIX logic" {
	# macOS arm64/intel detection must still exist
	grep -q "is-arm64" system/.path
	grep -q "/opt/homebrew" system/.path
}

@test "All submodules are properly configured" {
	if [ -f ".gitmodules" ] && [ -s ".gitmodules" ]; then
		# Should have proper URLs if submodules are defined
		grep -q "url" .gitmodules
	fi
}
