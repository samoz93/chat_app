import sqlite3
from datetime import datetime


REQUEST_INTERVAL = 60 * 60 * 5 # 1 hour



def init_db():
    print("Initializing database")
    conn = sqlite3.connect('database.db') 
    c = conn.cursor()            
    c.execute('''
            CREATE TABLE IF NOT EXISTS jobs
            ([id] INTEGER PRIMARY KEY AUTOINCREMENT, 
            [user_id] TEXT NOT NULL,
            [room_id] TEXT NOT NULL,
            [created] TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            )
            ''')
                        
    conn.commit()


def get_db_connection():
    conn = sqlite3.connect('database.db')
    conn.row_factory = sqlite3.Row
    return conn


def can_paint(user_id,room_id):
        # Check if the user has already requested a painting
    conn = get_db_connection()
    posts = conn.execute('SELECT * FROM jobs where user_id = ? AND room_id= ? ',[user_id , room_id]).fetchone()
    canRequest = True if not posts else (datetime.now() - datetime.strptime(posts['created'], '%Y-%m-%d %H:%M:%S')).total_seconds() > REQUEST_INTERVAL
    if not canRequest:
        return False
    
    conn.execute('DELETE FROM jobs where user_id = ? AND room_id = ?',[user_id,room_id])
    conn.execute('INSERT INTO jobs (user_id,room_id) VALUES (?,?)',
                (user_id,room_id))
    conn.commit()
    return True
