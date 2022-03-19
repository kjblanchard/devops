from flask import Flask

app = Flask(__name__)

@app.route("/")
def homepage():
    return {
        "hello": "world",
        "no": "u"
    }


# Use this for debugging locally, exclude from the build
# app.run(port=4050 )