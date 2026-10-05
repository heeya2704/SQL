-- =============================================================================
-- Section C deliverable: Optimized SQL DDL for analytics_db
-- Predictive Demand Schema — Zomato Bangalore (3NF)
-- Target dialect: MySQL 8. SQLite is used by the Python pipeline locally.
-- =============================================================================

CREATE DATABASE IF NOT EXISTS analytics_db
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE analytics_db;

-- ---------------------------------------------------------------------------
-- Dimension: geographic area (parent of restaurants)
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS locations (
    location_id     INT            NOT NULL AUTO_INCREMENT,
    location_name   VARCHAR(255)   NOT NULL,
    CONSTRAINT pk_locations PRIMARY KEY (location_id),
    CONSTRAINT uq_locations_name UNIQUE (location_name)
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------------
-- Fact/core: one row per unique restaurant (identified by Zomato URL)
-- location_id FK is added in sql/02_alter_referential_integrity.sql
-- to demonstrate ALTER-based referential integrity (Section B.2).
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS restaurants (
    restaurant_id         INT            NOT NULL AUTO_INCREMENT,
    restaurant_name       VARCHAR(255)   NOT NULL,
    url                   VARCHAR(500)   NOT NULL,
    address               TEXT           NULL,
    phone                 VARCHAR(255)   NULL,
    online_order          TINYINT(1)     NOT NULL DEFAULT 0,
    book_table            TINYINT(1)     NOT NULL DEFAULT 0,
    approx_cost_for_two   INT            NULL,
    location_id           INT            NULL,
    CONSTRAINT pk_restaurants PRIMARY KEY (restaurant_id),
    CONSTRAINT uq_restaurants_url UNIQUE (url),
    CONSTRAINT ck_restaurants_name_not_blank
        CHECK (CHAR_LENGTH(TRIM(restaurant_name)) > 0),
    CONSTRAINT ck_restaurants_cost_nonneg
        CHECK (approx_cost_for_two IS NULL OR approx_cost_for_two >= 0)
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------------
-- Cuisine dictionary (3NF: atomic cuisine values, not comma lists)
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS cuisines (
    cuisine_id     INT            NOT NULL AUTO_INCREMENT,
    cuisine_name   VARCHAR(120)   NOT NULL,
    CONSTRAINT pk_cuisines PRIMARY KEY (cuisine_id),
    CONSTRAINT uq_cuisines_name UNIQUE (cuisine_name)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS restaurant_cuisines (
    restaurant_id  INT NOT NULL,
    cuisine_id     INT NOT NULL,
    CONSTRAINT pk_restaurant_cuisines PRIMARY KEY (restaurant_id, cuisine_id),
    CONSTRAINT fk_rc_restaurant
        FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_rc_cuisine
        FOREIGN KEY (cuisine_id) REFERENCES cuisines(cuisine_id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------------
-- Restaurant service formats (Casual Dining, Cafe, Quick Bites, ...)
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS restaurant_types (
    rest_type_id     INT            NOT NULL AUTO_INCREMENT,
    rest_type_name   VARCHAR(120)   NOT NULL,
    CONSTRAINT pk_restaurant_types PRIMARY KEY (rest_type_id),
    CONSTRAINT uq_restaurant_types_name UNIQUE (rest_type_name)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS restaurant_type_map (
    restaurant_id  INT NOT NULL,
    rest_type_id   INT NOT NULL,
    CONSTRAINT pk_restaurant_type_map PRIMARY KEY (restaurant_id, rest_type_id),
    CONSTRAINT fk_rtm_restaurant
        FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_rtm_type
        FOREIGN KEY (rest_type_id) REFERENCES restaurant_types(rest_type_id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------------
-- Ratings: composite PK = restaurant + Zomato listing context
-- Same venue can appear under several listed_in(type) / listed_in(city)
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ratings (
    restaurant_id     INT            NOT NULL,
    listed_in_type    VARCHAR(100)   NOT NULL,
    listed_in_city    VARCHAR(100)   NOT NULL,
    rate              DECIMAL(3,1)   NULL,
    votes             INT            NOT NULL DEFAULT 0,
    CONSTRAINT pk_ratings PRIMARY KEY (restaurant_id, listed_in_type, listed_in_city),
    CONSTRAINT fk_ratings_restaurant
        FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT ck_ratings_rate_scale
        CHECK (rate IS NULL OR (rate >= 0 AND rate <= 5)),
    CONSTRAINT ck_ratings_votes_nonneg
        CHECK (votes >= 0)
) ENGINE=InnoDB;
