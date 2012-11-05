import json
import paraphraser
from flask import Flask
from flask import request
from flask import send_from_directory
app = Flask(__name__)

@app.route('/paraphrase', methods=['POST'])
def paraphrase():
  return json.dumps(paraphraser.paraphrase(request.form['text']))

@app.route('/', methods=['GET'])
def index():
  return send_from_directory('.', 'index.html')

@app.route('/<f>', methods=['GET'])
def file(f):
  return send_from_directory('.', f)

if __name__ == '__main__':
  app.run(debug=True)
