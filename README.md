# .files

These are my dotfiles. Take anything you want, but at your own risk.

It targets macOS systems, but it should work on *nix as well (tested on a few Linux boxes and Ubuntu 16).

## Package overview

* Core
  * Bash + [coreutils](https://en.wikipedia.org/wiki/GNU_Core_Utilities) + bash-completion
  * [Homebrew](https://brew.sh) + [homebrew-cask](https://caskroom.github.io)
  * Node.js + npm
  * `$EDITOR` (and Git editor) is [GNU nano](https://www.nano-editor.org)
  * GNU [sed](https://www.gnu.org/software/sed/), [grep](https://www.gnu.org/software/grep/), [Wget](https://www.gnu.org/software/wget/)
  * [fasd](https://github.com/clvv/fasd), [fkill-cli](https://github.com/sindresorhus/fkill-cli), [gtop](https://github.com/aksakalli/gtop), [psgrep](https://github.com/jvz/psgrep/blob/master/psgrep), [spot](https://github.com/rauchg/spot), [tree](http://mama.indstate.edu/users/ice/tree/), [unar](https://theunarchiver.com/command-line)
  * Git + [SourceTree](https://www.sourcetreeapp.com) + [hub](https://hub.github.com)
  * [rvm](https://rvm.io) (Ruby v2.5)
  * Python 2 + 3 (`python/pip`, `python3/pip3`)
* Development (Node/JS/JSON): [jq](https://stedolan.github.io/jq), [nodemon](https://nodemon.io), [peco](https://peco.github.io), [Prettier](https://prettier.io), [superstatic](https://github.com/firebase/superstatic), [underscore-cli](https://github.com/ddopson/underscore-cli)
* Graphics: [ffmpeg](https://www.ffmpeg.org), [imagemagick](https://www.imagemagick.org), [svgo](https://github.com/svg/svgo)
* macOS: [dockutil](https://github.com/kcrawford/dockutil), [Hammerspoon](https://www.hammerspoon.org), [Mackup](https://github.com/lra/mackup), [Quick Look plugins](https://github.com/sindresorhus/quick-look-plugins)
* [macOS apps](https://github.com/webpro/dotfiles/blob/master/install/brew-cask.sh)

## Install

On a sparkling fresh installation of macOS:

    sudo softwareupdate -i -a
    xcode-select --install

Install the dotfiles with either Git or curl:

### Clone with Git

    git clone https://github.com/webpro/dotfiles.git ~/.dotfiles
    source ~/.dotfiles/install.sh

### Remotely install using curl

Alternatively, you can install this into `~/.dotfiles` remotely without Git using curl:

    bash -c "`curl -fsSL https://raw.githubusercontent.com/webpro/dotfiles/master/remote-install.sh`"

Or, using wget:

    bash -c "`wget -O - --no-check-certificate https://raw.githubusercontent.com/webpro/dotfiles/master/remote-install.sh`"

## The `dotfiles` command

    $ dotfiles help
    Usage: dotfiles <command>

    Commands:
       clean            Clean up caches (brew, npm, gem, rvm)
       dock             Apply macOS Dock settings
       edit             Open dotfiles in IDE (code) and Git GUI (stree)
       help             This help message
       macos            Apply macOS system defaults
       test             Run tests
       update           Update packages and pkg managers (OS, brew, npm, gem)

## Customize/extend

You can put your custom settings, such as Git credentials in the `system/.custom` file which will be sourced from `.bash_profile` automatically. This file is in `.gitignore`.

Alternatively, you can have an additional, personal dotfiles repo at `~/.extra`.

* The installer (`install.sh`) will run `~/.extra/install.sh`.
* The runcom `.bash_profile` sources all `~/.extra/runcom/*.sh` files.

## Additional resources

* [Awesome Dotfiles](https://github.com/webpro/awesome-dotfiles)
* [Homebrew](https://brew.sh)
* [Homebrew Cask](http://caskroom.io)
* [Bash prompt](https://wiki.archlinux.org/index.php/Color_Bash_Prompt)
* [Solarized Color Theme for GNU ls](https://github.com/seebi/dircolors-solarized)

## Credits

Many thanks to the [dotfiles community](https://dotfiles.github.io).
