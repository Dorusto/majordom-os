-- ============================================================
-- Majordom Finance — Schema Bază de Date
-- ============================================================

-- Tipuri de conturi (dublă intrare contabilă):
-- Assets      → bani pe care îi ai (conturi bancare, cash, mașină)
-- Liabilities → datorii (rate, card de credit)
-- Income      → surse de venit (salariu, freelance)
-- Expenses    → cheltuieli (mâncare, benzină, utilități)
-- Equity      → echilibrare la deschiderea conturilor

CREATE TABLE IF NOT EXISTS accounts (
    id          SERIAL PRIMARY KEY,
    name        VARCHAR(255) NOT NULL UNIQUE,
    type        VARCHAR(20)  NOT NULL CHECK (type IN ('Assets', 'Liabilities', 'Income', 'Expenses', 'Equity')),
    currency    CHAR(3)      NOT NULL DEFAULT 'RON',
    description TEXT,
    created_at  TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- O tranzacție = un eveniment financiar (ex: "am pus benzină")
CREATE TABLE IF NOT EXISTS transactions (
    id          SERIAL PRIMARY KEY,
    date        DATE         NOT NULL,
    description TEXT         NOT NULL,
    payee       VARCHAR(255),
    status      VARCHAR(20)  NOT NULL DEFAULT 'confirmed' CHECK (status IN ('confirmed', 'pending')),
    created_at  TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Un posting = o linie dintr-o tranzacție (de câte ori implică un cont)
-- Regula de aur: SUM(amount) pentru aceeași tranzacție trebuie să fie 0
CREATE TABLE IF NOT EXISTS postings (
    id              SERIAL PRIMARY KEY,
    transaction_id  INTEGER        NOT NULL REFERENCES transactions(id) ON DELETE CASCADE,
    account_id      INTEGER        NOT NULL REFERENCES accounts(id),
    amount          DECIMAL(19, 4) NOT NULL,
    currency        CHAR(3)        NOT NULL DEFAULT 'RON',
    note            TEXT,
    created_at      TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Index pentru interogări rapide pe date și conturi
CREATE INDEX IF NOT EXISTS idx_transactions_date     ON transactions(date);
CREATE INDEX IF NOT EXISTS idx_postings_transaction  ON postings(transaction_id);
CREATE INDEX IF NOT EXISTS idx_postings_account      ON postings(account_id);