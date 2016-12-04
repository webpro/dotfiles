brew install nvm

nvm install 6
nvm use 6
nvm alias default 6

# Globally install with npm

packages=(
  diff-so-fancy
  http-server
  nodemon
  release-it
  spot
  svgo
  tldr
  underscore-cli
  vtop
)

npm install -g "${packages[@]}"
