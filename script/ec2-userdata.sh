#!/bin/bash
set -ex  # Exit on error

# Update package list and install dependencies
sudo apt update && sudo apt upgrade -y
sudo apt install python3 python3-pip python3-venv git nginx python3-dev default-libmysqlclient-dev build-essential pkg-config -y

# Clone the Flask app repository
cd /home/ubuntu
git clone https://github.com/your-username/your-repo.git
cd your-repo

# Create a virtual environment and install dependencies
python3 -m venv prvenv
source prvenv/bin/activate
pip install -r requirements.txt

# Set up Systemd service for Flask and Set environment variables for MySQL credentials and secret key
sudo tee /etc/systemd/system/flaskapp.service << 'EOF'
[Unit]
Description=Gunicorn instance to serve Flask app
After=network.target

[Service]
Environment="FLASK_SECRET_KEY=your-secret-key"
Environment="MYSQL_HOST=rds-endpoint"
Environment="MYSQL_USER=username"
Environment="MYSQL_PASSWORD=password"
Environment="MYSQL_DB=db-name"
User=ubuntu
Group=www-data
WorkingDirectory=/home/ubuntu/your-repo
Environment="PATH=/home/ubuntu/your-repo/prvenv/bin"
ExecStart=/home/ubuntu/your-repo/prvenv/bin/gunicorn --bind 127.0.0.1:5000 app:app

[Install]
WantedBy=multi-user.target
EOF

# Start and enable Flask service
sudo systemctl daemon-reload
sudo systemctl start flaskapp
sudo systemctl enable flaskapp


# Configure Nginx as a reverse proxy
sudo rm /etc/nginx/sites-enabled/default
cat <<'EOF' | sudo tee /etc/nginx/sites-available/flask_app
server {
    listen 80;
    server_name _;

    location / {
        proxy_pass http://127.0.0.1:5000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}
EOF
sudo ln -s /etc/nginx/sites-available/flask_app /etc/nginx/sites-enabled
sudo systemctl restart nginx