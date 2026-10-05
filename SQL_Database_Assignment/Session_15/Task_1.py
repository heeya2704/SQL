# ============================================
# Session 15
# Task 01
# Topic: Python sqlite3 Database & Table Setup
# Objective: Create foodie.db SQLite database and Restaurants table
# ============================================

import sqlite3
import os

def setup_foodie_database(db_path='foodie.db'):
    """
    Connects to SQLite database (creates foodie.db if it doesn't exist)
    and initializes the Restaurants table.
    """
    print(f"Connecting to SQLite database at: {db_path}...")
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()
    
    # Create Restaurants Table
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS Restaurants (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            cuisine TEXT NOT NULL,
            rating REAL NOT NULL CHECK (rating >= 0.0 AND rating <= 5.0)
        )
    ''')
    
    conn.commit()
    print("Table 'Restaurants' successfully created/verified in foodie.db!")
    conn.close()

if __name__ == '__main__':
    setup_foodie_database()
