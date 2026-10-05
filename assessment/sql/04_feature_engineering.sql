-- =============================================================================
-- Section C — SQL feature engineering for restaurant success prediction
-- Run against analytics_db after ingestion (MySQL: USE analytics_db;).
-- SQLite: sqlite3 analytics_db.sqlite < sql/04_feature_engineering.sql
-- (SQLite has no CREATE OR REPLACE VIEW in older versions; DROP first.)
-- =============================================================================

-- USE analytics_db;

DROP VIEW IF EXISTS vw_restaurant_rating_stats;
DROP VIEW IF EXISTS vw_location_competition;
DROP VIEW IF EXISTS vw_cuisine_demand;
DROP VIEW IF EXISTS vw_model_features;

-- ---------------------------------------------------------------------------
-- 1. Core rating features per restaurant (collapse listing duplicates)
-- ---------------------------------------------------------------------------
CREATE VIEW vw_restaurant_rating_stats AS
SELECT
    r.restaurant_id,
    AVG(rt.rate)                         AS avg_rate,
    MAX(rt.rate)                         AS max_rate,
    MIN(rt.rate)                         AS min_rate,
    MAX(rt.votes)                        AS max_votes,
    AVG(CAST(rt.votes AS FLOAT))         AS avg_votes,
    COUNT(*)                             AS listing_count,
    SUM(CASE WHEN rt.rate IS NULL THEN 1 ELSE 0 END) AS unrated_listing_count
FROM restaurants r
LEFT JOIN ratings rt
    ON rt.restaurant_id = r.restaurant_id
GROUP BY r.restaurant_id;

-- ---------------------------------------------------------------------------
-- 2. Location competition / density (market saturation feature)
-- ---------------------------------------------------------------------------
CREATE VIEW vw_location_competition AS
SELECT
    l.location_id,
    l.location_name,
    COUNT(DISTINCT r.restaurant_id)                  AS restaurant_count,
    AVG(s.avg_rate)                                  AS location_avg_rate,
    AVG(r.approx_cost_for_two)                       AS location_avg_cost,
    SUM(CASE WHEN r.online_order = 1 THEN 1 ELSE 0 END) * 1.0
        / NULLIF(COUNT(*), 0)                        AS pct_online_order,
    SUM(CASE WHEN r.book_table = 1 THEN 1 ELSE 0 END) * 1.0
        / NULLIF(COUNT(*), 0)                        AS pct_book_table
FROM locations l
LEFT JOIN restaurants r
    ON r.location_id = l.location_id
LEFT JOIN vw_restaurant_rating_stats s
    ON s.restaurant_id = r.restaurant_id
GROUP BY l.location_id, l.location_name;

-- ---------------------------------------------------------------------------
-- 3. Cuisine-level demand (popularity and quality)
-- ---------------------------------------------------------------------------
CREATE VIEW vw_cuisine_demand AS
SELECT
    c.cuisine_id,
    c.cuisine_name,
    COUNT(DISTINCT rc.restaurant_id) AS restaurant_count,
    AVG(s.avg_rate)                  AS cuisine_avg_rate,
    AVG(s.max_votes)                 AS cuisine_avg_max_votes
FROM cuisines c
JOIN restaurant_cuisines rc
    ON rc.cuisine_id = c.cuisine_id
JOIN vw_restaurant_rating_stats s
    ON s.restaurant_id = rc.restaurant_id
GROUP BY c.cuisine_id, c.cuisine_name;

-- ---------------------------------------------------------------------------
-- 4. Model-ready one-row-per-restaurant feature table
--    Target proxy: success_score = normalized rate * log1p(votes)
-- ---------------------------------------------------------------------------
CREATE VIEW vw_model_features AS
SELECT
    r.restaurant_id,
    r.restaurant_name,
    l.location_name,
    r.online_order,
    r.book_table,
    r.approx_cost_for_two,
    CASE
        WHEN r.approx_cost_for_two IS NULL THEN 'unknown'
        WHEN r.approx_cost_for_two < 300 THEN 'budget'
        WHEN r.approx_cost_for_two < 700 THEN 'mid'
        WHEN r.approx_cost_for_two < 1500 THEN 'premium'
        ELSE 'luxury'
    END                                              AS cost_band,
    s.avg_rate,
    s.max_votes,
    s.listing_count,
    (SELECT COUNT(*)
       FROM restaurant_cuisines rc
      WHERE rc.restaurant_id = r.restaurant_id)      AS cuisine_count,
    (SELECT COUNT(*)
       FROM restaurant_type_map tm
      WHERE tm.restaurant_id = r.restaurant_id)      AS rest_type_count,
    lc.restaurant_count                              AS location_competitor_count,
    lc.location_avg_rate,
    lc.location_avg_cost,
    CASE
        WHEN s.avg_rate IS NULL OR s.max_votes IS NULL THEN NULL
        ELSE (s.avg_rate * s.max_votes) * 1.0 / (s.max_votes + 50.0)
    END                                              AS success_score,
    CASE
        WHEN s.avg_rate >= 4.0 AND s.max_votes >= 100 THEN 1
        ELSE 0
    END                                              AS is_successful
FROM restaurants r
LEFT JOIN locations l
    ON l.location_id = r.location_id
LEFT JOIN vw_restaurant_rating_stats s
    ON s.restaurant_id = r.restaurant_id
LEFT JOIN vw_location_competition lc
    ON lc.location_id = r.location_id;

-- Sample analytical queries -------------------------------------------------

-- Top locations by predicted demand (success score)
-- SELECT location_name, COUNT(*) AS n, AVG(success_score) AS avg_success
-- FROM vw_model_features
-- GROUP BY location_name
-- ORDER BY avg_success DESC
-- LIMIT 15;

-- Cuisine mix of successful restaurants
-- SELECT c.cuisine_name, COUNT(*) AS successful_restaurants
-- FROM vw_model_features f
-- JOIN restaurant_cuisines rc ON rc.restaurant_id = f.restaurant_id
-- JOIN cuisines c ON c.cuisine_id = rc.cuisine_id
-- WHERE f.is_successful = 1
-- GROUP BY c.cuisine_name
-- ORDER BY successful_restaurants DESC
-- LIMIT 20;
