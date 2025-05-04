import sqlite3
from sqlite3 import Error

def create_database():
    conn = create_connection('diplomDB.db')

    if conn is not None:
        create_tables(conn)
        conn.close()
    else:
        print("Error! Could not create database connection.")



def create_connection(db_file):
    """ Create a connection to SQLite database """
    conn = None
    try:
        conn = sqlite3.connect(db_file)
        print(f"Connected to SQLite version {sqlite3.version}")
        return conn
    except Error as e:
        print(e)
    
    return conn

def create_tables(conn):
    """ Create tables in the database """
    try:
        c = conn.cursor()
        
        # Course table
        c.execute('''CREATE TABLE IF NOT EXISTS Course (
                        id INTEGER PRIMARY KEY AUTOINCREMENT,
                        name TEXT NOT NULL,
                        description TEXT
                     )''')
        
        # Module table
        c.execute('''CREATE TABLE IF NOT EXISTS Module (
                        id INTEGER PRIMARY KEY AUTOINCREMENT,
                        course_id INTEGER NOT NULL,
                        name TEXT NOT NULL,
                        order_num INTEGER,
                        FOREIGN KEY (course_id) REFERENCES Course (id)
                     )''')
        
        # Staff (teachers) table
        c.execute('''CREATE TABLE IF NOT EXISTS Staff (
                        id INTEGER PRIMARY KEY AUTOINCREMENT,
                        first_name TEXT NOT NULL,
                        last_name TEXT NOT NULL,
                        position TEXT,
                        email TEXT UNIQUE
                     )''')
        
        # Lecture table
        c.execute('''CREATE TABLE IF NOT EXISTS Lecture (
                        id INTEGER PRIMARY KEY AUTOINCREMENT,
                        module_id INTEGER NOT NULL,
                        staff_id INTEGER NOT NULL,
                        name TEXT NOT NULL,
                        content TEXT,
                        date DATE,
                        FOREIGN KEY (module_id) REFERENCES Module (id),
                        FOREIGN KEY (staff_id) REFERENCES Staff (id)
                     )''')
        
        # Webinar table
        c.execute('''CREATE TABLE IF NOT EXISTS Webinar (
                        id INTEGER PRIMARY KEY AUTOINCREMENT,
                        lecture_id INTEGER NOT NULL,
                        link TEXT,
                        start_datetime DATETIME,
                        duration INTEGER,  # in minutes
                        FOREIGN KEY (lecture_id) REFERENCES Lecture (id)
                     )''')
        
        # Assignment table
        c.execute('''CREATE TABLE IF NOT EXISTS Assignment (
                        id INTEGER PRIMARY KEY AUTOINCREMENT,
                        module_id INTEGER NOT NULL,
                        name TEXT NOT NULL,
                        description TEXT,
                        due_date DATE,
                        max_score INTEGER,
                        FOREIGN KEY (module_id) REFERENCES Module (id)
                     )''')
        
        # Test table
        c.execute('''CREATE TABLE IF NOT EXISTS Test (
                        id INTEGER PRIMARY KEY AUTOINCREMENT,
                        module_id INTEGER NOT NULL,
                        name TEXT NOT NULL,
                        time_limit INTEGER,  # in minutes
                        max_score INTEGER,
                        FOREIGN KEY (module_id) REFERENCES Module (id)
                     )''')
        
        # Question table
        c.execute('''CREATE TABLE IF NOT EXISTS Question (
                        id INTEGER PRIMARY KEY AUTOINCREMENT,
                        test_id INTEGER NOT NULL,
                        text TEXT NOT NULL,
                        type TEXT,  # e.g., "single answer", "multiple choice"
                        score INTEGER,
                        FOREIGN KEY (test_id) REFERENCES Test (id)
                     )''')
        
        # Testing (student's test attempt) table
        c.execute('''CREATE TABLE IF NOT EXISTS Testing (
                        id INTEGER PRIMARY KEY AUTOINCREMENT,
                        test_id INTEGER NOT NULL,
                        student_id INTEGER NOT NULL,
                        completion_date DATETIME,
                        score INTEGER,
                        FOREIGN KEY (test_id) REFERENCES Test (id)
                     )''')
        
        # Assignment Review table
        c.execute('''CREATE TABLE IF NOT EXISTS Assignment_Review (
                        id INTEGER PRIMARY KEY AUTOINCREMENT,
                        assignment_id INTEGER NOT NULL,
                        student_id INTEGER NOT NULL,
                        reviewer_id INTEGER NOT NULL,
                        review_date DATE,
                        score INTEGER,
                        comment TEXT,
                        FOREIGN KEY (assignment_id) REFERENCES Assignment (id),
                        FOREIGN KEY (reviewer_id) REFERENCES Staff (id)
                     )''')
        
        # Feedback table
        c.execute('''CREATE TABLE IF NOT EXISTS Feedback (
                        id INTEGER PRIMARY KEY AUTOINCREMENT,
                        review_id INTEGER NOT NULL,
                        text TEXT,
                        date DATE,
                        FOREIGN KEY (review_id) REFERENCES Assignment_Review (id)
                     )''')
        
        # Student table
        c.execute('''CREATE TABLE IF NOT EXISTS Student (
                        id INTEGER PRIMARY KEY AUTOINCREMENT,
                        first_name TEXT NOT NULL,
                        last_name TEXT NOT NULL,
                        email TEXT UNIQUE,
                        registration_date DATE
                     )''')
        
        print("Tables created successfully")
    except Error as e:
        print(e)

