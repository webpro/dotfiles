---
name: Phaedra server stack
description: Oracle Cloud instance named "phaedra" — infrastructure overview, see sub-projects for details
type: project
---

# Phaedra (Oracle Cloud Instance)

## Infrastructure (done/underway)
- Ubuntu 24.04
- SSH hardened on custom port 2847
- UFW + iptables-persistent
- **Tailscale** — confirmed running and on Martin's tailnet as of 2026-03-16; SSH config on Windows updated with Tailscale IP alias "phaedra"
- Custom ASCII art MOTD + dotfiles adapted for Linux
- fail2ban for rate-limiting
- tmux installed (used for persistent Minecraft session)
- `unsetopt CORRECT` in ~/.zshrc (zsh autocorrect fix)

## RAM overview (23GB total)
- Minecraft/Homestead: 6GB
- OpenClaw (planned, gateway mode): 4-6GB
- Other services (Gitea, n8n, etc.): 3-4GB
- OS overhead: ~1-2GB

## Sub-projects
- See [project_phaedra_services.md](project_phaedra_services.md) for all planned self-hosted services (Gitea, n8n, Syncthing, Journiv, Silverbullet, Cloudflare Tunnel, OpenClaw)
- See [project_phaedra_minecraft.md](project_phaedra_minecraft.md) for Minecraft server (Homestead modpack — running as of 2026-03-15)
