"""Apply extra indexes and feature-engineering views to the loaded database."""

from __future__ import annotations

import re
import sys
from pathlib import Path

from sqlalchemy import text
import pandas as pd

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "python"))

from etl_create_schema import get_engine  # noqa: E402

SQL_FILES = [
    ROOT / "sql" / "03_indexing_strategy.sql",
    ROOT / "sql" / "04_feature_engineering.sql",
]


def split_sql(script: str) -> list[str]:
    cleaned = []
    for line in script.splitlines():
        stripped = line.strip()
        if stripped.startswith("--") or stripped.upper().startswith("USE "):
            continue
        cleaned.append(line)
    body = "\n".join(cleaned)
    statements = [s.strip() for s in re.split(r";\s*\n", body) if s.strip() and s.strip() != ";"]
    return statements


def main() -> None:
    engine = get_engine()
    with engine.begin() as conn:
        if engine.dialect.name == "sqlite":
            conn.execute(text("PRAGMA foreign_keys = ON"))
        for path in SQL_FILES:
            print(f"Applying {path.name}")
            for stmt in split_sql(path.read_text(encoding="utf-8")):
                try:
                    conn.execute(text(stmt))
                except Exception as exc:
                    message = str(exc).lower()
                    if "already exists" in message or "duplicate" in message:
                        print("  skip (already exists)")
                        continue
                    raise
    print("Indexes and feature views applied.")
    with engine.connect() as conn:
        features = pd.read_sql("SELECT * FROM vw_model_features", conn)
    out_csv = ROOT / "output" / "model_features.csv"
    out_csv.parent.mkdir(parents=True, exist_ok=True)
    features.to_csv(out_csv, index=False)
    n = len(features)
    n_success = int(features["is_successful"].fillna(0).sum())
    print(f"Exported {out_csv} ({n} restaurants, {n_success} labelled successful)")
    print(features[["avg_rate", "max_votes", "success_score", "cuisine_count"]].describe())


if __name__ == "__main__":
    main()
