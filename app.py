from flask import Flask, request, jsonify
from flask_bcrypt import Bcrypt
from flask_cors import CORS
from flask_mail import Mail, Message
from datetime import datetime, timedelta
import random
import secrets
import traceback
import pymysql

from config import Config
from db import get_db

app = Flask(__name__)
app.config.from_object(Config)

bcrypt = Bcrypt(app)
mail = Mail(app)
CORS(app)

# ---------------- GLOBAL ERROR HANDLER ----------------
from werkzeug.exceptions import HTTPException

@app.errorhandler(Exception)
def handle_any_exception(e):
    # If it's an HTTP error like 404/405, return it normally (don't make it 500)
    if isinstance(e, HTTPException):
        return jsonify({
            "status": "fail",
            "message": e.name,
            "error": e.description
        }), e.code

    print("\n🔥 UNHANDLED ERROR:", repr(e))
    traceback.print_exc()
    return jsonify({"status": "fail", "message": "Server error", "error": str(e)}), 500


# ---------------- HELPERS ----------------
def safe_db_commit(db):
    try:
        db.commit()
        return True
    except Exception:
        db.rollback()
        return False

def now_local():
    return datetime.now()

def send_otp_email(to_email: str, otp: str):
    msg = Message(
        subject="SmartEngrave Password Reset OTP",
        recipients=[to_email],
        sender=app.config.get("MAIL_DEFAULT_SENDER"),
        body=f"Your SmartEngrave OTP is: {otp}\nThis OTP will expire in 5 minutes."
    )
    mail.send(msg)

# ---------------- HEALTH ----------------
@app.route("/", methods=["GET"])
def home():
    return "SmartEngrave Backend Running Successfully"

# ---------------- SIGNUP ----------------
@app.route("/signup", methods=["POST"])
def signup():
    data = request.get_json(silent=True) or {}

    full_name = data.get("full_name") or data.get("name")
    # email = data.get("email")
    email = (data.get("email") or "").strip().lower()
    password = data.get("password")
    confirm_password = data.get("confirm_password")

    if not all([full_name, email, password, confirm_password]):
        return jsonify({"status": "fail", "message": "Missing fields"}), 400
    if password != confirm_password:
        return jsonify({"status": "fail", "message": "Passwords do not match"}), 400

    db = get_db()
    cur = db.cursor()

    cur.execute("SELECT id FROM users WHERE email=%s", (email,))
    if cur.fetchone():
        cur.close(); db.close()
        return jsonify({"status": "fail", "message": "Email already exists"}), 409

    password_hash = bcrypt.generate_password_hash(password).decode("utf-8")
    cur.execute(
        "INSERT INTO users (full_name, email, password_hash) VALUES (%s,%s,%s)",
        (full_name, email, password_hash)
    )

    if not safe_db_commit(db):
        cur.close(); db.close()
        return jsonify({"status": "fail", "message": "DB error"}), 500

    user_id = cur.lastrowid
    cur.close(); db.close()

    return jsonify({
        "status": "success",
        "message": "Account created",
        "user": {"id": user_id, "full_name": full_name, "email": email}
    }), 201

# ---------------- LOGIN ----------------
@app.route("/login", methods=["POST"])
def login():
    data = request.get_json(silent=True) or {}
    # email = data.get("email")
    email = (data.get("email") or "").strip().lower()
    password = data.get("password")

    if not email or not password:
        return jsonify({"status": "fail", "message": "Missing email or password"}), 400

    db = get_db()
    cur = db.cursor(pymysql.cursors.DictCursor)

    cur.execute("SELECT id, full_name, email, password_hash FROM users WHERE email=%s", (email,))
    user = cur.fetchone()
    cur.close(); db.close()

    if not user:
        return jsonify({"status": "fail", "message": "Invalid credentials"}), 401
    if not bcrypt.check_password_hash(user["password_hash"], password):
        return jsonify({"status": "fail", "message": "Invalid credentials"}), 401

    return jsonify({
        "status": "success",
        "message": "Login successful",
        "user": {"id": user["id"], "full_name": user["full_name"], "email": user["email"]}
    }), 200

# ==========================================================
# FORGOT PASSWORD FLOW (3 PAGES)
# Page 1: email
# Page 2: otp
# Page 3: new_password + confirm_password
# ==========================================================

# ---------------- PAGE 1: SEND OTP (EMAIL ONLY) ----------------
@app.route("/forgot-password", methods=["POST"])
def forgot_password():
    data = request.get_json(silent=True) or {}

    # ✅ normalize email (fixes "user not found" due to spaces/case)
    email = (data.get("email") or "").strip().lower()

    print("✅ forgot-password email received:", repr(email))

    if not email:
        return jsonify({"status": "fail", "message": "Email required"}), 400

    db = get_db()
    cur = db.cursor(pymysql.cursors.DictCursor)

    # ✅ Debug: check DB result
    cur.execute("SELECT id, email FROM users WHERE email=%s", (email,))
    row = cur.fetchone()
    print("✅ DB result:", row)

    if not row:
        cur.close(); db.close()
        return jsonify({"status": "fail", "message": "Email not registered"}), 404

    otp = str(random.randint(100000, 999999))
    otp_hash = bcrypt.generate_password_hash(otp).decode("utf-8")
    expires_at = now_local() + timedelta(minutes=5)

    # Invalidate old requests
    cur.execute("UPDATE password_resets SET is_used=1 WHERE email=%s AND is_used=0", (email,))

    # Save hashed OTP
    cur.execute(
        "INSERT INTO password_resets (email, otp_hash, otp_expires_at) VALUES (%s,%s,%s)",
        (email, otp_hash, expires_at)
    )

    if not safe_db_commit(db):
        cur.close(); db.close()
        return jsonify({"status": "fail", "message": "DB error"}), 500

    try:
        send_otp_email(email, otp)
    except Exception as e:
        print(f"❌ MAIL SEND ERROR: {str(e)}")
        import traceback
        traceback.print_exc()
        cur.close(); db.close()
        return jsonify({
            "status": "fail",
            "message": f"OTP could not be sent: {str(e)}. Check MAIL settings.",
            "error": str(e)
        }), 500

    cur.close(); db.close()
    return jsonify({"status": "success", "message": "OTP sent to email"}), 200

# ---------------- PAGE 2: VERIFY OTP (OTP ONLY) ----------------
@app.route("/verify-otp", methods=["POST"])
def verify_otp():
    data = request.get_json(silent=True) or {}
    otp = str(data.get("otp") or "").strip()

    if not otp:
        return jsonify({"status": "fail", "message": "OTP required"}), 400

    db = get_db()
    cur = db.cursor(pymysql.cursors.DictCursor)

    # Get latest active OTP (no email needed)
    cur.execute("""
        SELECT id, email, otp_hash, otp_expires_at, attempts, is_used
        FROM password_resets
        WHERE is_used=0
        ORDER BY id DESC
        LIMIT 1
    """)
    row = cur.fetchone()

    if not row:
        cur.close(); db.close()
        return jsonify({"status": "fail", "message": "No active OTP request found"}), 404

    if row["attempts"] >= 5:
        cur.execute("UPDATE password_resets SET is_used=1 WHERE id=%s", (row["id"],))
        safe_db_commit(db)
        cur.close(); db.close()
        return jsonify({"status": "fail", "message": "Too many attempts. Request OTP again."}), 429

    if now_local() > row["otp_expires_at"]:
        cur.execute("UPDATE password_resets SET is_used=1 WHERE id=%s", (row["id"],))
        safe_db_commit(db)
        cur.close(); db.close()
        return jsonify({"status": "fail", "message": "OTP expired. Request again."}), 400

    if not bcrypt.check_password_hash(row["otp_hash"], otp):
        cur.execute("UPDATE password_resets SET attempts=attempts+1 WHERE id=%s", (row["id"],))
        safe_db_commit(db)
        cur.close(); db.close()
        return jsonify({"status": "fail", "message": "Invalid OTP"}), 401

    # Create reset token
    reset_token = secrets.token_hex(32)
    reset_expires = now_local() + timedelta(minutes=10)

    cur.execute("""
        UPDATE password_resets
        SET reset_token=%s, reset_token_expires_at=%s
        WHERE id=%s
    """, (reset_token, reset_expires, row["id"]))

    safe_db_commit(db)
    cur.close(); db.close()

    # Frontend stores reset_token and navigates to Reset Password page
    return jsonify({
        "status": "success",
        "message": "OTP verified",
        "reset_token": reset_token
    }), 200

# ---------------- PAGE 3: RESET PASSWORD (TOKEN + NEW PASSWORDS) ----------------
@app.route("/reset-password", methods=["POST"])
def reset_password():
    data = request.get_json(silent=True) or {}
    reset_token = data.get("reset_token")
    new_password = data.get("new_password")
    confirm_password = data.get("confirm_password")

    if not all([reset_token, new_password, confirm_password]):
        return jsonify({"status": "fail", "message": "Missing fields"}), 400

    if new_password != confirm_password:
        return jsonify({"status": "fail", "message": "Passwords do not match"}), 400

    db = get_db()
    cur = db.cursor(pymysql.cursors.DictCursor)

    # Find reset request by token
    cur.execute("""
        SELECT id, email, reset_token, reset_token_expires_at, is_used
        FROM password_resets
        WHERE reset_token=%s
        ORDER BY id DESC
        LIMIT 1
    """, (reset_token,))
    row = cur.fetchone()

    if not row or row["is_used"] == 1:
        cur.close(); db.close()
        return jsonify({"status": "fail", "message": "Invalid reset request"}), 400

    if not row["reset_token_expires_at"] or now_local() > row["reset_token_expires_at"]:
        cur.execute("UPDATE password_resets SET is_used=1 WHERE id=%s", (row["id"],))
        safe_db_commit(db)
        cur.close(); db.close()
        return jsonify({"status": "fail", "message": "Reset token expired. Verify OTP again."}), 400

    # Update user password (email comes from DB, not frontend)
    new_hash = bcrypt.generate_password_hash(new_password).decode("utf-8")
    cur.execute("UPDATE users SET password_hash=%s WHERE email=%s", (new_hash, row["email"]))

    # Mark reset used
    cur.execute("UPDATE password_resets SET is_used=1 WHERE id=%s", (row["id"],))

    if not safe_db_commit(db):
        cur.close(); db.close()
        return jsonify({"status": "fail", "message": "DB error"}), 500

    cur.close(); db.close()
    return jsonify({"status": "success", "message": "Password reset successful"}), 200


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000, debug=True)