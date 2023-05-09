# localhost
curl -X GET http://localhost:80/arraysort -H "Content-Type: application/json" -H "Accept: application/json" -d '{"algorithm": "bubble-sort","inputValues":[11,23,15]}'

curl -o video.mp4 -X GET http://localhost:80/getfile -H "Content-Type: application/json" -H "Accept: application/json" -d '{"file": "/app/output/20230503-182443.mp4"}'
curl -o video.mp4 -X GET http://localhost:80/getfile/20230504-164418.mp4

# AWS Host
curl -X POST https://manimcs-api.cadenscharpf.tech/arraysort -H "Content-Type: application/json" -H "Accept: application/json" -d '{"algorithm": "bubble-sort","inputValues":[11,23,15]}'
curl -o video.mp4 -X GET https://manimcs-api.cadenscharpf.tech/getfile/20230504-164418.mp4
# generated 2023-05-06, Mozilla Guideline v5.6, nginx 1.17.7, OpenSSL 1.1.1k, intermediate configuration
# https://ssl-config.mozilla.org/#server=nginx&version=1.17.7&config=intermediate&openssl=1.1.1k&guideline=5.6
# generated 2023-05-06, Mozilla Guideline v5.6, nginx 1.17.7, OpenSSL 1.1.1k, intermediate configuration
# https://ssl-config.mozilla.org/#server=nginx&version=1.17.7&config=intermediate&openssl=1.1.1k&guideline=5.6


