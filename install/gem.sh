if ! is-macos -o ! is-executable brew; then
  echo "Skipped: gem"
  return
fi

brew install gpg2

\curl -sSL https://get.rvm.io | bash -s stable

rvm install 2.3
rvm use 2.3 --default

gem install lunchy
gem install pygmentize
