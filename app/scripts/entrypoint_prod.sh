#!/bin/bash

# Start Gunicorn with 4 worker processes
exec gunicorn app:app  --config /app/config/gunicorn.conf.py
