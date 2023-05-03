#!/bin/bash

# Pull the Docker image from the registry
docker pull public.ecr.aws/r5c2t6e1/manim-cs-server:latest

# Run the Docker container
docker run -d -p 80:80 public.ecr.aws/r5c2t6e1/manim-cs-server:latest