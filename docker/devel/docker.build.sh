#!/bin/sh

docker build \
    --build-arg user=$USER \
    --build-arg uid=$(id -u) \
    --build-arg gid=$(id -g) \
    --build-arg DISPLAY=${DISPLAY} \
    -t devel \
    -f Dockerfile \
    .

xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f /tmp/.docker.xauth nmerge -
