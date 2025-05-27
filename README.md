# Flask Web Application on AWS (Highly Available & Scalable)

This project demonstrates the deployment of a **Flask web application** on AWS using a **custom VPC**, **Auto Scaling**, **Application Load Balancer**, and **Amazon RDS** for the database. It focuses on building a **highly available**, **scalable**, and **cloud-native architecture**, all within the AWS Free Tier.

---

## 🚀 Project Features

- ✅ Flask web application with user registration and login
- ✅ Python virtual environment and GitHub integration
- ✅ MySQL database hosted on Amazon RDS
- ✅ Custom VPC with public subnets, routing, and internet gateway
- ✅ EC2 instance running Flask app with Gunicorn + systemd
- ✅ Application Load Balancer for distributing traffic
- ✅ Auto Scaling Group for fault tolerance and scalability
- ✅ Fully documented infrastructure setup and code

---

## 🧱 Project Architecture

- **Frontend**: HTML templates rendered by Flask
- **Backend**: Python Flask application
- **Database**: Amazon RDS (MySQL)
- **Infrastructure**:
  - VPC with subnets and internet gateway
  - EC2 instances in Auto Scaling Group
  - Application Load Balancer (ALB)
  - Security Groups for traffic control

---

## 📂 Project Structure

```bash
├── app.py
├── templates/
│   ├── login.html
│   ├── register.html
│   └── dashboard.html
├── static/
│   └── style.css
├── venv/ (virtual environment)
├── requirements.txt
└── README.md
```
---

## ⚙️ Technologies Used
Python 3

Flask

MySQL

AWS EC2, RDS, VPC, ALB, Auto Scaling

Gunicorn

Systemd

Git & GitHub

---
## 🛠️ How to Deploy
1. Clone the Repository
bash
Copy
Edit
git clone https://github.com/your-username/your-repo-name.git
cd your-repo-name
2. Set Up Python Virtual Environment
bash
Copy
Edit
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
3. Update app.py for RDS Connection
Replace the MySQL connection config with your RDS credentials:

python
Copy
Edit
db = mysql.connector.connect(
    host="your-rds-endpoint",
    user="your-db-user",
    password="your-db-password",
    database="flaskdb"
)
4. Run Locally (for testing)
bash
Copy
Edit
python app.py
5. Deploy on EC2
SSH into EC2

Clone repo

Activate venv and install dependencies

Run Flask using Gunicorn + systemd

6. Configure AWS Components
Create custom VPC, subnets, and route tables

Launch EC2 in public subnet

Set up RDS in the same VPC

Configure security groups

Set up ALB and Auto Scaling Group
---

## 🌐 Application URL
Accessible via Application Load Balancer DNS:

arduino
Copy
Edit
http://your-load-balancer-dns.amazonaws.com
