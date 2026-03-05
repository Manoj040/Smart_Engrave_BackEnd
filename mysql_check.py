import mysql.connector
import traceback

print("Trying connect...")

try:
    db = mysql.connector.connect(
        host="127.0.0.1",
        user="root",
        password="",
        database="smartengrave_db",
        port=3306,
        connection_timeout=5
    )
    print("CONNECTED ✅")
    db.close()
except Exception as e:
    print("CONNECT FAILED ❌:", e)
    traceback.print_exc()
