#!/usr/bin/bash

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:$PATH
SCRIPTNAME=$0
SCRIPTDIR=$(
  cd "$(dirname $SCRIPTNAME)"
  echo $PWD
)

cd "$SCRIPTDIR"
pwk8slatest=$(docker image list pwk8s:latest | awk '/pwk8s/')
if [[ -z $pwk8slatest ]]; then
  echo "[INFO]Building the docker image pwk8s:latest"
  cd "$SCRIPTDIR/dockerfiles/pwk8s"
  docker build --tag pwk8s .
  cd -
fi

#docker pull franela/k8s:latest
#docker pull franela/dind
if ! docker node ls >/dev/null 2>&1; then
  docker swarm init
fi
sudo modprobe xt_ipvs
docker-compose up -d
docker-compose logs -f
docker-compose down
