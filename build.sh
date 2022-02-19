#!/usr/bin/env bash

#
# Build distribution image in self contained environment
# Usage: ./build.sh
#

declare -r DOCKER_TAG=zigzag:15.3
declare -r DOCKER_RUNTIME='sudo podman'

container_build()
{
    if [[ "$($DOCKER_RUNTIME images -q $DOCKER_TAG 2> /dev/null)" == "" ]]; then
        $DOCKER_RUNTIME build -t $DOCKER_TAG docker/
    fi
}

container_run()
{
    $DOCKER_RUNTIME run --privileged --rm -v zigzag-build:/tmp/kiwi-build -v $(pwd):/kiwi -it $DOCKER_TAG "$@"
}

container_build
container_run mkiso '' kiwi
