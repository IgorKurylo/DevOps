#!/bin/bash
echo "Build Application"

export ECR_REPO_URI="772417916823.dkr.ecr.eu-west-1.amazonaws.com/application"

export AWS_PROFILE=terraformer

aws ecr get-login-password --region eu-west-1 | docker login --username AWS --password-stdin 772417916823.dkr.ecr.eu-west-1.amazonaws.com

env GOOS=linux go build -o main

echo "Build docker image..."

docker build -t application .

docker tag application "${ECR_REPO_URI}:1.0"

echo "Push image..."

docker push "${ECR_REPO_URI}:1.0"