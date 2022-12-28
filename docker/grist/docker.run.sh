#!/bin/bash

pushd /mnt/y/nextcloud/rg-all/docker/

docker run \
    --rm \
    \
    -p 8484:8484 \
    \
    -v $PWD/grist/persist:/persist \
    \
    -it \
    \
    gristlabs/grist

popd
