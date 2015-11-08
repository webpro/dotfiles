# Install Homebrew

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap homebrew/versions
brew tap homebrew/dupes
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
    gnu-sed --with-default-names
    grep --with-default-names
    hub
    httpie
    imagemagick
    jq
    mackup
    peco
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
