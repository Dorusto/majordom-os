# Majordom — Life OS

> **Your life. Your data. Your rules.**

Majordom is a self-hosted personal operating system for your life — finances, health, and digital world — running entirely on your own hardware, powered by local AI.

No cloud. No subscriptions. No one else's server. No compromises.

---

## The Problem

You are paying 15+ subscriptions to companies that profit from your data:

| What you use | What it costs | What it knows about you |
|---|---|---|
| YNAB / Revolut | €15/month | Every transaction |
| MyFitnessPal / Strava | €10/month | Your body, habits, location |
| Google Photos / iCloud | €10/month | Every photo, document, memory |
| Netflix / Spotify | €30/month | Your taste, mood, schedule |

**Total: €1,500+/year** handed to corporations in exchange for your privacy.

Majordom replaces all of it. One server. Your hardware. Zero recurring costs.

---

## Three Majordoms, One System

### 🏦 Financial Majordom *(Active development — MVP)*
> *"Clarity & Prosperity"*

Your personal CFO, running locally.

- Natural language transaction input (*"spent 200 RON on fuel"*)
- Automated receipt scanning and bill analysis via local AI
- Real-time budget monitoring and cash flow tracking
- Investment portfolio analysis and debt elimination strategies
- **Replaces:** YNAB, Revolut Analytics, Expensify, spreadsheets

### 🏃 Health Majordom *(Planned)*
> *"Health & Vitality"*

Your personal trainer and nutritionist, on your server.

- Personalized fitness plans based on your heart rate data
- Nutrition and workout correlation
- Sleep quality analysis with recovery recommendations
- **Replaces:** Strava, MyFitnessPal, Apple Fitness+, Whoop

### 🏛️ Digital Majordom *(Planned)*
> *"Your Digital Vault"*

Your private cloud, media library, and home automation hub.

- Local photo and document storage with AI organization
- 4K personal media streaming library
- Home automation via Home Assistant
- **Replaces:** Google Photos, iCloud, Netflix, Spotify

---

## How Financial Majordom Works

```
You type:    "spent 200 RON on fuel, paid from ING"
                          ↓
             Ollama (local AI — your hardware, offline)
                          ↓
             Double-entry accounting validation
                          ↓
             PostgreSQL (your database, your machine)
                          ↓
You see:     Net Worth updated · Charts · Reports
```

Add transactions from your browser or via Telegram — from anywhere, through your private Tailscale network.

---

## Architecture

```
┌─────────────────────────────────────────┐
│           YOUR HARDWARE                 │
│                                         │
│  ┌──────────┐  ┌──────────────────────┐ │
│  │  Ollama  │  │     PostgreSQL       │ │
│  │  Llama3  │  │   (your database)    │ │
│  └──────────┘  └──────────────────────┘ │
│                                         │
│  ┌──────────┐  ┌──────────────────────┐ │
│  │Streamlit │  │   Telegram Bot       │ │
│  │Dashboard │  │   (private access)   │ │
│  └──────────┘  └──────────────────────┘ │
│                                         │
│  Remote access: Tailscale (encrypted)   │
│  Backup: 3-2-1 strategy, AES-256        │
└─────────────────────────────────────────┘
```

Everything runs on a Mini PC or NAS. Functions fully offline.
Remote access through Tailscale — no port forwarding, no cloud relay.

---

## Quick Install (Financial Majordom — available at M4)

```bash
git clone https://github.com/Dorusto/majordom-os.git
cd majordom-os
cp .env.example .env
# Edit .env with your settings (5 minutes)
./setup.sh
```

Open `http://localhost:8501` — done.

**Requirements:** Docker, Docker Compose. Nothing else.

Works on: any Linux server, Raspberry Pi 4+, Mini PC, NAS with Docker, CasaOS.

---

## Current Status

| Module | Status |
|---|---|
| 🏦 Financial Majordom — M0: Docker Foundation | 🔄 In Progress |
| 🏦 Financial Majordom — M1: AI Engine | ⬜ Planned |
| 🏦 Financial Majordom — M2: Dashboard | ⬜ Planned |
| 🏦 Financial Majordom — M3: Telegram Bot | ⬜ Planned |
| 🏦 Financial Majordom — M4: Public Release | ⬜ Planned |
| 🏃 Health Majordom | ⬜ Post-Finance MVP |
| 🏛️ Digital Majordom | ⬜ Post-Finance MVP |

→ [Full Roadmap](../../wiki/Roadmap) · [GitHub Issues](../../issues) · [Project Board](../../projects)

---

## Built in Public

Every decision, every mistake, every architecture choice — filmed and published.

- **[YouTube](https://youtube.com/@dorulian)** — full build sessions
- **[Substack DevLog](https://dorulian.substack.com)** — the "why" behind every decision

---

## Philosophy

Majordom is built on the **#DEPPSiT** principle — *Dacă Eu Pot, Poți și Tu* ("If I can do it, so can you").

Self-hosting should not require a computer science degree. Majordom is designed for anyone willing to spend one afternoon setting up a server — and the reward is complete ownership of their digital life.

The code is open. The data is yours. The rules are yours.

---

## License

MIT — use it, fork it, build on it.
