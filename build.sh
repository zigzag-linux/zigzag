#!/usr/bin/env bash

#
# Build distribution image in self contained environment
# Usage: ./build.sh
#

declare -r DOCKER_TAG=zigzag:0.4

container_build()
{
    if [[ "$(docker images -q $DOCKER_TAG 2> /dev/null)" == "" ]]; then
        docker build -t $DOCKER_TAG docker/
    fi
}

container_run()
{
    local command=$1; shift
    docker run --privileged --rm -v $(pwd):/kiwi -it $DOCKER_TAG $command
}

gekon_build()
{
    container_run "kiwi-ng $@ system build --description /kiwi/desc --target-dir /kiwi/out"
}

container_build
gekon_build $@
