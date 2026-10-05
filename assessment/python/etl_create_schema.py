"""
Section B.1 — Python ETL: create analytics_db schema with SQLAlchemy.

Enforces a composite primary key on ratings
(restaurant_id, listed_in_type, listed_in_city).

Default engine: SQLite file analytics_db.sqlite in the Assessment folder.
Override with environment variable DATABASE_URL, for example:
  mysql+pymysql://user:pass@localhost:3306/analytics_db
"""

from __future__ import annotations

import os
import sys
from pathlib import Path

from sqlalchemy import create_engine, inspect, text

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "python"))

from db_models import Base, Rating  # noqa: E402

DEFAULT_SQLITE = ROOT / "analytics_db.sqlite"


def get_engine():
    url = os.environ.get("DATABASE_URL")
    if not url:
        url = f"sqlite:///{DEFAULT_SQLITE.as_posix()}"
    connect_args = {}
    if url.startswith("sqlite"):
        connect_args["check_same_thread"] = False
    engine = create_engine(url, echo=False, future=True, connect_args=connect_args)
    return engine


def create_schema(engine) -> None:
    if engine.dialect.name == "sqlite":
        with engine.connect() as conn:
            conn.execute(text("PRAGMA foreign_keys = ON"))
            conn.commit()
    elif engine.dialect.name == "mysql":
        with engine.connect() as conn:
            conn.execute(text("CREATE DATABASE IF NOT EXISTS analytics_db"))
            conn.commit()

    Base.metadata.create_all(engine)


def describe_ratings_pk(engine) -> None:
    inspector = inspect(engine)
    pk = inspector.get_pk_constraint("ratings")
    print("ratings composite primary key columns:", pk.get("constrained_columns"))
    expected = {"restaurant_id", "listed_in_type", "listed_in_city"}
    actual = set(pk.get("constrained_columns") or [])
    if actual != expected:
        raise SystemExit(f"Composite PK mismatch. Expected {expected}, got {actual}")
    print("Composite primary key on ratings is in place.")
    print("Mapped columns:", [c.name for c in Rating.__table__.columns])


def main() -> None:
    engine = get_engine()
    print("Engine:", engine.url.render_as_string(hide_password=True))
    create_schema(engine)
    print("Created tables:", ", ".join(sorted(Base.metadata.tables)))
    describe_ratings_pk(engine)


if __name__ == "__main__":
    main()
