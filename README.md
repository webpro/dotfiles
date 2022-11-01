# .files

These are my dotfiles. Take anything you want, but at your own risk.

Initially forked from https://github.com/webpro/dotfiles. It targets only macOS systems.

## Package overview

- [Homebrew](https://brew.sh) (packages: [Brewfile](./install/Brewfile))
- [homebrew-cask](https://caskroom.github.io) (packages: [Caskfile](./install/Caskfile))
- [Node.js + npm LTS](https://nodejs.org/en/download/) (packages: [npmfile](./install/npmfile))
- Latest Git, ZSH, GNU coreutils, curl

## Install

On a sparkling fresh installation of macOS:

```
sudo softwareupdate -i -a
xcode-select --install
```

The Xcode Command Line Tools includes `git` and `make` (not available on stock macOS).

Then, install this repo with `git` into the desired location:

```
git clone https://github.com/toomuchdesign/dotfiles.git ~/.dotfiles
```

Use the [Makefile](./Makefile) to install everything [listed above](#package-overview), and symlink [runcom](./runcom) and [config](./config) (using [stow](https://www.gnu.org/software/stow/)):

```
cd ~/.dotfiles
make
```

> If brew/cask **virtualbox** install fails go to `System Preferences > Security & Privacy > General`, and enable `Oracle` under `Allow apps downloaded from:`.

## Post-install

### iTerm

Set zsh as default shell

`Preferences` > `Profiles` > `General` > `Commands` > Set `Custom shell` + `/bin/zsh`

### DropBox

Login and sync DropBox.

### Chrome

Install the following extensions:

- [uBlock Origin](https://chrome.google.com/webstore/detail/ublock-origin/cjpalhdlnbpafiamejdnhcphjbkeiagm?hl=en)
- [EverSync](https://chrome.google.com/webstore/detail/eversync-sync-bookmarks-b/iohcojnlgnfbmjfjfkbhahhmppcggdog)
- [React Developer Tools](https://chrome.google.com/webstore/detail/react-developer-tools/fmkadmapgofadopljbjfkapdkoienihi?hl=en)
- [Redux DevTools](https://chrome.google.com/webstore/detail/redux-devtools/lmhkpmbekcpmknklioeibfkpmmfibljd?hl=en)

Configure search engines (`Manage search engines`):

| name             | Query URL                                                       | key binding |
| ---------------- | --------------------------------------------------------------- | ----------- |
| Duckduckgo       | https://duckduckgo.com/?q=%s                                    | `d`         |
| Google maps      | https://www.google.com/maps/search/%s                           | `gm`        |
| Google translate | https://translate.google.com/?&op=translate&sl=it&tl=en&text=%s | `gt`        |
| npm              | https://www.npmjs.com/search?q=%s                               | `n`         |
| Word Reference   | http://www.wordreference.com/iten/%s                            | `wr`        |
| YouTube          | https://www.youtube.com/results?search_query=%s                 | `yt`        |

### VSC

- Open `VSC` settings `cmd + ,`
- Connect `Code settings` extension to GitHub
- Run `Sync: Download Settings`

## Credits

Many thanks to the [dotfiles community](https://dotfiles.github.io).
