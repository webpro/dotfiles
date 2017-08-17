# .files

These are my dotfiles. Take anything you want, but at your own risk.

It targets macOS systems, but it should work on *nix as well (tested on a few Linux boxes and Ubuntu 16).

## Package overview

* Core
  * Bash + [coreutils](https://en.wikipedia.org/wiki/GNU_Core_Utilities) + bash-completion
  * [Homebrew](https://brew.sh) + [homebrew-cask](https://caskroom.github.io)
  * Node.js + npm
  * GNU [sed](https://www.gnu.org/software/sed/), [grep](https://www.gnu.org/software/grep/), [Wget](https://www.gnu.org/software/wget/)
  * [fasd](https://github.com/clvv/fasd), [psgrep](https://github.com/jvz/psgrep/blob/master/psgrep), [pgrep](https://linux.die.net/man/1/pgrep), [spot](https://github.com/guille/spot), [tree](http://mama.indstate.edu/users/ice/tree/), [gtop](https://github.com/aksakalli/gtop)
  * Git + [SourceTree](https://www.sourcetreeapp.com) + [hub](https://hub.github.com)
  * [rvm](https://rvm.io) (Ruby 2.1), [lunchy](https://github.com/eddiezane/lunchy)
  * Python 2
  * `$EDITOR` and Git editor is [GNU nano](https://www.nano-editor.org)
* Development (Node/JS/JSON): [jq](https://stedolan.github.io/jq), [nodemon](https://nodemon.io), [peco](https://peco.github.io), [superstatic](https://github.com/firebase/superstatic), [underscore-cli](https://github.com/ddopson/underscore-cli)
* Graphics: [ffmpeg](https://www.ffmpeg.org), [gifsicle](https://www.lcdf.org/gifsicle), [imagemagick](https://www.imagemagick.org), [svgo](https://github.com/svg/svgo)
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

    bash -c "`curl -fsSL https://raw.github.com/webpro/dotfiles/master/remote-install.sh`"

Or, using wget:

    bash -c "`wget -O - --no-check-certificate https://raw.githubusercontent.com/webpro/dotfiles/master/remote-install.sh`"

## The `dotfiles` command

    $ dotfiles help
    Usage: dotfiles <command>
    
    Commands:
       clean            Clean up caches (brew, npm, gem, rvm)
       dock             Apply macOS Dock settings
       edit             Open dotfiles in IDE (ws) and Git GUI (stree)
       help             This help message
       macos            Apply macOS system defaults
       test             Run tests
       update           Update packages and pkg managers (OS, brew, npm, gem)

## Customize/extend

You can put your custom settings, such as Git credentials in the `system/.custom` file which will be sourced from `.bash_profile` automatically. This file is in `.gitignore`.

Alternatively, you can have an additional, personal dotfiles repo at `~/.extra`.

* The runcom `.bash_profile` sources all `~/.extra/runcom/*.sh` files.
* The installer (`install.sh`) will run `~/.extra/install.sh`.

## Additional resources

* [Awesome Dotfiles](https://github.com/webpro/awesome-dotfiles)
* [Homebrew](https://brew.sh)
* [homebrew-cask](https://caskroom.github.io) / [usage](https://github.com/phinze/homebrew-cask/blob/master/USAGE.md)
* [Bash prompt](https://wiki.archlinux.org/index.php/Color_Bash_Prompt)
* [Solarized Color Theme for GNU ls](https://github.com/seebi/dircolors-solarized)

## Credits

Many thanks to the [dotfiles community](https://dotfiles.github.io).
