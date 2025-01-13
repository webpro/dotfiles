# .files

These are my dotfiles. Take anything you want, but at your own risk.

It mainly targets macOS systems (should install on e.g. Ubuntu as well for many tools, config and aliases etc).

## Highlights

- Minimal efforts to install everything, using a [Makefile](./Makefile)
- Mostly based around Homebrew, Caskroom and Node.js, latest Bash + GNU Utils
- Fast and colored prompt
- Updated macOS defaults
- Well-organized and easy to customize
- The installation and runcom setup is
  [tested weekly on real Ubuntu and macOS machines](https://github.com/webpro/dotfiles/actions)
  (Ventura/13, Sonomo/14, Sequoia/15) using [a GitHub Action](./.github/workflows/dotfiles-installation.yml)
- Supports both Apple Silicon (M1) and Intel chips

## Packages Overview

- [Homebrew](https://brew.sh) (packages: [Brewfile](./install/Brewfile))
- [homebrew-cask](https://github.com/Homebrew/homebrew-cask) (packages: [Caskfile](./install/Caskfile))
- [Node.js + npm LTS](https://nodejs.org/en/download/) (packages: [npmfile](./install/npmfile))
- Latest Git, Bash, Python, GNU coreutils, curl, Ruby
- `$EDITOR` is [GNU nano](https://www.nano-editor.org) (`$VISUAL` is `code` and Git `core.editor` is `code --wait`)

## Installation

On a sparkling fresh installation of macOS:

```bash
sudo softwareupdate -i -a
xcode-select --install
```

The Xcode Command Line Tools includes `git` and `make` (not available on stock macOS). Now there are two options:

1. Install this repo with `curl` available:

```bash
bash -c "`curl -fsSL https://raw.githubusercontent.com/webpro/dotfiles/master/remote-install.sh`"
```

This will clone or download this repo to `~/.dotfiles` (depending on the availability of `git`, `curl` or `wget`).

1. Alternatively, clone manually into the desired location:

```bash
git clone https://github.com/webpro/dotfiles.git ~/.dotfiles
```

2. Use the [Makefile](./Makefile) to install the [packages listed above](#packages-overview), and symlink
   [runcom](./runcom) and [config](./config) files (using [stow](https://www.gnu.org/software/stow/)):

```bash
cd ~/.dotfiles
make
```

Running `make` with the Makefile is idempotent. The installation process in the Makefile is tested on every push and every week in this
[GitHub Action](https://github.com/webpro/dotfiles/actions). Please file an issue in this repo if there are errors.

## Post-Installation

1. Set your Git credentials:

```sh
git config --global user.name "your name"
git config --global user.email "your@email.com"
git config --global github.user "your-github-username"
```

2. Set macOS [Dock items](./macos/dock.sh) and [system defaults](./macos/defaults.sh):

```sh
dot dock
dot macos
```

3. Populate this file with tokens (example: `export GITHUB_TOKEN=abc`):

```sh
touch ~/.dotfiles/system/.exports
```

## The `dot` command

```
$ dot help
Usage: dot <command>

Commands:
   clean            Clean up caches (brew, cargo, gem, pip)
   dock             Apply macOS Dock settings
   edit             Open dotfiles in IDE ($VISUAL) and Git GUI ($VISUAL_GIT)
   help             This help message
   macos            Apply macOS system defaults
   test             Run tests
   update           Update packages and pkg managers (brew, casks, cargo, pip3, npm, gems, macOS)
```

## Customize

To customize the dotfiles to your likings, fork it and [be the king of your castle!](https://www.webpro.nl/articles/getting-started-with-dotfiles)

## Credits

Many thanks to the [dotfiles community](https://dotfiles.github.io).
