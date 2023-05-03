#!/bin/bash
# Description: Storage management for Manim CS Server
# Usage: sh /usr/local/bin/storage_mgr.sh

# Delete .mp4 videos that are more than 10 minutes old
find /app/output -type f -name "*.mp4" -mmin +10 -exec rm -f {} \;
find /app/output/* -type f -mmin +10 -delete

