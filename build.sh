#!/usr/bin/env bash

#
# Build distribution image in self contained environment
# Usage: ./build.sh
#

declare -r DOCKER_TAG=zigzag:1
declare -a ARGUMENT_ARRAY

case $1 in
    leap-stable|'') ARGUMENT_ARRAY=('' 'leap-15.2') ;;
    leap-devel) ARGUMENT_ARRAY=('--profile=devel' 'leap-15.2') ;;
    leap-next) ARGUMENT_ARRAY=('--profile=devel' 'leap-15.2') ;;
    tumbleweed-devel) ARGUMENT_ARRAY=('' 'tumbleweed') ;;
    *) echo 'invalid variant'; exit 1 ;;
esac

container_build()
{
    if [[ "$(docker images -q $DOCKER_TAG 2> /dev/null)" == "" ]]; then
        docker build -t $DOCKER_TAG docker/
    fi
}

container_run()
{
    docker run --privileged --rm -v $(pwd):/kiwi -it $DOCKER_TAG "$@"
}

container_build
container_run mkiso "${ARGUMENT_ARRAY[0]}" "${ARGUMENT_ARRAY[1]}"
