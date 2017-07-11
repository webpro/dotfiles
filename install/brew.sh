if ! is-executable ruby -o ! is-executable curl -o ! is-executable git; then
  echo "Skipped: Homebrew (not found: ruby, curl and/or git)"
  return
fi

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

if ! is-executable brew; then
  echo "Skipping: Homebrew packages (not found: brew)"
  return
fi

brew tap homebrew/versions
brew tap homebrew/dupes
brew tap Goles/battery
brew update
brew upgrade

# Install packages

apps=(
  bash-completion2
  bats
  battery
  coreutils
  diff-so-fancy
  dockutil
  ffmpeg
  fasd
  gifsicle
  git
  git-extras
  gnu-sed --with-default-names
  grep --with-default-names
  hub
  httpie
  imagemagick
  jq
  lynx
  mackup
  pandoc
  peco
  psgrep
  python
  shellcheck
  ssh-copy-id
  tree
  wget
  wifi-password
)

brew install "${apps[@]}"

export BREW_PREFIX_COREUTILS=`brew --prefix coreutils`
set-config "BREW_PREFIX_COREUTILS" "$BREW_PREFIX_COREUTILS" "$DOTFILES_CACHE"
