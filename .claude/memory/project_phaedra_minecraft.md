---
name: Phaedra — Minecraft
description: Minecraft server plans for phaedra, including modpack, client setup, and related tooling
type: project
---

# Phaedra — Minecraft Server

## Status
**Running** — Homestead server live in tmux session "minecraft" on phaedra. First booted 2026-03-15 16:05:35, took 77.9s after world generation completed.

## Server
- Hosting on phaedra (Oracle Cloud ARM instance, 23GB RAM total)
- Access via Tailscale (private, for Martin only — to play from anywhere)
- Running directly (not yet in Docker Compose — future migration planned)
- tmux session named "minecraft" — attach with `tmux attach -t minecraft`
- Modpack: **Homestead 1.2.9.4** (cozy/exploration focused, 356 mods, by CozyStudios)
  - Requires Minecraft **1.20.1** (important — not 1.21.x)
  - cozystudios.org/homestead
  - Includes: Farmer's Delight, Create, YUNG's structures, Regions Unexplored, Sodium/Lithium, voice chat, tons of building/decoration mods
- Java: openjdk-21-jre-headless (`/usr/bin/java`)
- RAM: 6GB allocated (Xmx6G/Xms6G) — conservative to leave room for OpenClaw and other services
- variables.txt: JAVA=/usr/bin/java, SKIP_JAVA_CHECK=true
- Server files: ~/minecraft/homestead/Homestead1.2.9.4/
- OpenClaw (self-hosted AI agent) has a Minecraft server management skill — can set up, run, back up, monitor, and manage the server via natural language; see services file for full OpenClaw details

## Client (Martin's PC)
- Minecraft Java Edition (Microsoft Store launcher — winget version has broken auth loop, Store version works)
- **CurseForge standalone app** used for modpack management (Modrinth had 25 manual downloads required for CurseForge-exclusive mods; CurseForge standalone handles them automatically)
- Homestead client modpack installed via CurseForge — requires 1.20.1
- Fabric + Iris + Complementary Shaders (Unbound) available but shaders not yet enabled in-game
- GTX 1070 — running on High/Medium preset recommended
- Interested in also adding: Sodium, Lithium, Falling Leaves, Ambient Sounds, Distant Horizons

## Goals
- Beautiful world to explore with shaders
- Load and explore other people's custom maps/worlds
- Small private server for playing from anywhere via Tailscale
- Potential future migration to dedicated N100 mini PC if phaedra is needed for OpenClaw
