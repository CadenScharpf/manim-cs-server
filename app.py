import os
from flask import Flask, jsonify, request
from manimcs import ManimCsEngine


app = Flask(__name__)


@app.route('/arraysort', methods=['GET'])
def arraysort():
    response = {'success': "false", 'message': ""}
    json_data = request.get_json()
    if not 'algorithm' in json_data and 'inputValues' in json_data:
        response['message'] = "Invalid request"
        return jsonify(response)
    sort_algo = json_data['algorithm']
    arr = json_data['inputValues']
    print(sort_algo, arr)
    if not isinstance(sort_algo, str) or (not (isinstance(arr, list) and all(isinstance(val, int) for val in arr))): 
        response['message'] = "Invalid request"
        return jsonify(response)
    
    try:
        int_list = [int(x) for x in arr]
        file = ManimCsEngine(sort_algo, inputValues=arr).generate()
    except Exception as e:
        response['message'] = str(e)
        return jsonify(response)
    response = {'success': "true", 'message': file}
    return jsonify(response)

if __name__ == '__main__':
    app.run(debug=True)