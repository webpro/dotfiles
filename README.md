# .files

These are my dotfiles. Take anything you want, but at your own risk.

Mainly targets macOS systems, but works on Ubuntu and Arch Linux as well.

## Highlights

- Minimal efforts to install everything, using a [Makefile](./Makefile)
- Mostly based around Homebrew, Caskroom and Node.js, latest Bash + GNU Utils
- Fast and colored prompt
- Updated macOS defaults
- Well-organized and easy to customize
- The installation and runcom setup is
  [tested weekly on real Ubuntu and macOS machines](https://github.com/webpro/dotfiles/actions)
  (Sonoma/14, Sequoia/15, Tahoe/26) using [a GitHub Action](./.github/workflows/dotfiles-installation.yml)
- Supports both Apple Silicon (M1) and Intel chips

## Packages Overview

- [Homebrew](https://brew.sh) (packages: [Brewfile](./install/Brewfile))
- [homebrew-cask](https://github.com/Homebrew/homebrew-cask) (packages: [Caskfile](./install/Caskfile))
- [Node.js + npm LTS](https://nodejs.org/en/download/) (packages: [npmfile](./install/npmfile))
- Latest Git, Bash, Python, GNU coreutils, curl, Ruby
- Editors: VS Code and nano (`EDITOR`, `VISUAL` and Git `core.editor`)

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

1. Set your Git identity:

```sh
git config --global user.name "your name"
git config --global user.email "your@email.com"
git config --global github.user "your-github-username"
```

2. Authenticate [GitHub CLI](https://cli.github.com/manual/gh_auth_login):

```sh
gh auth login
```

3. Set macOS [Dock items](./macos/dock.sh) and [system defaults](./macos/defaults.sh):

```sh
dot dock
dot macos
```

4. Populate this file with anything you need sourced in each shell:

```sh
mkdir -p $DOTFILES_DIR/local
touch $DOTFILES_DIR/local/.profile
touch $DOTFILES_DIR/local/.env
```

## The `dot` command

```
$ dot help
Usage: dot <command>

Commands:
   clean            Clean up caches, logs, temporary files, and app leftovers
   dock             Apply macOS Dock settings
   duti             Set default apps for file types (UTI)
   edit             Open dotfiles in IDE (code) and Git GUI (fork)
   help             This help message
   macos            Apply macOS system defaults and optional system setup
   test             Run tests
   update           Update packages and pkg managers (e.g. Homebrew, npm, gems)
```

## Customize

To customize the dotfiles to your likings, fork it and [be the king of your castle!](https://www.webpro.nl/articles/getting-started-with-dotfiles)

## Credits

Many thanks to the [dotfiles community](https://dotfiles.github.io).
