# ============================================
# Session 15
# Task 03
# Topic: SQLite to Pandas Integration
# Objective: Load Restaurants table into Pandas DataFrame and preview top rows
# ============================================

import sqlite3
import pandas as pd

def load_restaurants_to_dataframe(db_path='foodie.db'):
    conn = sqlite3.connect(db_path)
    
    # Ensure sample data exists
    cursor = conn.cursor()
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS Restaurants (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            cuisine TEXT NOT NULL,
            rating REAL NOT NULL
        )
    ''')
    cursor.execute("SELECT COUNT(*) FROM Restaurants")
    if cursor.fetchone()[0] == 0:
        cursor.executemany("INSERT INTO Restaurants (name, cuisine, rating) VALUES (?, ?, ?)", [
            ('Truffles', 'American', 4.6),
            ('Trattoria Bella', 'Italian', 4.3),
            ('Corner Diner', 'Fast Food', 3.8)
        ])
        conn.commit()

    # Load into Pandas DataFrame
    query = "SELECT * FROM Restaurants"
    df = pd.read_sql_query(query, conn)
    conn.close()
    
    print("DataFrame successfully loaded from foodie.db!")
    print("\n--- DataFrame Head (Top 2 Rows) ---")
    print(df.head(2))
    
    return df

if __name__ == '__main__':
    load_restaurants_to_dataframe()
