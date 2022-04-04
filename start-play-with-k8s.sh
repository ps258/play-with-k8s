#!/usr/bin/bash

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:$PATH

docker pull franela/k8s:latest
docker pull franela/dind
docker swarm init
sudo modprobe xt_ipvs
docker-compose up
