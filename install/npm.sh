if ! is-executable brew -o ! is-executable git; then
  echo "Skipped: npm (missing: brew and/or git)"
  return
fi

brew install nvm

export BREW_PREFIX_NVM=`brew --prefix nvm`
set-config "BREW_PREFIX_NVM" "$BREW_PREFIX_NVM" "$DOTFILES_CACHE"

. "${DOTFILES_DIR}/system/.nvm"
nvm install 6

# Globally install with npm

packages=(
  get-port-cli
  nodemon
  release-it
  spot
  superstatic
  svgo
  tldr
  underscore-cli
  vtop
)

npm install -g "${packages[@]}"
