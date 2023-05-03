# Local testing: 

1. build the image: 
    - sudo docker build -t 
    or
    - use the "Build Docker Image" tasks

2. Tag the image (if not already done so)
    - tag manim-cs-server:latest public.ecr.aws/r5c2t6e1/manim-cs-server:latest

3. run a container from the image:
    - docker run --rm -it -p 80:80 --name mcs-server manim-cs-server (untagged)
    - docker run --rm --name manim-cs-server -d -p 80:80 public.ecr.aws/r5c2t6e1/manim-cs-server:latest (if tagged)
    or 
    - use the "Run local server" tasks

4. (optional) test with curl request:

    # localhost
    curl -X GET http://localhost:80/arraysort -H "Content-Type: application/json" -H "Accept: application/json" -d '{"algorithm": "bubble-sort","inputValues":[11,23,15]}'
    curl -o video.mp4 -X GET http://localhost:80/getfile -H "Content-Type: application/json" -H "Accept: application/json" -d '{"file": "/app/output/20230503-182443.mp4"}'

    # AWS Host
    curl -X GET http://ec2-13-57-239-150.us-west-1.compute.amazonaws.com:80/arraysort -H "Content-Type: application/json" -H "Accept: application/json" -d '{"algorithm": "bubble-sort","inputValues":[11,23,15]}'
    curl -o video.mp4 -X GET http://ec2-13-57-239-150.us-west-1.compute.amazonaws.com:80/getfile -H "Content-Type: application/json" -H "Accept: application/json" -d '{"file": "/app/output/20230503-214032.mp4"}'

# Deployment: 

    1. build and push the image:
        - use .vscode/scripts/build_push_image.sh: 
        #!/bin/bash
        # Description: Build and push docker image to ECR
        # Usage: sh .vscode/scripts/build_push_image.sh


        # Get the account id associated with the current IAM credentials
        # aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/r5c2t6e1

        # Build the docker image (only working on windows for now) 
        docker build -t manim-cs-server .
        docker tag manim-cs-server:latest public.ecr.aws/r5c2t6e1/manim-cs-server:latest
        docker push public.ecr.aws/r5c2t6e1/manim-cs-server:latest

    2. Pull/run the container on the aws instance:
        - app/scripts/pull_launch_container.sh:

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

    3. Attatch logs:
        - apps/scripts/attatch_logs.sh:

            #!/bin/bash

            # Get the ID of the running container, if any
            CONTAINER_ID=$(docker ps --filter "ancestor=public.ecr.aws/r5c2t6e1/manim-cs-server:latest" --quiet)

            # Attatch logs if containter is running
            if [ ! -z "$CONTAINER_ID" ]; then
                docker logs -f "$CONTAINER_ID"
            fi