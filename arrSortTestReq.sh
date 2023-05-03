curl -X GET http://localhost:5000/arraysort -H "Content-Type: application/json" -H "Accept: application/json" -d '{"algorithm": "bubble-sort","inputValues":[11,23,15]}'

curl -o video.mp4 -X GET http://localhost:5000/getfile -H "Content-Type: application/json" -H "Accept: application/json" -d '{"file": "/app/output/20230503-020528.mp4"}'