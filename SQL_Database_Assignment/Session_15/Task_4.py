# ============================================
# Session 15
# Task 04
# Topic: Pandas Feature Engineering & Lambda Functions
# Objective: Add delivery_charge column and calculate final_rating with conditional logic
# ============================================

import sqlite3
import pandas as pd

def transform_restaurant_dataframe(db_path='foodie.db'):
    conn = sqlite3.connect(db_path)
    
    # Load DataFrame
    df = pd.read_sql_query("SELECT * FROM Restaurants", conn)
    conn.close()
    
    # If empty, populate sample rows for demonstration
    if df.empty:
        df = pd.DataFrame([
            {'id': 1, 'name': 'Truffles', 'cuisine': 'American', 'rating': 4.6},
            {'id': 2, 'name': 'Trattoria Bella', 'cuisine': 'Italian', 'rating': 4.3},
            {'id': 3, 'name': 'Corner Diner', 'cuisine': 'Fast Food', 'rating': 3.8}
        ])
    
    # 1. Add fixed delivery_charge column = 50
    df['delivery_charge'] = 50
    
    # 2. Calculate final_rating using apply with lambda function: rating + 0.1 if Italian else 0.0
    df['final_rating'] = df.apply(
        lambda row: round(row['rating'] + (0.1 if str(row['cuisine']).strip().lower() == 'italian' else 0.0), 2),
        axis=1
    )
    
    print("--- Transformed DataFrame with Feature Engineering ---")
    print(df[['id', 'name', 'cuisine', 'rating', 'delivery_charge', 'final_rating']])
    
    return df

if __name__ == '__main__':
    transform_restaurant_dataframe()
