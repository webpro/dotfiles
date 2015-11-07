gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable

rvm install 2.1
rvm use 2.1

gem install consular
gem install consular-osx
gem install lunchy
gem install pygmentize
