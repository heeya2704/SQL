"""
Section C — Python data ingestion pipeline.

Loads output/zomato_cleaned.csv into analytics_db:
  locations -> restaurants -> cuisines / restaurant_types
  -> junction tables -> ratings (composite PK)

Run order:
  python python/validate_clean_zomato.py
  python python/etl_create_schema.py
  python python/ingest_pipeline.py
"""

from __future__ import annotations

import sys
from pathlib import Path

import pandas as pd
from sqlalchemy import select
from sqlalchemy.orm import Session

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "python"))

from db_models import (  # noqa: E402
    Base,
    Cuisine,
    Location,
    Rating,
    Restaurant,
    RestaurantCuisine,
    RestaurantType,
    RestaurantTypeMap,
)
from etl_create_schema import create_schema, get_engine  # noqa: E402

CLEAN_CSV = ROOT / "output" / "zomato_cleaned.csv"


def split_tokens(value: str) -> list[str]:
    if not value or str(value).strip() in {"", "nan"}:
        return []
    parts = [p.strip() for p in str(value).split(",")]
    return [p for p in parts if p and p.lower() != "nan"]


def upsert_lookup(session: Session, model, name_col: str, names: set[str]) -> dict[str, int]:
    existing = session.execute(select(model)).scalars().all()
    mapping = {getattr(row, name_col): getattr(row, list(model.__table__.primary_key.columns)[0].name) for row in existing}
    missing = [n for n in names if n not in mapping]
    objects = [model(**{name_col: n}) for n in missing]
    session.add_all(objects)
    session.flush()
    for obj in objects:
        mapping[getattr(obj, name_col)] = getattr(obj, list(model.__table__.primary_key.columns)[0].name)
    return mapping


def ingest(session: Session, df: pd.DataFrame) -> None:
    location_names = {loc for loc in df["location"].dropna().unique() if str(loc).strip()}
    loc_map = upsert_lookup(session, Location, "location_name", location_names)

    cuisine_names = {
        t
        for t in df["cuisines"].dropna().astype(str).str.split(",").explode().str.strip()
        if t and t.lower() != "nan"
    }
    type_names = {
        t
        for t in df["rest_type"].dropna().astype(str).str.split(",").explode().str.strip()
        if t and t.lower() != "nan"
    }
    cuisine_map = upsert_lookup(session, Cuisine, "cuisine_name", cuisine_names)
    type_map = upsert_lookup(session, RestaurantType, "rest_type_name", type_names)

    restaurants = df.sort_values("votes", ascending=False).drop_duplicates(subset=["url"], keep="first")
    url_to_id: dict[str, int] = {}
    restaurant_rows = []
    for rec in restaurants.itertuples(index=False):
        loc_id = loc_map.get(str(rec.location).strip()) if rec.location else None
        restaurant_rows.append(
            Restaurant(
                restaurant_name=rec.restaurant_name,
                url=rec.url,
                address=rec.address or None,
                phone=rec.phone or None,
                online_order=bool(rec.online_order),
                book_table=bool(rec.book_table),
                approx_cost_for_two=None if pd.isna(rec.approx_cost_for_two) else int(rec.approx_cost_for_two),
                location_id=loc_id,
            )
        )
    session.add_all(restaurant_rows)
    session.flush()
    for obj in restaurant_rows:
        url_to_id[obj.url] = obj.restaurant_id

    cuisine_links = set()
    type_links = set()
    for rec in restaurants.itertuples(index=False):
        rid = url_to_id[rec.url]
        for name in split_tokens(rec.cuisines):
            cuisine_links.add((rid, cuisine_map[name]))
        for name in split_tokens(rec.rest_type):
            type_links.add((rid, type_map[name]))

    session.add_all(
        [RestaurantCuisine(restaurant_id=r, cuisine_id=c) for r, c in cuisine_links]
    )
    session.add_all(
        [RestaurantTypeMap(restaurant_id=r, rest_type_id=t) for r, t in type_links]
    )

    rating_keys = set()
    rating_rows = []
    for rec in df.itertuples(index=False):
        rid = url_to_id.get(rec.url)
        if rid is None:
            continue
        listed_type = "" if pd.isna(rec.listed_in_type) else str(rec.listed_in_type).strip()
        listed_city = "" if pd.isna(rec.listed_in_city) else str(rec.listed_in_city).strip()
        key = (rid, listed_type, listed_city)
        if key in rating_keys or not listed_type or not listed_city:
            continue
        rating_keys.add(key)
        rate_val = None if pd.isna(rec.rate) else float(rec.rate)
        rating_rows.append(
            Rating(
                restaurant_id=rid,
                listed_in_type=listed_type,
                listed_in_city=listed_city,
                rate=rate_val,
                votes=int(rec.votes),
            )
        )
    session.add_all(rating_rows)
    session.flush()

    print(f"locations: {len(loc_map)}")
    print(f"restaurants: {len(url_to_id)}")
    print(f"cuisines: {len(cuisine_map)}")
    print(f"restaurant_types: {len(type_map)}")
    print(f"restaurant_cuisines: {len(cuisine_links)}")
    print(f"restaurant_type_map: {len(type_links)}")
    print(f"ratings: {len(rating_rows)}")


def main() -> None:
    if not CLEAN_CSV.exists():
        raise SystemExit("Run python/validate_clean_zomato.py first.")

    df = pd.read_csv(CLEAN_CSV, low_memory=False)
    engine = get_engine()
    Base.metadata.drop_all(engine)
    create_schema(engine)
    with Session(engine) as session:
        ingest(session, df)
        session.commit()
        print("Ingestion committed.")


if __name__ == "__main__":
    main()
