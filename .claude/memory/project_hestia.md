---
name: Hestia — Homelab Setup
description: Raspberry Pi 4 homelab node running AdGuard Home, Home Assistant OS VM, Uptime Kuma, and nginx
type: project
---

# Hestia Homelab Setup

## Hardware
- **Hestia**: Raspberry Pi 4 (8GB RAM), Raspberry Pi OS Lite (64-bit)
  - Tailscale IP: 100.85.232.114
  - LAN IP: 192.168.1.77 (bridge br0)
  - Connected via ethernet (eth0) through bridge br0
  - Running on SD card (USB SSD migration recommended)
  - SSH: key-based auth, `ssh hestia` via ~/.ssh/config

## Network
- **br0 bridge**: configured via `/etc/network/interfaces` using `ifupdown`, bridges eth0, gets DHCP from router
- **Tailscale**: running on host, `tailscale0` interface
- **wlan0**: still present but not primary

## Services

### AdGuard Home (ACTIVE)
- Running as Docker container with `network_mode: host`
- Compose file: `~/docker/adguard/docker-compose.yml`
- Config: `~/docker/adguard/conf/AdGuardHome.yaml`
- Web UI: `http://100.85.232.114:3000`
- DNS bound to Tailscale IP only (NOT 0.0.0.0), port 53
- Migrated from Ariadne (was native at /opt/AdGuardHome/)
- DNS rewrites:
  - `adguard.tinomercy.xyz` → `100.85.232.114`
  - `homeassistant.tinomercy.xyz` → `100.85.232.114`
  - `kuma.tinomercy.xyz` → `100.85.232.114`
  - `proxmox.tinomercy.xyz` → `100.111.189.3`
  - `ariadne.tinomercy.xyz` → `100.74.218.93`

### Home Assistant OS VM (ACTIVE)
- Running as KVM/QEMU VM via libvirt
- Image: `haos_generic-aarch64-17.1.qcow2` (resized +32G) at `/var/lib/libvirt/images/haos.qcow2`
- VM name: `haos`, autostart enabled
- LAN IP: `192.168.1.190` (fixed in UDM SE), MAC: `52:54:00:b0:0f:75`
- Tailscale IP: `100.73.187.27`
- Network: bridge `br0`
- Web UI: `http://192.168.1.190:8123` or `http://homeassistant.local:8123`
- HA version: 2026.3.1, HAOS 17.1
- Sonoff Zigbee 3.0 USB Dongle Plus V2 passed through (1a86:55d4)
- Tailscale add-on v0.27.1, userspace_networking mode
  - Key expiry: disabled ✓
  - Exit node advertised but NOT approved — **TODO: disable**
  - Subnet routes pending — **TODO: disable**
  - Tailscale SSH not yet working (blocked by userspace_networking)

### libvirt Network
- Custom network named `haos` (not default), bridge: `virbr1`, subnet: `192.168.123.0/24`
- Default libvirt network disabled (conflicts with AdGuard on port 53)

### Uptime Kuma (ACTIVE)
- Running as Docker container
- Compose file: `~/docker/uptime-kuma/docker-compose.yml`
- Data: `~/docker/uptime-kuma/data/`
- Web UI: `http://100.85.232.114:3001` or `http://kuma.tinomercy.xyz`

### nginx (ACTIVE)
- Config: `/etc/nginx/sites-available/hestia` (symlinked to sites-enabled)
- Listens on `100.85.232.114:80` only (Tailscale IP, not public)
- Routes:
  - `adguard.tinomercy.xyz` → `http://100.85.232.114:3000`
  - `homeassistant.tinomercy.xyz` → `http://192.168.1.190:8123`
  - `kuma.tinomercy.xyz` → `http://100.85.232.114:3001`
- Ariadne no longer proxies Hestia services

## Planned
- Beszel Agent
- Alloy Agent (ships logs to Loki on Ariadne)

## TODO
- **Tailscale SSH on HAOS**: set `userspace_networking: false` in add-on config
- **USB SSD migration**: Samsung T7 or Crucial X6 recommended — SD card is reliability risk

## Architecture
- **Hestia**: bombproof, minimal — AdGuard Home + HAOS VM + Uptime Kuma + nginx
- **Ariadne** (Beelink N100, 16GB RAM, 500GB): main homelab app host, Proxmox + Ubuntu Server VM, Cloudflare Tunnel
- **Phaedra** (Oracle Cloud, 24GB RAM, 200GB): Minecraft, planned OpenClaw
- **UDM SE**: main router/gateway
- Tailscale is the backbone for all remote access
- No public exposure of Hestia — Tailscale only, not on Cloudflare Tunnel
