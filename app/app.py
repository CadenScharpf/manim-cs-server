import os
from flask import Flask, jsonify, request, send_file
from manimcs import ManimCsEngine
from flask_cors import CORS


app = Flask(__name__)
cors = CORS(app)

_output_dir = os.path.join(os.getcwd(), 'output')

@app.route('/getfile/<string:filename>', methods=['GET'])
def return_files(filename):
    try:
        filepath = os.path.join(os.getcwd(), 'output', filename)
        if(not os.path.exists(filepath)):
            raise Exception("File not found")
        # return file
        return send_file(filepath, download_name=filename)
    except Exception as e:
        return str(e)

@app.route('/arraysort', methods=['POST'])
def arraysort():
    response = {'success': "false", 'message': ""}
    json_data = request.get_json()
    #validate request
    if not 'algorithm' in json_data and 'inputValues' in json_data:
        response['message'] = "Invalid request"
        return jsonify(response)
    command = json_data['algorithm']
    _inputValues = json_data['inputValues']
    if not isinstance(command, str) or (not (isinstance(_inputValues, list) and all(isinstance(val, int) for val in _inputValues))): 
        response['message'] = "Invalid request"
        return jsonify(response)
    # execute command
    try:
        filePath = ManimCsEngine(command, inputValues=_inputValues, output_dir=_output_dir).generate()
        sp = filePath.split('/')
        file = sp[len(sp)-1]
    except Exception as e:
        response['message'] = str(e)
        return jsonify(response)
    response = {'success': "true", 'message': file}
    return jsonify(response)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80,debug=True)