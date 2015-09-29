# Update Homebrew, formulae, and packages

brew update
brew upgrade

# Install packages

apps=(
    bash-completion2
    bats
    coreutils
    dockutil
    ffmpeg
    fasd
    gifsicle
    git
    gnu-sed --default-names
    grep --default-names
    hub
    httpie
    imagemagick
    jq
    mackup
    node
    peco
    phantomjs
    psgrep
    python
    shellcheck
    ssh-copy-id
    svn
    tree
    vim
    wget
)

brew install "${apps[@]}"

# Git comes with diff-highlight, but isn't in the PATH
ln -sf "$(brew --prefix)/share/git-core/contrib/diff-highlight/diff-highlight" /usr/local/bin/diff-highlight
