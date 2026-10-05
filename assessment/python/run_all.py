"""Run the full local pipeline: clean -> ingest -> indexes/views."""

from __future__ import annotations

import runpy
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def main() -> None:
    scripts = [
        ROOT / "python" / "validate_clean_zomato.py",
        ROOT / "python" / "ingest_pipeline.py",
        ROOT / "python" / "apply_indexes_and_features.py",
    ]
    for path in scripts:
        print("=" * 60)
        print("Running", path.name)
        print("=" * 60)
        runpy.run_path(str(path), run_name="__main__")


if __name__ == "__main__":
    main()
