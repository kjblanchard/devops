from flask import Flask, render_template
from datetime import datetime
import requests

app = Flask(__name__)

@app.route("/")
def homepage():
    return render_template('index.html',
     days=get_days_until_wedding_text(),
     footer=get_footer_text()
     )

def get_days_until_wedding_text():
    time = datetime.now()
    wedding_day = datetime(year=2023, day=21, month=1)
    diff = wedding_day - time
    if diff.days > 0:
        return f"That is {diff.days} until our wedding!"
    else:
        return f"We got married {-diff.days} days ago!"

def get_footer_text():
    time = datetime.now()
    year = time.year
    return f'Copyright Kevin Blanchard {year}'

@app.route('/api/v1/start')
def hello():
    runner_response = requests.get('http://runner')
    return runner_response.json()

# Use this for debugging locally, exclude from the build
# app.run(port=4050 )
