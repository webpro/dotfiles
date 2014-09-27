# Install Homebrew & brew-cask

ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
brew tap caskroom/cask
brew install brew-cask
brew tap caskroom/versions

# Install brew & brew-cask packages

brew bundle "$DOTFILES_DIR/Brewfile"
brew bundle "$DOTFILES_DIR/Caskfile"

# Configure bash (installed with brew)

grep "/usr/local/bin/bash" /private/etc/shells &>/dev/null || sudo bash -c "echo /usr/local/bin/bash >> /private/etc/shells"
chsh -s /usr/local/bin/bash

# Install Ruby gems (SASS, Compass)

sudo gem install compass
sudo gem install lunchy
sudo gem install pygmentize
sudo gem install sass
sudo gem install sass-globbing

# Globally install with npm

npm install -g bower
npm install -g grunt
npm install -g gulp
npm install -g http-server
npm install -g nodemon
npm install -g tldr
npm install -g spot
npm install -g svgo
npm install -g vtop

# Setup Mjolnir

luarocks install mjolnir.hotkey
luarocks install mjolnir.application
ln -sfv "$DOTFILES_DIR/etc/mjolnir" ~/.mjolnir

# http://www.sublimetext.com/docs/3/osx_command_line.html
[ -f ~/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl ] && ln -sfv ~/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl "$DOTFILES_DIR/bin/subl"

