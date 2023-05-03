#!/bin/bash
# Description: Build and push docker image to ECR
# Usage: sh .vscode/scripts/build_push_image.sh


# Get the account id associated with the current IAM credentials
# aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/r5c2t6e1

# Build the docker image (only working on windows for now) 
docker build -t manim-cs-server .
docker tag manim-cs-server:latest public.ecr.aws/r5c2t6e1/manim-cs-server:latest
docker push public.ecr.aws/r5c2t6e1/manim-cs-server:latest