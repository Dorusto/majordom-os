# Majordom Finance

> **Your money. Your server. Your rules.**

A self-hosted personal finance assistant powered by local AI. Describe your transactions in plain language — Majordom understands, validates, and stores everything on your own hardware.

No cloud. No subscriptions. No one else's server.

---

## How It Works

```
You type:    "spent 200 RON on fuel, paid from ING"
                          ↓
             Ollama (local AI, your hardware)
                          ↓
             Double-entry validation (sum = 0)
                          ↓
             PostgreSQL (your database)
                          ↓
You see:     Net Worth updated on dashboard
```

Add transactions from your browser or via Telegram bot — from anywhere, without exposing your data to third parties.

---

## Features (MVP in progress)

- [x] Project structure & Docker setup
- [ ] **M0** — One-command install (`docker-compose up`)
- [ ] **M1** — Natural language → transaction (Ollama/Llama3)
- [ ] **M2** — Streamlit dashboard (Net Worth, reports, charts)
- [ ] **M3** — Telegram bot (`/add`, `/balance`, `/month`)
- [ ] **M4** — Public release with demo data & setup script

> Follow the build live on [YouTube](https://youtube.com/@dorulian) and [Substack](https://dorulian.substack.com)

---

## Stack

| Component | Technology |
|---|---|
| Database | PostgreSQL 16 |
| Local AI | Ollama + Llama3 |
| Web UI | Python + Streamlit |
| Mobile | Telegram Bot |
| Deployment | Docker Compose |

Everything runs on your machine. The only outbound connection is Ollama pulling a model on first start — after that, fully offline.

---

## Quick Install (available at M4)

```bash
git clone https://github.com/Dorusto/majordom-os.git
cd majordom-os
cp .env.example .env
# Edit .env with your settings
./setup.sh
```

Then open `http://localhost:8501`

**Requirements:** Docker, Docker Compose. That's it.

---

## Philosophy

Majordom is built on one principle: your financial data is yours.

Most finance apps make money by analyzing your spending habits. Majordom runs on your hardware, speaks to your local AI, and stores data in your local database. The code is open — you can audit every line.

Built as part of the **#DEPPSiT** movement — *"Dacă Eu Pot, Poți și Tu"* (If I can do it, so can you). The goal is making self-hosting accessible, not just for developers.

---

## Documentation

- [Architecture](../../wiki/Architecture) — how the system works
- [Roadmap](../../wiki/Roadmap) — what's planned and current status
- [Installation Guide](../../wiki/Installation) — coming at M4

---

## Follow the Build

This project is built entirely in public.

- **YouTube:** Full build sessions, architecture decisions, mistakes included
- **Substack:** DevLog — the "why" behind every decision
- **GitHub Issues:** Every task tracked publicly

---

## License

MIT — use it, fork it, build on it.
