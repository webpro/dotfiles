DOTFILES_DIR := $(CURDIR)
# Detect OS: macos, linux, or wsl
IS_WSL := $(shell bin/is-wsl && echo true || echo false)
ifeq ($(IS_WSL),true)
	OS := wsl
else
	OS := $(shell bin/is-supported bin/is-macos macos linux)
endif
HOMEBREW_PREFIX := $(shell bin/is-supported bin/is-macos $(shell bin/is-supported bin/is-arm64 /opt/homebrew /usr/local) /home/linuxbrew/.linuxbrew)
export N_PREFIX = $(HOME)/.n
PATH := $(HOMEBREW_PREFIX)/bin:$(DOTFILES_DIR)/bin:$(N_PREFIX)/bin:$(PATH)
export PATH
SHELL := /bin/bash
SHELLS := /private/etc/shells
BIN := $(HOMEBREW_PREFIX)/bin
export XDG_CONFIG_HOME = $(HOME)/.config
export STOW_DIR = $(DOTFILES_DIR)
export ACCEPT_EULA=Y

.PHONY: test

all: $(OS)

macos: sudo core-macos packages link duti bun

linux: core-linux brew-linux packages-linux link chsh-linux bun

wsl: core-wsl link bun

core-macos: brew git npm

core-linux:
	sudo apt-get update
	sudo apt-get upgrade -y
	sudo apt-get dist-upgrade -f
	sudo apt-get install -y zsh curl git build-essential procps

brew-linux:
	@is-executable brew || NONINTERACTIVE=1 /bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

packages-linux: brew-linux
	brew bundle --file=$(DOTFILES_DIR)/install/Serverfile || true

chsh-linux:
	@if [ "$$SHELL" != "$$(which zsh)" ]; then \
		echo "→ Changing default shell to zsh..."; \
		sudo chsh -s $$(which zsh) $$USER; \
	else \
		echo "→ zsh is already the default shell"; \
	fi

core-wsl:
	@echo "→ Setting up WSL2 environment..."
	@echo "→ Installing essential packages..."
	sudo apt-get update
	sudo apt-get upgrade -y
	sudo apt-get install -y build-essential curl git
	@echo "→ Installing Homebrew for Linux..."
	@is-executable brew || /bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

stow-macos: brew
	is-executable stow || brew install stow

stow-linux: packages-linux
	@is-executable stow || brew install stow

stow-wsl:
	@is-executable stow || brew install stow

sudo:
ifndef GITHUB_ACTION
	sudo -v
	while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
endif

packages: brew-packages cask-apps mas-apps node-packages rust-packages

submodules:
	git submodule update --init --recursive

link: stow-$(OS) submodules
	@echo "→ Backing up existing runcom files..."
	@find runcom -mindepth 1 -maxdepth 1 -print0 | while IFS= read -r -d '' FILE; do \
		TARGET="$(HOME)/$${FILE##*/}"; \
		if [ -f "$$TARGET" ] && [ ! -h "$$TARGET" ]; then \
			mv -v "$$TARGET" "$$TARGET.bak"; \
		fi; \
	done
	@echo "→ Creating config directory..."
	@mkdir -p "$(XDG_CONFIG_HOME)"
	@echo "→ Backing up existing config directories..."
	@find config -mindepth 1 -maxdepth 1 -print0 | while IFS= read -r -d '' FILE; do \
		TARGET="$(XDG_CONFIG_HOME)/$${FILE##*/}"; \
		if [ -e "$$TARGET" ] && [ ! -h "$$TARGET" ]; then \
			mv -v "$$TARGET" "$$TARGET.bak"; \
		fi; \
	done
	@echo "→ Backing up existing SSH config..."
	@if [ -f "$(HOME)/.ssh/config" ] && [ ! -h "$(HOME)/.ssh/config" ]; then \
		mv -v "$(HOME)/.ssh/config" "$(HOME)/.ssh/config.bak"; \
	fi
	@mkdir -p "$(HOME)/.ssh"
	@chmod 700 "$(HOME)/.ssh"
	@echo "→ Symlinking runcom files to home directory..."
	@stow -t "$(HOME)" runcom
	@echo "→ Symlinking SSH config..."
	@stow -t "$(HOME)" ssh
	@echo "→ Symlinking config files to ~/.config..."
	@stow -t "$(XDG_CONFIG_HOME)" config
	@echo "→ Creating runtime directory..."
	@mkdir -p $(HOME)/.local/runtime
	@chmod 700 $(HOME)/.local/runtime
	@echo "→ Creating Programming symlink..."
	@if [ -d "$(HOME)/Documents/02 Areas/02 Programming" ]; then \
		ln -sfn "$(HOME)/Documents/02 Areas/02 Programming" "$(HOME)/Programming"; \
		echo "✓ Programming symlink created"; \
	else \
		echo "⚠ Warning: Programming directory not found at ~/Documents/02 Areas/02 Programming"; \
	fi
	@echo "✓ Dotfiles linked successfully!"

unlink: stow-$(OS)
	@echo "→ Removing Programming symlink..."
	@if [ -L "$(HOME)/Programming" ]; then \
		rm -v "$(HOME)/Programming"; \
	fi
	@echo "→ Removing runcom symlinks..."
	@stow --delete -t "$(HOME)" runcom
	@echo "→ Removing SSH config symlink..."
	@stow --delete -t "$(HOME)" ssh
	@echo "→ Removing config symlinks..."
	@stow --delete -t "$(XDG_CONFIG_HOME)" config
	@echo "→ Restoring runcom backups..."
	@find runcom -mindepth 1 -maxdepth 1 -print0 | while IFS= read -r -d '' FILE; do \
		TARGET="$(HOME)/$${FILE##*/}"; \
		if [ -f "$$TARGET.bak" ]; then \
			mv -v "$$TARGET.bak" "$$TARGET"; \
		fi; \
	done
	@echo "→ Restoring config backups..."
	@find config -mindepth 1 -maxdepth 1 -print0 | while IFS= read -r -d '' FILE; do \
		TARGET="$(XDG_CONFIG_HOME)/$${FILE##*/}"; \
		if [ -e "$$TARGET.bak" ]; then \
			mv -v "$$TARGET.bak" "$$TARGET"; \
		fi; \
	done
	@echo "✓ Dotfiles unlinked and backups restored!"

brew:
	is-executable brew || curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash

git: brew
	brew install git git-extras

npm: brew-packages
	n install lts

brew-packages: brew
	brew bundle --file=$(DOTFILES_DIR)/install/Brewfile || true

cask-apps: brew
	brew bundle --file=$(DOTFILES_DIR)/install/Caskfile || true

mas-apps: brew-packages
	brew bundle --file=$(DOTFILES_DIR)/install/Masfile || true

vscode-extensions: cask-apps
	for EXT in $$(cat install/Codefile); do code --install-extension $$EXT; done

node-packages: npm
	$(N_PREFIX)/bin/npm install --force --location global $(shell cat install/npmfile)

rust-packages: brew-packages
	@if [ -s "$(DOTFILES_DIR)/install/Rustfile" ]; then \
		cargo install $$(cat install/Rustfile); \
	else \
		echo "→ Rustfile is empty, skipping cargo installs"; \
	fi

duti:
	duti -v $(DOTFILES_DIR)/install/duti

bun:
  curl -fsSL https://bun.sh/install | bash

test:
	@echo "→ Running dotfiles test suite..."
	@if command -v bats >/dev/null 2>&1; then \
		./test/run-tests.sh; \
	else \
		echo "✗ bats not found. Install it first:"; \
		echo "  macOS:  brew install bats-core"; \
		echo "  Linux:  sudo apt-get install bats"; \
		exit 1; \
	fi

test-quick:
	@echo "→ Running quick tests (bin + platform only)..."
	@bats test/bin.bats test/platform.bats

test-symlinks:
	@echo "→ Testing symlink configuration..."
	@bats test/symlinks.bats

test-packages:
	@echo "→ Testing package installations..."
	@bats test/packages.bats

test-compatibility:
	@echo "→ Testing cross-platform compatibility..."
	@bats test/compatibility.bats

test-makefile:
	@echo "→ Testing Makefile targets..."
	@bats test/makefile.bats
