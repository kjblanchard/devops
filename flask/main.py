from flask import Flask, render_template
from datetime import datetime

app = Flask(__name__)

@app.route("/")
def homepage():
    return render_template('index.html', days=get_days_until_wedding())

def get_days_until_wedding():
    time = datetime.now()
    wedding_day = datetime(year=2023, day=21, month=1)
    diff = wedding_day - time
    return diff.days
