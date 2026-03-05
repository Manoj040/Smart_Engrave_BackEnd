import pymysql
from config import Config

def get_db():
    return pymysql.connect(
        host=Config.DB_HOST,          # 127.0.0.1 recommended
        user=Config.DB_USER,          # root
        password=Config.DB_PASSWORD,  # "" for XAMPP default
        database=Config.DB_NAME,      # smartengrave_db
        port=3306,
        connect_timeout=5,
        autocommit=False
    )
