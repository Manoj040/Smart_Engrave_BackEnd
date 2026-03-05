import re
import random
import secrets
import traceback
import smtplib
from email.mime.text import MIMEText
from datetime import datetime, timedelta

from flask import Flask, request, jsonify
from flask_cors import CORS
from flask_bcrypt import Bcrypt
from werkzeug.exceptions import HTTPException

from config import Config
from models import db, User, PasswordReset

app = Flask(__name__)
app.config.from_object(Config)

CORS(app)
db.init_app(app)
bcrypt = Bcrypt(app)

with app.app_context():
    db.create_all()

# ---------------- GLOBAL ERROR HANDLER ----------------
@app.errorhandler(Exception)
def handle_any_exception(e):
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
def now_utc():
    return datetime.utcnow()

def norm_email(s: str) -> str:
    return (s or "").strip().lower()

def send_otp_email(to_email: str, otp: str):
    sender = app.config.get("SMTP_EMAIL")
    password = app.config.get("SMTP_APP_PASSWORD")

    if not sender or not password:
        raise RuntimeError("Missing SMTP_EMAIL / SMTP_APP_PASSWORD in .env")

    subject = "SmartEngrave Password Reset OTP"
    body = f"Your OTP is: {otp}\nThis OTP will expire in 5 minutes."

    msg = MIMEText(body)
    msg["Subject"] = subject
    msg["From"] = sender
    msg["To"] = to_email

    server = smtplib.SMTP("smtp.gmail.com", 587)
    server.starttls()
    server.login(sender, password)
    server.sendmail(sender, to_email, msg.as_string())
    server.quit()


# ---------------- HEALTH ----------------
@app.route("/", methods=["GET"])
def home():
    return "✅ SmartEngrave Backend Running"


# ---------------- SIGNUP ----------------
@app.route("/signup", methods=["POST"])
def signup():
    data = request.get_json(silent=True) or {}

    # ✅ support both keys: full_name OR name
    full_name = (data.get("full_name") or data.get("name") or "").strip()
    email = norm_email(data.get("email"))
    password = (data.get("password") or "").strip()
    confirm_password = (data.get("confirm_password") or "").strip()

    if not full_name or not email or not password or not confirm_password:
        return jsonify({"status": "fail", "message": "Missing fields"}), 400

    email_regex = r"^[\w\.-]+@[\w\.-]+\.\w+$"
    if not re.match(email_regex, email):
        return jsonify({"status": "fail", "message": "Invalid email format"}), 400

    if password != confirm_password:
        return jsonify({"status": "fail", "message": "Passwords do not match"}), 400

    existing = User.query.filter_by(email=email).first()
    if existing:
        return jsonify({"status": "fail", "message": "Email already exists"}), 409

    password_hash = bcrypt.generate_password_hash(password).decode("utf-8")

    user = User(full_name=full_name, email=email, password_hash=password_hash)
    db.session.add(user)
    db.session.commit()

    return jsonify({
        "status": "success",
        "message": "Account created",
        "user": {"id": user.id, "full_name": user.full_name, "email": user.email}
    }), 201


# ---------------- LOGIN ----------------
@app.route("/login", methods=["POST"])
def login():
    data = request.get_json(silent=True) or {}

    email = norm_email(data.get("email"))
    password = (data.get("password") or "").strip()

    if not email or not password:
        return jsonify({"status": "fail", "message": "Missing email or password"}), 400

    user = User.query.filter_by(email=email).first()
    if not user:
        return jsonify({"status": "fail", "message": "Invalid credentials"}), 401

    if not bcrypt.check_password_hash(user.password_hash, password):
        return jsonify({"status": "fail", "message": "Invalid credentials"}), 401

    return jsonify({
        "status": "success",
        "message": "Login successful",
        "user": {"id": user.id, "full_name": user.full_name, "email": user.email}
    }), 200


# ==========================================================
# FORGOT PASSWORD FLOW
# 1) /forgot-password   (email) -> send OTP (6 digits)
# 2) /verify-otp        (email + otp) -> returns reset_token
# 3) /reset-password    (reset_token + new_password + confirm_password)
# ==========================================================

# ---------------- 1) SEND OTP ----------------
@app.route("/forgot-password", methods=["POST"])
def forgot_password():
    data = request.get_json(silent=True) or {}
    email = norm_email(data.get("email"))

    if not email:
        return jsonify({"status": "fail", "message": "Email required"}), 400

    user = User.query.filter_by(email=email).first()
    if not user:
        return jsonify({"status": "fail", "message": "Email not registered"}), 404

    otp = str(random.randint(100000, 999999))  # ✅ 6-digit OTP
    otp_hash = bcrypt.generate_password_hash(otp).decode("utf-8")
    expires_at = now_utc() + timedelta(minutes=5)

    # ✅ Invalidate old active OTPs for this email
    PasswordReset.query.filter_by(email=email, is_used=False).update({"is_used": True})
    db.session.commit()

    pr = PasswordReset(
        email=email,
        otp_hash=otp_hash,
        otp_expires_at=expires_at,
        attempts=0,
        is_used=False
    )
    db.session.add(pr)
    db.session.commit()

    # Send email
    send_otp_email(email, otp)

    return jsonify({"status": "success", "message": "OTP sent to email"}), 200


# ---------------- 2) VERIFY OTP ----------------
@app.route("/verify-otp", methods=["POST"])
def verify_otp():
    data = request.get_json(silent=True) or {}
    email = norm_email(data.get("email"))
    otp = (str(data.get("otp") or "")).strip()

    if not email or not otp:
        return jsonify({"status": "fail", "message": "Email and OTP required"}), 400

    pr = (PasswordReset.query
          .filter_by(email=email, is_used=False)
          .order_by(PasswordReset.id.desc())
          .first())

    if not pr:
        return jsonify({"status": "fail", "message": "No active OTP request found"}), 404

    if pr.attempts >= 5:
        pr.is_used = True
        db.session.commit()
        return jsonify({"status": "fail", "message": "Too many attempts. Request OTP again."}), 429

    if now_utc() > pr.otp_expires_at:
        pr.is_used = True
        db.session.commit()
        return jsonify({"status": "fail", "message": "OTP expired. Request again."}), 400

    if not bcrypt.check_password_hash(pr.otp_hash, otp):
        pr.attempts += 1
        db.session.commit()
        return jsonify({"status": "fail", "message": "Invalid OTP"}), 401

    reset_token = secrets.token_hex(32)
    reset_expires = now_utc() + timedelta(minutes=10)

    pr.reset_token = reset_token
    pr.reset_token_expires_at = reset_expires
    db.session.commit()

    return jsonify({
        "status": "success",
        "message": "OTP verified",
        "reset_token": reset_token
    }), 200


# ---------------- 3) RESET PASSWORD ----------------
@app.route("/reset-password", methods=["POST"])
def reset_password():
    data = request.get_json(silent=True) or {}
    reset_token = (data.get("reset_token") or "").strip()
    new_password = (data.get("new_password") or "").strip()
    confirm_password = (data.get("confirm_password") or "").strip()

    if not reset_token or not new_password or not confirm_password:
        return jsonify({"status": "fail", "message": "Missing fields"}), 400

    if new_password != confirm_password:
        return jsonify({"status": "fail", "message": "Passwords do not match"}), 400

    pr = (PasswordReset.query
          .filter_by(reset_token=reset_token)
          .order_by(PasswordReset.id.desc())
          .first())

    if not pr or pr.is_used:
        return jsonify({"status": "fail", "message": "Invalid reset request"}), 400

    if not pr.reset_token_expires_at or now_utc() > pr.reset_token_expires_at:
        pr.is_used = True
        db.session.commit()
        return jsonify({"status": "fail", "message": "Reset token expired. Verify OTP again."}), 400

    user = User.query.filter_by(email=pr.email).first()
    if not user:
        pr.is_used = True
        db.session.commit()
        return jsonify({"status": "fail", "message": "User not found"}), 404

    user.password_hash = bcrypt.generate_password_hash(new_password).decode("utf-8")
    pr.is_used = True
    db.session.commit()

    return jsonify({"status": "success", "message": "Password reset successful"}), 200


if __name__ == "__main__":
    app.run(host="127.0.0.1", port=app.config["APP_PORT"], debug=True)