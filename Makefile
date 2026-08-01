DOTFILES_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
export XDG_CONFIG_HOME = $(HOME)/.config

install: install-minimal install-extra
install-minimal: sudo core packages link quartz-filters plannotator claude-skills
install-extra: brew-packages-extra cask-apps-extra

sudo:
	sudo -v
	while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

#
# CORE
#
core: brew zsh git fnm node

brew:
	brew || curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | bash

zsh: sudo
	brew install zsh
# List Homebrew zsh as a possible shell
	echo "\n/opt/homebrew/bin/zsh" | sudo tee -a /etc/shells
# Make zsh default shell
	chsh -s /opt/homebrew/bin/zsh
# Create zsh config file if necessary
	touch ~/.zshrc
	rm -rf ~/.oh-my-zsh
	brew || curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh | bash
# Install zsh-autosuggestions plugin
	[ -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ] || \
		git clone https://github.com/zsh-users/zsh-autosuggestions \
			~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

git:
	brew install git git-extras

fnm:
	brew install fnm

node:
	fnm install --lts

#
# PACKAGES
#
packages: brew-packages cask-apps

brew-packages:
	brew bundle --file=$(DOTFILES_DIR)/install/Brewfile --no-upgrade

brew-packages-extra:
	brew bundle --file=$(DOTFILES_DIR)/install/Brewfile.extra --no-upgrade

cask-apps:
	brew bundle --file=$(DOTFILES_DIR)/install/Caskfile --no-upgrade

cask-apps-extra:
	brew bundle --file=$(DOTFILES_DIR)/install/Caskfile.extra --no-upgrade

#
# LINK
#
link: sudo
	for FILE in $$(\ls -A runcom); do if [ -f $(HOME)/$$FILE -a ! -h $(HOME)/$$FILE ]; then \
		mv -v $(HOME)/$$FILE{,.bak}; fi; done
	mkdir -p $(XDG_CONFIG_HOME)
	# Create an untracked zsh config file (for machine-specific setups)
	touch ./runcom/.oh-my-zsh/custom/local.untracked.zsh
	# Create an untracked git config file (for machine-specific setups)
	touch ./config/git/config.untracked
	stow -t $(HOME) runcom
	stow -t $(XDG_CONFIG_HOME) config

unlink:
	stow --delete -t $(HOME) runcom
	stow --delete -t $(XDG_CONFIG_HOME) config
	for FILE in $$(\ls -A runcom); do if [ -f $(HOME)/$$FILE.bak ]; then \
		mv -v $(HOME)/$$FILE.bak $(HOME)/$${FILE%%.bak}; fi; done

quartz-filters:
	cp -a ./install/pdf-quartz-filters ~/Library/Filters

#
# PLANNOTATOR
#
# Not on Homebrew, so it can't live in a Brewfile/Caskfile — installed via the
# official script (same curl-pipe-bash pattern as `brew`/oh-my-zsh above). The
# standard install also checks out its Claude Code skills into ~/.claude/skills
# and wires the plan hook, so no separate skills step is needed. Binary lands in
# ~/.local/bin (already on PATH via runcom/.zshrc). --non-interactive skips the
# extras/model-invocable prompts for a reproducible install; re-run
# `plannotator --reconfigure` by hand to change those. Runs after `packages` so
# the claude-code cask exists for the installer's agent integration.
plannotator:
	curl -fsSL https://plannotator.ai/install.sh | bash -s -- --non-interactive

#
# CLAUDE CODE SKILLS & PLUGINS
#
# Agent skills/plugins aren't dotfiles to track — they're generated artifacts
# (like plannotator's skills), so we (re)install them from source instead of
# vendoring them. Everything lands under ~/.claude (or $CLAUDE_CONFIG_DIR).
# Grouped after `packages` so the `claude` CLI (claude-code cask) and node exist.
CLAUDE_SKILLS_DIR := $(if $(CLAUDE_CONFIG_DIR),$(CLAUDE_CONFIG_DIR),$(HOME)/.claude)/skills

claude-skills: superpowers mcollina-skills playwright-skills

# obra/superpowers is a real Claude Code plugin (hooks, /brainstorm, SessionStart
# injection), so it goes through the plugin CLI rather than being copied as loose
# skills. `marketplace add` is made idempotent so re-runs don't fail; the first
# install may prompt once to trust the marketplace — answer it interactively.
superpowers:
	claude plugin marketplace add obra/superpowers-marketplace || true
	claude plugin install superpowers@superpowers-marketplace --scope user

# mcollina/skills is a plain skills folder (dirs with SKILL.md, no plugin
# manifest), so the plugin CLI can't consume it — shallow-clone and copy the
# skills into place. Re-running refreshes them to the latest commit.
mcollina-skills:
	mkdir -p "$(CLAUDE_SKILLS_DIR)"
	tmp=$$(mktemp -d) && \
		git clone --depth 1 https://github.com/mcollina/skills "$$tmp" && \
		cp -R "$$tmp"/skills/. "$(CLAUDE_SKILLS_DIR)/" && \
		rm -rf "$$tmp"

# @playwright/cli installs its own Claude Code skill via `install --skills`
# (lands in ~/.claude/skills/playwright-cli).
playwright-skills:
	npm install -g @playwright/cli@latest
	playwright-cli install --skills

# Stow test commands:
# stow --adopt -nvSt ~ runcom
# stow --adopt -nvSt ~ config
