from flask import Flask, render_template, request, abort
import requests
import os

app = Flask(__name__)

API_KEY = os.environ.get('API_KEY')
BASE_URL = os.environ.get('BASE_URL')
 

@app.errorhandler(404)
def not_found(error): 
    return render_template("404.html"), 404

@app.errorhandler(401)
def not_found(error): 
    return render_template("401.html"), 401

@app.errorhandler(500)
def internal_error(error):
    return render_template('500.html'), 500


@app.route('/five_days', methods=['GET', 'POST'])
def index():
    weather_data = None
    if request.method == 'POST':
        city = request.form.get('city')
        if city:
            params = {
                "q": city,           
                "units": "metric",
                "cnt": "40",   
                "appid": API_KEY   
            }
            response = requests.get(BASE_URL, params=params)
            if response.status_code == 401:
                abort(401) 
            weather_data = response.json()

    return render_template('index.html', weather_data=weather_data)


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001, debug=False) #Switch to True for debugging