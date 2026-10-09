CREATE TABLE IF NOT EXISTS fact_hourly_sales_sessions (
    id SERIAL PRIMARY KEY,
    date_hour TIMESTAMP NOT NULL,
    store_id VARCHAR(50) NOT NULL,
    active_sessions INT DEFAULT 0,
    total_sales_amount NUMERIC(12, 2) DEFAULT 0.00,
    total_transactions INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT unique_store_hour UNIQUE (date_hour, store_id)
);

CREATE INDEX IF NOT EXISTS idx_hourly_sales_time ON fact_hourly_sales_sessions (date_hour);
CREATE INDEX IF NOT EXISTS idx_hourly_sales_store ON fact_hourly_sales_sessions (store_id);

CREATE TABLE IF NOT EXISTS quarantine_records (
    record_id SERIAL PRIMARY KEY,
    source_file VARCHAR(50) NOT NULL,
    raw_payload TEXT,
    error_reason VARCHAR(255) NOT NULL,
    quarantined_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
