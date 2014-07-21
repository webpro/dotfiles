# .files

## Install

### Clone with Git

    git clone https://github.com/webpro/dotfiles.git
    source dotfiles/install.sh

### Remote with curl

You can also install this into `~/.dotfiles` from remote without Git:

    sh -c "`curl -fsSL https://raw.github.com/webpro/dotfiles/master/remote-install.sh`"

## Update

To update installed OS X apps, brew packages, npm packages, and gems:

	update

## Reload

Reloading the dotfiles will source `.bash_profile` again (i.e. no need to restart shell or something):

    reload

## Apply OS X Defaults

Source `osxdefaults.sh`, e.g.:

    source ~/.dotfiles/osxdefaults.sh

## Custom settings

You can put your custom settings, such as Git credentials in the `system/.custom` file which will be sourced from `.bash_profile` automatically. This file is in `.gitignore`.

## Credits

Many thanks to the [dotfiles community](http://dotfiles.github.io/), especially [Jan Moesen](https://github.com/janmoesen) and [Mathias Bynens](https://github.com/mathiasbynens).

## Resources

* [Awesome Dotfiles](https://github.com/webpro/awesome-dotfiles)
* [Homebrew](http://brew.sh/) ([FAQ](https://github.com/Homebrew/homebrew/wiki/FAQ))
* [brew-cask](https://github.com/phinze/homebrew-cask) ([usage]((https://github.com/phinze/homebrew-cask/blob/master/USAGE.md))
* [Bash prompt](http://wiki.archlinux.org/index.php/Color_Bash_Prompt)
* [hub](http://hub.github.com/) for Git
