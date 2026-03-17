---
name: Phaedra — Self-hosted Services
description: All planned self-hosted services on phaedra beyond Minecraft
type: project
---

# Phaedra — Self-hosted Services

## Philosophy
- Tailscale for private access (default)
- Cloudflare Tunnel only for services deliberately exposed publicly
- All stacks in Docker Compose, connected to Git repos mirrored to Gitea
- Zero open inbound ports

## Services

### Running
- **Gitea** — Git hosting, internal only via Tailscale
- **Tailscale** — confirmed on Martin's tailnet as of 2026-03-16

### Planned
- **Cloudflare Tunnel** — public exposure layer for anything that needs it
- **n8n** — automation workflows
- **Syncthing** — offsite backup/sync for Obsidian vault (**NOT yet set up**)
- **Journiv** — self-hosted journaling; flagged as promising Day One alternative
- **Silverbullet** — web-accessible Obsidian-compatible vault; pairs with Syncthing so Martin gets native Obsidian on desktop + web access anywhere via Cloudflare Tunnel
- **OpenClaw** — self-hosted AI agent platform (not Minecraft-specific); Martin is very interested in this
  - Gateway mode (cloud APIs like Claude): needs 4-8GB RAM — fits on phaedra alongside Minecraft
  - Local model mode: needs 16-32GB — would require dedicated hardware
  - Runs on Node.js; Docker recommended
  - Plan: start on phaedra in gateway mode; if it grows, migrate Minecraft to dedicated N100 mini PC
  - Security note: vet community skills carefully as they can execute arbitrary code
