#!/bin/bash
#Note that while providing reponame you must provide version_tag like repo_name:1.3
#pass only one argument while executing command i.e. image name

image=$1

docker build -t $image . --build-arg SDLC_ARG='dev'
#docker build -t $image -f Dockerfile --build-arg SDLC_ARG='dev'
echo "Enter docker_hub username"
read username
docker login --username $username

echo "enter docker hub repository_name : version tag"
read repository_name

docker tag $image $username/$repository_name
docker push $username/$repository_name
