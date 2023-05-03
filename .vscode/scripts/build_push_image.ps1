docker build -t manim-cs-server .
docker tag manim-cs-server:latest public.ecr.aws/r5c2t6e1/manim-cs-server:latest
docker push public.ecr.aws/r5c2t6e1/manim-cs-server:latest