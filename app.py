from flask import Flask, render_template, request, redirect, session
from flask_mysqldb import MySQL
import MySQLdb.cursors
import hashlib
import os

app = Flask(__name__)

# Secret key for session management
app.secret_key = os.getenv('FLASK_SECRET_KEY', 'default-secret-key')

# MySQL Configuration
app.config['MYSQL_HOST'] = os.getenv('MYSQL_HOST')
app.config['MYSQL_USER'] = os.getenv('MYSQL_USER')
app.config['MYSQL_PASSWORD'] = os.getenv('MYSQL_PASSWORD')
app.config['MYSQL_DB'] = os.getenv('MYSQL_DB')

mysql = MySQL(app)

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        try:
            username = request.form['username']
            password = hashlib.sha256(request.form['password'].encode()).hexdigest()
            
            cursor = mysql.connection.cursor()
            cursor.execute("INSERT INTO users (username, password) VALUES (%s, %s)", (username, password))
            mysql.connection.commit()
            cursor.close()
        
            return redirect('/login')
        
        except Exception as e:
            print(f"Error during registration: {e}")
            return "Internal Server Error", 500
        
    return render_template('register.html')

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = hashlib.sha256(request.form['password'].encode()).hexdigest()
        
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute("SELECT * FROM users WHERE username = %s AND password = %s", (username, password))
        user = cursor.fetchone()
        cursor.close()
        
        if user:
            session['loggedin'] = True
            session['username'] = user['username']
            return redirect('/')
        else:
            return 'Login failed. Try again!'
    
    return render_template('login.html')

if __name__ == '__main__':
    app.run(debug=True)
