# Majordom Finance — CONVENTIONS.md
# Copiază acest fișier în rădăcina repo-ului: ~/dev/majordom-os/CONVENTIONS.md

---

## Proiect

Majordom Finance este un asistent financiar personal self-hosted.
Utilizatorul introduce tranzacții în limbaj natural (română sau engleză).
AI-ul local (Ollama) le transformă în înregistrări contabile cu dublă intrare.
Datele sunt stocate în PostgreSQL și vizualizate prin Streamlit.

## Stack Tehnic

- Python 3.12
- PostgreSQL 16 — baza de date principală
- SQLAlchemy 2.0 — ORM (nu SQL raw)
- Streamlit — interfața web
- python-telegram-bot 20.x (async) — bot Telegram
- Ollama via HTTP REST — AI local (nu SDK, nu openai)
- python-dotenv — configurație din .env
- psycopg2-binary — driver PostgreSQL
- requests — HTTP calls către Ollama

## Structura Proiectului

```
app/
  main.py              ← entry point Streamlit
  config.py            ← toate settings din .env, importate de restul
  database/
    connection.py      ← engine și SessionLocal SQLAlchemy
    models.py          ← definițiile tabelelor (Account, Transaction, Posting)
    schema.sql         ← SQL initial pentru docker-entrypoint-initdb.d
  ai/
    ollama_client.py   ← singurul loc care vorbește cu Ollama
    prompts.py         ← system prompts, separate de logică
  services/
    transaction_service.py  ← logică tranzacții (fără UI, fără AI direct)
    account_service.py      ← logică conturi
  pages/
    dashboard.py       ← pagina principală Streamlit
    add_transaction.py ← pagina de adăugare
    transactions.py    ← istoricul tranzacțiilor
    reports.py         ← rapoarte și grafice
telegram_bot/
  bot.py               ← tot botul Telegram
scripts/
  test_connections.py  ← testare conexiuni (nu e importat de app)
```

## Reguli de Cod

- Type hints obligatorii pentru toate funcțiile
- Docstring scurt (o linie) pentru fiecare funcție publică
- snake_case pentru variabile și funcții
- UPPER_CASE pentru constante
- Nu folosi print() în app — folosește logging.info() / logging.error()
- Nu hardcoda nicio valoare — totul vine din config.py

## Configurație (config.py)

Toate variabilele de mediu se citesc O SINGURĂ DATĂ în config.py.
Restul modulelor importă din config, nu din os.environ direct.

```python
# Exemplu cum trebuie importat:
from app.config import OLLAMA_HOST, OLLAMA_MODEL
# NU:
# import os; os.getenv("OLLAMA_HOST")
```

## Baza de Date

- Folosește întotdeauna SQLAlchemy models, nu SQL raw
- Sesiunile DB se deschid cu context manager: `with SessionLocal() as session:`
- Amount se stochează ca Decimal(19,4) — NICIODATĂ float
- Datele se stochează ca date Python `datetime.date`, nu string

## Regula Double-Entry (CRITICĂ)

Orice tranzacție are minimum 2 postings.
Suma tuturor amount-urilor dintr-o tranzacție TREBUIE să fie exact 0.

```python
# Validare obligatorie înainte de orice save:
if sum(p.amount for p in postings) != 0:
    raise ValueError(f"Suma postings este {sum} — trebuie să fie 0")
```

## Ollama

- Toate apelurile către Ollama trec prin `app/ai/ollama_client.py`
- Endpoint: POST {OLLAMA_HOST}/api/generate
- Răspunsul trebuie să fie JSON valid — dacă nu e, ridică ValueError
- Timeout: 30 secunde pentru orice request Ollama
- Nu instala ollama-python sau alt SDK — folosim requests direct

## Servicii vs Pagini Streamlit

Serviciile (`app/services/`) NU știu că există Streamlit.
Paginile Streamlit (`app/pages/`) NU conțin logică de business.

```python
# CORECT — în pages/add_transaction.py:
result = transaction_service.save_transaction(data)
st.success(f"Salvat cu ID: {result}")

# GREȘIT — în pages/add_transaction.py:
with SessionLocal() as session:  # ← logica DB nu stă în pagini
    session.add(...)
```

## Telegram Bot

- Botul folosește python-telegram-bot v20 cu Application builder (async)
- Toate comenzile verifică `update.effective_user.id == TELEGRAM_USER_ID`
  Dacă nu coincide → ignoră comanda (fără răspuns)
- Botul apelează aceleași servicii ca Streamlit (`transaction_service` etc.)
  Nu duplica logica în bot

## Ce să NU faci

- Nu instala librării noi fără să întrebi — verifică dacă există deja în requirements.txt
- Nu modifica schema.sql după primul docker-compose up — modifici models.py
- Nu pune date reale în demo_data.sql — doar date fictive
- Nu urca .env pe GitHub — e în .gitignore
- Nu crea fișiere noi în afara structurii de mai sus fără motiv clar
- Nu refactoriza cod care funcționează dacă nu e cerut explicit
