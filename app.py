import os
import sys
from dotenv import load_dotenv
from flask import Flask, jsonify, request
from scraper import scrape_linkedin

load_dotenv()

app = Flask(__name__)

API_KEY = os.getenv('SCRAPER_API_KEY')

@app.route("/scrape", methods=["POST"])
def scrape():
    if request.headers.get("X-API-Key") != API_KEY:
        return jsonify({
            "success": False,
            "error": "Unauthorized"
        }), 401
    jobs = scrape_linkedin(num_jobs=10, delay=3, testing=True)

    return jsonify({
        "success": True,
        "jobs": jobs
    })

@app.route("/", methods=[GET])
def home():
    return "Scraper API is running!"

@app.route("/python-version")
def python_version():
    return sys.version