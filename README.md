# .files

## Install

    git clone https://github.com/webpro/dotfiles.git
    source dotfiles/install.sh

Just re-run `source install.sh` to update.

## OS X Defaults

    source osxdefaults.sh

## Warning

If you would use or fork this, you'll want to put at least `user.name`, `user.email` in `~/.gitconfig.user`.

Any file in the `system/` folder will be evaluated when starting a terminal session, so that's where customizations like paths, functions, and aliases go.

## Credits

Many thanks to the [dotfiles community](http://dotfiles.github.io/), especially [Jan Moesen](https://github.com/janmoesen) and [Mathias Bynens](https://github.com/mathiasbynens).

## Resources

* [Homebrew](http://brew.sh/), [update](https://github.com/mxcl/homebrew/wiki/FAQ#how-do-i-update-my-local-packages)
* [brew-cask](https://github.com/phinze/homebrew-cask), [usage]((https://github.com/phinze/homebrew-cask/blob/master/USAGE.md))
* [Bash prompt](http://wiki.archlinux.org/index.php/Color_Bash_Prompt)
* [hub](http://hub.github.com/) for Git
* ["Confirm" function](https://gist.github.com/davejamesmiller/1965569)
