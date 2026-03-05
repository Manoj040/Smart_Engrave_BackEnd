import traceback
from db import get_db

print("Starting DB test...")

try:
    db = get_db()
    print("Connected OK ✅")

    cur = db.cursor()
    cur.execute("SELECT DATABASE()")
    print("Current DB:", cur.fetchone())

    cur.execute("SHOW TABLES")
    print("Tables:", cur.fetchall())

    cur.close()
    db.close()
    print("Closed DB ✅")

except Exception as e:
    print("DB ERROR ❌:", e)
    traceback.print_exc()
