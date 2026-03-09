# Windows Setup Guide

This guide covers setting up your dotfiles on Windows using native Windows apps and Scoop CLI tools.

## Philosophy

- **Native Windows apps** (Arc, 1Password, Obsidian, etc.) install directly on Windows via `winget`
- **CLI tools** (starship, bat, fzf, etc.) install via **Scoop** for native Windows use
- **Theming**: Flexoki Dark across Windows Terminal, Starship prompt, and editor

## Quick Start

Open **PowerShell as Administrator** and run:

```powershell
cd path\to\dotfiles\install\windows
.\setup.ps1
```

This will:
1. Install ~25 GUI apps via winget (see `winget-packages.txt`)
2. Install Scoop + CLI tools (starship, bat, eza, fd, ripgrep, fzf, zoxide, lazygit, jq, delta, kanata)
3. Install JetBrains Mono Nerd Font
4. Deploy Windows Terminal settings (Flexoki Dark theme)
5. Deploy Starship prompt config (Flexoki Dark palette)
6. Set up global gitignore for Windows
7. Add Starship init to your PowerShell profile

## File Organization

```
install/windows/
├── setup.ps1                      # Main setup script (run as Admin)
├── winget-packages.txt            # Windows GUI apps (winget)
├── windows-terminal-settings.json # Windows Terminal config (Flexoki Dark)
├── starship.toml                  # Starship prompt config (Flexoki Dark)
├── gitignore-global               # Windows global gitignore
└── README.md                      # This file
```

## Customizing

### Windows Apps
Edit `winget-packages.txt` — one winget package ID per line, `#` for comments. Find IDs at [winget.run](https://winget.run/).

### CLI Tools
Edit the `$scoopPackages` array in `setup.ps1` to add/remove Scoop packages.

### Windows Terminal
Edit `windows-terminal-settings.json` then re-run `setup.ps1` to deploy, or edit directly in Windows Terminal (`Ctrl+,` → Open JSON).

### Starship Prompt
Edit `starship.toml` in this directory (Windows-specific). The macOS/Linux Starship config lives separately at `config/starship.toml`.

## Tips

1. **Use Windows Terminal** — Best terminal experience on Windows
2. **Scoop for CLI tools** — Easy to install, update, and manage from PowerShell

## Troubleshooting

### Starship not rendering icons
Install a Nerd Font (setup.ps1 installs JetBrains Mono NF via Scoop) and set it in Windows Terminal settings.

