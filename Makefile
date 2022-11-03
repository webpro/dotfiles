DOTFILES_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
NVM_DIR := $(HOME)/.nvm
export XDG_CONFIG_HOME = $(HOME)/.config

install: install-minimal install-extra
install-minimal: sudo core packages link quartz-filters
install-extra: cask-apps-extra

sudo:
	sudo -v
	while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

#
# CORE
#
core: brew zsh git npm

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

git:
	brew install git git-extras

# Consider switching to fnm
npm:
	if ! [ -d $(NVM_DIR)/.git ]; then git clone https://github.com/creationix/nvm.git $(NVM_DIR); fi
	. $(NVM_DIR)/nvm.sh; nvm install --lts

#
# PACKAGES
#
packages: brew-packages cask-apps

brew-packages:
	brew bundle --file=$(DOTFILES_DIR)/install/Brewfile --no-upgrade

cask-apps:
	brew bundle --file=$(DOTFILES_DIR)/install/Caskfile --no-upgrade

cask-apps-extra:
	brew bundle --file=$(DOTFILES_DIR)/install/Caskfile.extra --no-upgrade

node-packages: npm
	. $(NVM_DIR)/nvm.sh; npm install -g $(shell cat install/npmfile)

#
# LINK
#
stow:
	stow || brew install stow

link: sudo
	for FILE in $$(\ls -A runcom); do if [ -f $(HOME)/$$FILE -a ! -h $(HOME)/$$FILE ]; then \
		mv -v $(HOME)/$$FILE{,.bak}; fi; done
	mkdir -p $(XDG_CONFIG_HOME)
	# Create an untracked zsh config file (for machine-specific setups)
	touch ./runcom/.oh-my-zsh/custom/local.untracked.zsh
	stow -t $(HOME) runcom
	stow -t $(XDG_CONFIG_HOME) config

unlink:
	stow --delete -t $(HOME) runcom
	stow --delete -t $(XDG_CONFIG_HOME) config
	for FILE in $$(\ls -A runcom); do if [ -f $(HOME)/$$FILE.bak ]; then \
		mv -v $(HOME)/$$FILE.bak $(HOME)/$${FILE%%.bak}; fi; done

quartz-filters:
	cp -a ./install/pdf-quartz-filters ~/Library/Filters

# Stow test commands:
# stow --adopt -nvSt ~ runcom
# stow --adopt -nvSt ~ config
