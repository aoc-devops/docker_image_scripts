# docker_image_scripts
This repository contains some scripts related to docker image push 
-While executing docker_ecr_push.sh pass three command line arguments i. e. imagename, region , image version

-while executing docker_hub_push.sh pass only one command line arguement i. e. imagename only. 
1. Before running this script note down name of docker-hub repo in which we have to push image, otherwise create new and note down. we have to insert docker hub repo name during script execution.
2. while parsing repo-name provide version ex. repo_name:1.5, repo_name1.2 etc. (Default version is latest, when we run script second time it causes conflict of tags in docker hub repo)
