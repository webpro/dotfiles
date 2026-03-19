---
name: Ariadne — Main Homelab Host
description: Beelink N100 mini PC running Proxmox with Ubuntu Server VM, primary self-hosted app stack and Cloudflare Tunnel exposure
type: project
---

# Ariadne — Main Homelab Host

## Hardware
- Beelink 12 Mini S, Intel N100, 16GB RAM, 500GB storage
- Running Proxmox with at least one Ubuntu Server VM carrying the app stack
- Tailscale IP: 100.74.218.93

## Access Model
- Mixed: curated subset of services exposed via **Cloudflare Tunnel** at `*.tinomercy.xyz`
- Admin/internal access via **Tailscale**
- Nginx for reverse proxying

## Services — Running (keeping)
- Audiobookshelf
- Calibre-Web
- cloudflared
- Gitea
- Immich
- Linkwarden
- n8n
- Nginx
- Paperless-ngx
- Portainer
- Stoa
- Tailscale
- WallOS

## Services — Running (to be removed)
- Authentik
- Maybe
- Omnivore

## Services — Running (likely to be removed)
- BookLore
- webdav-apache

## Services — Planned
- SilverBullet
- Journiv
- Grafana + Loki + Alloy (observability stack)
- Beszel Hub + Agent
- Alloy Agent
- ntfy
