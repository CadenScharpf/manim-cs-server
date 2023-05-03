# localhost
curl -X GET http://localhost:80/arraysort -H "Content-Type: application/json" -H "Accept: application/json" -d '{"algorithm": "bubble-sort","inputValues":[11,23,15]}'

curl -o video.mp4 -X GET http://localhost:80/getfile -H "Content-Type: application/json" -H "Accept: application/json" -d '{"file": "/app/output/20230503-182443.mp4"}'

# AWS Host
curl -X GET http://ec2-13-57-239-150.us-west-1.compute.amazonaws.com:80/arraysort -H "Content-Type: application/json" -H "Accept: application/json" -d '{"algorithm": "bubble-sort","inputValues":[11,23,15]}'
curl -o video.mp4 -X GET http://ec2-13-57-239-150.us-west-1.compute.amazonaws.com:80/getfile -H "Content-Type: application/json" -H "Accept: application/json" -d '{"file": "/app/output/20230503-214032.mp4"}'

