#!/bin/bash

# Start Gunicorn with 4 worker processes
exec gunicorn app:app -w 4 -b 0.0.0.0:5000 --access-logfile -
