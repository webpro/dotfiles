brew install nvm

nvm install 5
nvm use 5
nvm alias default 5

# Globally install with npm

packages=(
  diff-so-fancy
  grunt
  gulp
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
