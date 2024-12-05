from flask import Flask, render_template

# Create a Flask app instance
app = Flask(__name__)

# Define routes for each page
@app.route('/')
def index():
    return render_template('index.html')

@app.route('/about')
def about():
    return render_template('about.html')

@app.route('/service')
def service():
    return render_template('service.html')

@app.route('/why')
def why():
    return render_template('why.html')

@app.route('/team')
def team():
    return render_template('team.html')

# Run the app on port 5000
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)

