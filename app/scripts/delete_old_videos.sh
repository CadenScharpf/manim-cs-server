#!/bin/bash
   
# Delete .mp4 videos that are more than 10 minutes old
find /app/output -type f -name "*.mp4" -mmin +10 -exec rm -f {} \;