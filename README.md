# .files

## Install

On a sparkling fresh installation of OS X:

    sudo softwareupdate -i -a
    xcode-select --install

Install the dotfiles with either Git or curl:

### Clone with Git

    git clone https://github.com/webpro/dotfiles.git
    source dotfiles/install.sh

### Remotely install using curl

Alternatively, you can install this into `~/.dotfiles` from remote without Git using curl:

    sh -c "`curl -fsSL https://raw.github.com/webpro/dotfiles/master/remote-install.sh`"

## The `dotfiles` command

    $ dotfiles help
    Usage: dotfiles <command>

    Commands:
       help        This help message
       edit        Open dotfiles in default editor (atom) and Git GUI (stree)
       reload      Reload dotfiles
       update      Update OS X Applications, Homebrew (cask), npm, and Ruby packages
       osx         Apply OS X system defaults
       dock        Apply OS X Dock settings

## Custom settings

You can put your custom settings, such as Git credentials in the `system/.custom` file which will be sourced from `.bash_profile` automatically. This file is in `.gitignore`.

## Some installed packages

* [dockutil](https://github.com/kcrawford/dockutil)
* [hub](http://hub.github.com/)
* [http-server](https://github.com/nodeapps/http-server)
* [Hydra](https://github.com/sdegutis/hydra)
* [jq](http://stedolan.github.io/jq/)
* [peco](http://peco.github.io/)
* [Quick Look plugins](https://github.com/sindresorhus/quick-look-plugins)
* [spot](https://github.com/guille/spot)
* [tldr](https://github.com/tldr-pages/tldr)
* [svgo](https://github.com/svg/svgo)

## Not or barely installable from CLI

* [Downloads for Apple Developers](https://developer.apple.com/downloads), including:
    * Command Line Tools for XCode
    * Hardware IO Tools for XCode (includes Network Link Conditioner)
* [An OS X Yosemite Theme for Alfred](http://blog.alfredapp.com/2014/06/12/an-os-x-yosemite-theme-for-alfred/)

## Additional resources

* [Awesome Dotfiles](https://github.com/webpro/awesome-dotfiles)
* [Homebrew](http://brew.sh/) ([FAQ](https://github.com/Homebrew/homebrew/wiki/FAQ))
* [homebrew-cask](http://caskroom.io/) ([usage]((https://github.com/phinze/homebrew-cask/blob/master/USAGE.md))
* [Bash prompt](http://wiki.archlinux.org/index.php/Color_Bash_Prompt)

## Credits

Many thanks to the [dotfiles community](http://dotfiles.github.io/) and the creators of the incredibly useful tools.
