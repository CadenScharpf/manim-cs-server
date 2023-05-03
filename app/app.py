import os
from flask import Flask, jsonify, request, send_file
from manimcs import ManimCsEngine


app = Flask(__name__)
_output_dir = os.path.join(os.getcwd(), 'output')

@app.route('/getfile', methods=['GET'])
def return_files():
    try:
        json_data = request.get_json()
        # validate request
        if not 'file' in json_data:
            raise Exception("Request must contain file path")
        if(not os.path.exists(json_data['file'])):
            raise Exception("File not found")
        sp = json_data['file'].split('/')
        filename = sp[len(sp)-1]
        # return file
        return send_file(json_data['file'], download_name=filename)
    except Exception as e:
        return str(e)

@app.route('/arraysort', methods=['GET'])
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
        file = ManimCsEngine(command, inputValues=_inputValues, output_dir=_output_dir).generate()
    except Exception as e:
        response['message'] = str(e)
        return jsonify(response)
    response = {'success': "true", 'message': file}
    return jsonify(response)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000,debug=True)