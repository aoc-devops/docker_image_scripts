#!/bin/bash
# This script shows how to build the Docker image and push it to ECR
# The argument to this script is the image name. This will be used as the image on
the local machine and combined with the account and region to form the repository
name for ECR.
image=$1
region=$2
image_version=$3
echo "value of image is $image"
if [ "$image" == "" ]
then
 echo "Usage: $0 <image-name> not specified"
 exit 1
fi
# Get the account number associated with the current IAM credentials
account=$(aws sts get-caller-identity --query Account --output text)
# $? will if previously executed command was successful.
if [ $? -ne 0 ]
then
 exit 255
fi
# region="ap-south-1"
ecr_repo_name=$image"-ecr-repo"
image_name=$image-$image_version
# If the repository doesn't exist in ECR, create it.
echo "Checking ECR Repo with name $ecr_repo_name"
# || means if the first command succeed the second will never be executed
aws ecr describe-repositories --repository-names ${ecr_repo_name} --region $region || aws ecr create-repository --repository-name ${ecr_repo_name} --region $region
# Get the login command from ECR and execute docker login
aws ecr get-login-password --region $region | docker login --username AWS --password-stdin ${account}.dkr.ecr.${region}.amazonaws.com

# Build the docker image locally with the image name and then push it to ECR with the full name.
docker build -t ${image_name} .
fullname="${account}.dkr.ecr.${region}.amazonaws.com/${ecr_repo_name}:$image_name"
echo "fullname is $fullname"

# Tag the locally created docker image with the ECR Repo URI
echo "Tagging the Local Image ${image_name} with ${fullname}"
docker tag ${image_name} ${fullname}

# docker images
echo "Pushing the Docker Image with URI ${fullname}"
docker push ${fullname}

if [ $? -eq 0 ]
then
 echo "Docker Push Event is successfull with ${fullname}"
else
 echo "Docker Push Event failed."
fi
