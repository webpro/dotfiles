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
