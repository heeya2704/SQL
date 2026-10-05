-- =============================================================================
-- Section B.4 — Indexing strategy for multi-table analytical JOINs
--
-- Query pattern this design accelerates:
--   restaurants  JOIN locations          ON location_id
--                JOIN restaurant_cuisines ON restaurant_id
--                JOIN cuisines            ON cuisine_id
--                JOIN ratings             ON restaurant_id
--
-- location_id is a foreign key used in every geo join.
-- cuisine_id / cuisine_name are used to slice demand by food type.
-- =============================================================================

USE analytics_db;

-- 1. Child FK used in restaurants <-> locations joins
CREATE INDEX idx_restaurants_location_id
    ON restaurants (location_id);

-- 2. Covering helper: filter/group by location then project name/cost
CREATE INDEX idx_restaurants_location_cost
    ON restaurants (location_id, approx_cost_for_two, restaurant_name);

-- 3. Cuisine dictionary lookup (equality / GROUP BY cuisine_name)
CREATE INDEX idx_cuisines_cuisine_name
    ON cuisines (cuisine_name);

-- 4. Junction: join from a cuisine to all restaurants (demand by cuisine)
CREATE INDEX idx_restaurant_cuisines_cuisine_id
    ON restaurant_cuisines (cuisine_id);

-- 5. Reverse path already served by PK (restaurant_id, cuisine_id)
--    Extra index on restaurant_id is unnecessary as it leads the PK.

-- 6. Ratings used in feature extraction (average rate, vote volume)
CREATE INDEX idx_ratings_restaurant_rate
    ON ratings (restaurant_id, rate, votes);

CREATE INDEX idx_ratings_listed_in_city
    ON ratings (listed_in_city, listed_in_type);

-- SQLite local file (analytics_db.sqlite) — same names, no USE:
-- CREATE INDEX IF NOT EXISTS idx_restaurants_location_id ON restaurants (location_id);
-- CREATE INDEX IF NOT EXISTS idx_cuisines_cuisine_name ON cuisines (cuisine_name);
