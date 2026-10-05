"""SQLAlchemy 2.0 models for analytics_db (Zomato 3NF schema)."""

from __future__ import annotations

from sqlalchemy import (
    Boolean,
    CheckConstraint,
    Column,
    ForeignKey,
    Index,
    Integer,
    Numeric,
    String,
    Text,
    UniqueConstraint,
)
from sqlalchemy.orm import DeclarativeBase, relationship


class Base(DeclarativeBase):
    pass


class Location(Base):
    __tablename__ = "locations"

    location_id = Column(Integer, primary_key=True, autoincrement=True)
    location_name = Column(String(255), nullable=False, unique=True)

    restaurants = relationship("Restaurant", back_populates="location")


class Cuisine(Base):
    __tablename__ = "cuisines"

    cuisine_id = Column(Integer, primary_key=True, autoincrement=True)
    cuisine_name = Column(String(120), nullable=False, unique=True)

    restaurant_links = relationship("RestaurantCuisine", back_populates="cuisine")


class RestaurantType(Base):
    __tablename__ = "restaurant_types"

    rest_type_id = Column(Integer, primary_key=True, autoincrement=True)
    rest_type_name = Column(String(120), nullable=False, unique=True)

    restaurant_links = relationship("RestaurantTypeMap", back_populates="rest_type")


class Restaurant(Base):
    __tablename__ = "restaurants"
    __table_args__ = (
        UniqueConstraint("url", name="uq_restaurants_url"),
        Index("idx_restaurants_location_id", "location_id"),
        Index("idx_restaurants_name", "restaurant_name"),
    )

    restaurant_id = Column(Integer, primary_key=True, autoincrement=True)
    restaurant_name = Column(String(255), nullable=False)
    url = Column(String(500), nullable=False)
    address = Column(Text)
    phone = Column(String(255))
    online_order = Column(Boolean, nullable=False, default=False)
    book_table = Column(Boolean, nullable=False, default=False)
    approx_cost_for_two = Column(Integer)
    location_id = Column(
        Integer,
        ForeignKey("locations.location_id", ondelete="CASCADE"),
        nullable=True,
    )

    location = relationship("Location", back_populates="restaurants")
    ratings = relationship("Rating", back_populates="restaurant", cascade="all, delete-orphan")
    cuisine_links = relationship(
        "RestaurantCuisine", back_populates="restaurant", cascade="all, delete-orphan"
    )
    type_links = relationship(
        "RestaurantTypeMap", back_populates="restaurant", cascade="all, delete-orphan"
    )


class RestaurantCuisine(Base):
    __tablename__ = "restaurant_cuisines"
    __table_args__ = (Index("idx_restaurant_cuisines_cuisine_id", "cuisine_id"),)

    restaurant_id = Column(
        Integer,
        ForeignKey("restaurants.restaurant_id", ondelete="CASCADE"),
        primary_key=True,
    )
    cuisine_id = Column(
        Integer,
        ForeignKey("cuisines.cuisine_id", ondelete="CASCADE"),
        primary_key=True,
    )

    restaurant = relationship("Restaurant", back_populates="cuisine_links")
    cuisine = relationship("Cuisine", back_populates="restaurant_links")


class RestaurantTypeMap(Base):
    __tablename__ = "restaurant_type_map"

    restaurant_id = Column(
        Integer,
        ForeignKey("restaurants.restaurant_id", ondelete="CASCADE"),
        primary_key=True,
    )
    rest_type_id = Column(
        Integer,
        ForeignKey("restaurant_types.rest_type_id", ondelete="CASCADE"),
        primary_key=True,
    )

    restaurant = relationship("Restaurant", back_populates="type_links")
    rest_type = relationship("RestaurantType", back_populates="restaurant_links")


class Rating(Base):
    """Composite primary key: one rating row per restaurant listing context."""

    __tablename__ = "ratings"
    __table_args__ = (
        CheckConstraint("votes >= 0", name="ck_ratings_votes_nonneg"),
        Index("idx_ratings_listed_in_city", "listed_in_city"),
        Index("idx_ratings_rate", "rate"),
    )

    restaurant_id = Column(
        Integer,
        ForeignKey("restaurants.restaurant_id", ondelete="CASCADE"),
        primary_key=True,
    )
    listed_in_type = Column(String(100), primary_key=True)
    listed_in_city = Column(String(100), primary_key=True)
    rate = Column(Numeric(3, 1))
    votes = Column(Integer, nullable=False, default=0)

    restaurant = relationship("Restaurant", back_populates="ratings")
