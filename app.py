import os
from flask import Flask, jsonify, request, send_file
from manimcs import ManimCsEngine


app = Flask(__name__)
_output_dir = os.path.join(os.getcwd(), 'output')

@app.route('/getfile', methods=['GET'])
def return_files_tut():
    json_data = request.get_json()
    if not 'file' in json_data:
        return "Invalid request"
    file = json_data['file']
    sp = file.split('/')
    filename = sp[len(sp)-1]
    try:
        if(os.path.exists(file)):
            return send_file(file, download_name=filename)
        else:
            raise Exception("File not found")
    except Exception as e:
        return str(e)

@app.route('/arraysort', methods=['GET'])
def arraysort():
    response = {'success': "false", 'message': ""}
    json_data = request.get_json()
    if not 'algorithm' in json_data and 'inputValues' in json_data:
        response['message'] = "Invalid request"
        return jsonify(response)
    command = json_data['algorithm']
    _inputValues = json_data['inputValues']
    if not isinstance(command, str) or (not (isinstance(_inputValues, list) and all(isinstance(val, int) for val in _inputValues))): 
        response['message'] = "Invalid request"
        return jsonify(response)
    
    try:
        file = ManimCsEngine(command, inputValues=_inputValues, output_dir=_output_dir).generate()
    except Exception as e:
        response['message'] = str(e)
        return jsonify(response)
    response = {'success': "true", 'message': file}
    return jsonify(response)

if __name__ == '__main__':
    app.run(debug=True)