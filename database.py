import mysql.connector

def get_db_connection():
    connection = mysql.connector.connect(
        host="localhost",
        user="root",      # Mặc định của XAMPP
        password="",      # Mặc định trống
        database="web_db"
    )
    return connection