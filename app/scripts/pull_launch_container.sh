#!/bin/bash

# Get the ID of the running container, if any
CONTAINER_ID=$(docker ps --filter "ancestor=public.ecr.aws/r5c2t6e1/manim-cs-server:latest" --quiet)

# Stop the running container, if any
if [ ! -z "$CONTAINER_ID" ]; then
    docker stop "$CONTAINER_ID"
fi

# Pull the Docker image from the registry
docker pull public.ecr.aws/r5c2t6e1/manim-cs-server:latest

# Run the Docker container
docker run --rm --name manim-cs-server -d -p 80:80 public.ecr.aws/r5c2t6e1/manim-cs-server:latest