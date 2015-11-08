brew install nvm

nvm install 0.12
nvm use 0.12
nvm alias default 0.12

# Globally install with npm

packages=(
    grunt
    gulp
    http-server
    nodemon
    release-it
    spot
    svgo
    tldr
    underscore
    vtop
)

npm install -g "${packages[@]}"
