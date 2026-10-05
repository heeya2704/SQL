# TOPS Technologies — Working with Databases (A1)

Zomato Bangalore restaurants: 3NF `analytics_db` schema, Python ETL, indexes, and SQL features for restaurant-success prediction.

## Deliverables

| Requirement | Location |
|---|---|
| Section A answers | `SectionA.txt` |
| Section B practical notes | `SectionB.txt` |
| Section C mini-project notes | `SectionC.txt` |
| Optimized DDL | `sql/01_analytics_db_schema.sql` |
| ALTER + ON DELETE CASCADE | `sql/02_alter_referential_integrity.sql` |
| JOIN indexes | `sql/03_indexing_strategy.sql` |
| Feature views | `sql/04_feature_engineering.sql` |
| SQLAlchemy schema + composite PK | `python/db_models.py`, `python/etl_create_schema.py` |
| Pandas rate cleaning (`NEW` / `-`) | `python/validate_clean_zomato.py` |
| Ingestion pipeline | `python/ingest_pipeline.py` |
| ER diagram (3NF) | `docs/er_diagram.html` |
| Feature report | `docs/feature_engineering_report.txt` |

Local database file: `analytics_db.sqlite` (created by the Python pipeline).

## Run locally

```text
pip install -r requirements.txt
python python/run_all.py
```

That command:

1. Cleans `zomato.csv/zomato.csv` → `output/zomato_cleaned.csv`
2. Recreates tables and loads locations, restaurants, cuisines, types, ratings
3. Applies indexes and feature views, then writes `output/model_features.csv`

MySQL: create an empty server, run `sql/01_*.sql` then `sql/02_*.sql`, set `DATABASE_URL`, then run the Python scripts.

```text
set DATABASE_URL=mysql+pymysql://user:pass@localhost:3306/analytics_db
```

## Design notes

- Restaurant grain is the canonical Zomato URL (query `context=` stripped). The same venue is listed many times; ratings keep listing type/city as a composite primary key.
- `rate` values `NEW` and `-` become NULL, not 0.
- `restaurants.location_id` → `locations.location_id` uses `ON DELETE CASCADE`.
