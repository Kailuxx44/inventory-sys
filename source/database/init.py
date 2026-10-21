import sqlite3
import os

DB_NAME = "database.db"
SCHEMA_FILE = "schema.sql"

def init_db(): # Initialize the database
    if not os.path.exists(SCHEMA_FILE):
        print(f"Schema file '{SCHEMA_FILE}' not found.")
        return

    conn = sqlite3.connect(DB_NAME)
    cursor = conn.cursor()
    print(f"Successfully initialized database '{DB_NAME}'.")

    with open(SCHEMA_FILE, 'r', encoding='utf-8') as f:
        sql_script = f.read()
    cursor.executescript(sql_script)

    conn.commit()
    conn.close()
    print(f"Database '{DB_NAME}' initialized with schema from '{SCHEMA_FILE}'.") 

if __name__ == "__main__":
    init_db()
