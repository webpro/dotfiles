# .files

## Install

    git clone https://github.com/webpro/dotfiles.git
    source dotfiles/install.sh

## Remote Install

You can also install from remote without Git:

    sh -c "`curl -fsSL https://raw.github.com/webpro/dotfiles/master/remote-install.sh`"

This will install the dotfiles in `~/.dotfiles`.

## Update

Just run:

	update

## Reload

You can use `reload` to "reload" the shell by sourcing `.bash_profile` again (i.e. no need to restart shell or something).

    reload

## Apply OS X Defaults

Source `osxdefaults.sh`, e.g.:

    source ~/.dotfiles/osxdefaults.sh

## Custom settings

You can put your custom settings, such as Git credentials in the `system/.custom` file which will be sourced from `.bash_profile` (i.e. when opening console). This file is in `.gitignore`.

## Credits

Many thanks to the [dotfiles community](http://dotfiles.github.io/), especially [Jan Moesen](https://github.com/janmoesen) and [Mathias Bynens](https://github.com/mathiasbynens).

## Resources

* [Homebrew](http://brew.sh/), [update](https://github.com/mxcl/homebrew/wiki/FAQ#how-do-i-update-my-local-packages)
* [brew-cask](https://github.com/phinze/homebrew-cask), [usage]((https://github.com/phinze/homebrew-cask/blob/master/USAGE.md))
* [Bash prompt](http://wiki.archlinux.org/index.php/Color_Bash_Prompt)
* [hub](http://hub.github.com/) for Git
