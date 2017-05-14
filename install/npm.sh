if ! is-executable brew -o ! is-executable git; then
  echo "Skipped: npm (missing: brew and/or git)"
  return
fi

brew install nvm
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
