# app.py

from flask import Flask, jsonify
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)
app.config.from_object('config.Config')

db = SQLAlchemy(app)

@app.route('/')
def hello_world():
    return jsonify(message='Hello, World!')

@app.route('/users')
def users():
    # Example of querying the database (assuming a User model exists)
    # users = User.query.all()
    # return jsonify([user.to_dict() for user in users])
    return jsonify(users=[])

if __name__ == '__main__':
    app.run()
