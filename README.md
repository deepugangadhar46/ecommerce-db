# E-Commerce Multi-Channel Sales Integration Pipeline

An end-to-end PySpark ETL pipeline integrating multi-channel retail data: online clickstream JSON logs and physical store POS transactions (CSV).

## Architecture & Work Breakdown
- **Data Ingestion & Quality Control (Member 1):** Defined strict `StructType` schemas to avoid schema inference overhead. Filtered null identifiers, empty strings, and non-positive purchase amounts. Isolated 7 corrupted records into a dedicated quarantine destination.
- **Transformations & Session Matching (Member 2):** Applied an optimized PySpark `broadcast()` join on `user_id` to prevent network shuffle bottlenecks. Executed tumbling 1-hour window aggregations to calculate hourly active browsing sessions and store revenues.
- **Warehouse Modeling & Storage (Member 3):** Modeled a target star schema in PostgreSQL (hosted on Neon) featuring unique constraints on `(date_hour, store_id)` and loaded transformed data alongside audit logs via transactional batch inserts.

## Tech Stack
- **Engine:** Apache PySpark 3.x
- **Language:** Python 3.10+
- **Database:** PostgreSQL (Neon Serverless)
- **Environment:** Google Colab Cloud Notebook & Git

## Verified Pipeline Results
- **Clean Clickstream:** 15 valid rows | **Quarantined:** 3 corrupt rows
- **Clean Store Sales:** 11 valid rows | **Quarantined:** 4 corrupt rows
- **Fact Table:** 7 aggregated hourly store records successfully loaded into PostgreSQL.
