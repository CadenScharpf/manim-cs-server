curl -X GET http://localhost:5000/arraysort -H "Content-Type: application/json" -H "Accept: application/json" -d '{"algorithm": "bubble-sort","inputValues":[11,23,15]}'

curl -X GET http://localhost:5000/getfile -H "Content-Type: application/json" -H "Accept: application/json" -d '{"file": "/home/caden/developer/manim-cs-server/output/20230502-151807.mp4"}'