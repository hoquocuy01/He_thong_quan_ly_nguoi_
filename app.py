from flask import Flask, render_template, request, redirect, url_for, session, flash
from werkzeug.security import generate_password_hash, check_password_hash
from database import get_db_connection

app = Flask(__name__)
app.secret_key = 'your_secret_key' # Cần thiết để dùng session và flash

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        hashed_pw = generate_password_hash(password) # Mã hóa mật khẩu

        db = get_db_connection()
        cursor = db.cursor()
        
        try:
            cursor.execute("INSERT INTO users (username, password) VALUES (%s, %s)", (username, hashed_pw))
            db.commit()
            flash("Đăng ký thành công! Vui lòng đăng nhập.", "success")
            return redirect(url_for('login'))
        except:
            flash("Tên đăng nhập đã tồn tại!", "danger")
        finally:
            cursor.close()
            db.close()
            
    return render_template('register.html')

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password_candidate = request.form['password']

        db = get_db_connection()
        cursor = db.cursor(dictionary=True)
        cursor.execute("SELECT * FROM users WHERE username = %s", (username,))
        user = cursor.fetchone()

        if user and check_password_hash(user['password'], password_candidate):
            # Lưu thông tin vào Session
            session['logged_in'] = True
            session['username'] = user['username']
            session['role'] = user['role']
            
            flash("Đăng nhập thành công!", "success")
            return redirect(url_for('dashboard'))
        else:
            flash("Sai tên đăng nhập hoặc mật khẩu!", "danger")
            
        cursor.close()
        db.close()
        
    return render_template('login.html')

@app.route('/logout')
def logout():
    session.clear()
    return redirect(url_for('login'))

@app.route('/dashboard')
def dashboard():
    if 'logged_in' in session:
        return render_template('dashboard.html', username=session['username'], role=session['role'])
    else:
        flash("Vui lòng đăng nhập để truy cập!", "danger")
        return redirect(url_for('login'))

@app.route('/admin')
def admin_panel():
    if 'logged_in' in session and session['role'] == 'admin':
        db = get_db_connection()
        cursor = db.cursor(dictionary=True)
        # Thêm status vào câu lệnh SELECT
        cursor.execute("SELECT id, username, role, status FROM users")
        all_users = cursor.fetchall()
        cursor.close()
        db.close()
        return render_template('admin.html', users=all_users)

@app.route('/lock_user/<int:user_id>')
def lock_user(user_id):
    if 'logged_in' in session and session['role'] == 'admin':
        db = get_db_connection()
        cursor = db.cursor()
        cursor.execute("UPDATE users SET status = 0 WHERE id = %s", (user_id,))
        db.commit()
        flash("Đã khóa tài khoản!", "warning")
        db.close()
    return redirect(url_for('admin_panel'))

@app.route('/restore_user/<int:user_id>')
def restore_user(user_id):
    if 'logged_in' in session and session['role'] == 'admin':
        db = get_db_connection()
        cursor = db.cursor()
        cursor.execute("UPDATE users SET status = 1 WHERE id = %s", (user_id,))
        db.commit()
        flash("Đã khôi phục tài khoản!", "success")
        db.close()
    return redirect(url_for('admin_panel'))

if __name__ == '__main__':
    app.run(debug=True)