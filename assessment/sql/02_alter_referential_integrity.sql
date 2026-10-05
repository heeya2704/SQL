-- =============================================================================
-- Section B.2 — Referential integrity via ALTER
-- Parent: locations.location_id
-- Child:  restaurants.location_id
-- ON DELETE CASCADE: removing a location removes its restaurants (and, through
-- existing restaurant child FKs, their ratings and cuisine links).
-- =============================================================================

USE analytics_db;

ALTER TABLE restaurants
    ADD CONSTRAINT fk_restaurants_location
    FOREIGN KEY (location_id)
    REFERENCES locations(location_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE;
