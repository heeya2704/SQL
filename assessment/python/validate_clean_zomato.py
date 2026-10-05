"""
Section B.3 — Pandas validation of the Zomato Bangalore dataset.

Cleans rate values "NEW" and "-" (and blank / NaN) before relational load.
Also normalizes cost, yes/no flags, and comma-separated cuisine / rest_type lists.
Writes output/zomato_cleaned.csv for the ingestion pipeline.
"""

from __future__ import annotations

import re
from pathlib import Path
from urllib.parse import urlsplit, urlunsplit

import pandas as pd

ROOT = Path(__file__).resolve().parents[1]
RAW_CSV = ROOT / "zomato.csv" / "zomato.csv"
OUT_DIR = ROOT / "output"
CLEAN_CSV = OUT_DIR / "zomato_cleaned.csv"

USECOLS = [
    "url",
    "address",
    "name",
    "online_order",
    "book_table",
    "rate",
    "votes",
    "phone",
    "location",
    "rest_type",
    "cuisines",
    "approx_cost(for two people)",
    "listed_in(type)",
    "listed_in(city)",
]


def parse_rate(value) -> float | None:
    """Convert Zomato rate strings to a numeric score on a 5-point scale."""
    if value is None or (isinstance(value, float) and pd.isna(value)):
        return None
    text = str(value).strip()
    if text == "" or text.upper() == "NEW" or text == "-" or text.lower() == "nan":
        return None
    match = re.search(r"(\d+(?:\.\d+)?)", text.replace(" ", ""))
    if not match:
        return None
    score = float(match.group(1))
    if score < 0 or score > 5:
        return None
    return score


def parse_cost(value) -> int | None:
    if value is None or (isinstance(value, float) and pd.isna(value)):
        return None
    digits = re.sub(r"[^\d]", "", str(value))
    if not digits:
        return None
    return int(digits)


def parse_yes_no(value) -> int:
    return 1 if str(value).strip().lower() in {"yes", "true", "1"} else 0


def canonical_url(value) -> str:
    """Strip listing-context query strings so one venue has one URL."""
    if value is None or (isinstance(value, float) and pd.isna(value)):
        return ""
    parts = urlsplit(str(value).strip())
    return urlunsplit((parts.scheme, parts.netloc, parts.path.rstrip("/"), "", ""))


def explode_csv_list(series: pd.Series) -> pd.Series:
    return series.fillna("").astype(str).str.replace(r"\s*,\s*", ",", regex=True)


def clean_frame(df: pd.DataFrame) -> pd.DataFrame:
    out = df.copy()
    out = out.rename(
        columns={
            "name": "restaurant_name",
            "approx_cost(for two people)": "approx_cost_for_two",
            "listed_in(type)": "listed_in_type",
            "listed_in(city)": "listed_in_city",
        }
    )

    invalid_rate_mask = (
        out["rate"].isna()
        | out["rate"].astype(str).str.strip().isin(["NEW", "-", "", "nan", "NaN"])
        | out["rate"].astype(str).str.strip().str.upper().eq("NEW")
    )
    invalid_count = int(invalid_rate_mask.sum())

    out["rate_raw"] = out["rate"]
    out["rate"] = out["rate"].map(parse_rate)
    out["rate_was_invalid"] = invalid_rate_mask.astype(int)
    out["approx_cost_for_two"] = out["approx_cost_for_two"].map(parse_cost)
    out["online_order"] = out["online_order"].map(parse_yes_no)
    out["book_table"] = out["book_table"].map(parse_yes_no)
    out["votes"] = pd.to_numeric(out["votes"], errors="coerce").fillna(0).astype(int)
    out["restaurant_name"] = out["restaurant_name"].fillna("").str.strip()
    out["location"] = out["location"].fillna("").str.strip()
    out["cuisines"] = explode_csv_list(out["cuisines"])
    out["rest_type"] = explode_csv_list(out["rest_type"])
    out["phone"] = out["phone"].fillna("").astype(str).str.replace(r"\r|\n", " ", regex=True).str.strip()
    out["address"] = out["address"].fillna("").astype(str).str.strip()
    out["url"] = out["url"].map(canonical_url)

    out = out[out["restaurant_name"].ne("") & out["url"].ne("")].copy()

    print(f"Rows read: {len(df)}")
    print(f"Rows with NEW / '-' / blank / NaN rate (set to NULL): {invalid_count}")
    print(f"Rows kept after dropping unnamed/no-url records: {len(out)}")
    print(f"Unique restaurant URLs (canonical): {out['url'].nunique()}")
    print(f"Numeric rates available: {out['rate'].notna().sum()}")
    print(f"Rates still NULL (valid unknown score): {out['rate'].isna().sum()}")
    return out


def main() -> None:
    if not RAW_CSV.exists():
        raise SystemExit(f"Dataset not found: {RAW_CSV}")

    df = pd.read_csv(RAW_CSV, usecols=USECOLS, low_memory=False)
    cleaned = clean_frame(df)
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    cleaned.to_csv(CLEAN_CSV, index=False)
    print(f"Wrote {CLEAN_CSV}")


if __name__ == "__main__":
    main()
