# ============================================
# Session 15
# Task 02
# Topic: Data Insertion & Querying with Python sqlite3
# Objective: Insert sample restaurants and query high-rated restaurants (> 4.0)
# ============================================

import sqlite3

def insert_and_query_restaurants(db_path='foodie.db'):
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()
    
    # Ensure Table Exists
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS Restaurants (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            cuisine TEXT NOT NULL,
            rating REAL NOT NULL
        )
    ''')
    
    # Insert 3 Sample Restaurants
    sample_restaurants = [
        ('Truffles', 'American', 4.6),
        ('Trattoria Bella', 'Italian', 4.3),
        ('Corner Diner', 'Fast Food', 3.8)
    ]
    
    cursor.executemany('''
        INSERT INTO Restaurants (name, cuisine, rating) 
        VALUES (?, ?, ?)
    ''', sample_restaurants)
    conn.commit()
    print(f"Inserted {len(sample_restaurants)} sample rows into Restaurants table.")
    
    # Query restaurants with rating > 4.0
    print("\nRestaurants with rating > 4.0:")
    cursor.execute("SELECT name, cuisine, rating FROM Restaurants WHERE rating > 4.0")
    high_rated = cursor.fetchall()
    
    for row in high_rated:
        print(f" - {row[0]} ({row[1]}, Rating: {row[2]})")
        
    conn.close()

if __name__ == '__main__':
    insert_and_query_restaurants()
