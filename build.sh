#!/usr/bin/env bash

#
# Build distribution image in self contained environment
# Usage: ./build.sh
#

declare -r DOCKER_TAG=zigzag:latest
declare -r DOCKER_RUNTIME=docker
declare -a ARGUMENT_ARRAY

case $1 in
    leap-stable|'') ARGUMENT_ARRAY=('' 'leap-15.3') ;;
    leap-devel) ARGUMENT_ARRAY=('--profile=devel' 'leap-15.3') ;;
    leap-next) ARGUMENT_ARRAY=('--profile=devel' 'leap-15.4') ;;
    tumbleweed-devel) ARGUMENT_ARRAY=('' 'tumbleweed') ;;
    *) echo 'invalid variant'; exit 1 ;;
esac

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
container_run mkiso "${ARGUMENT_ARRAY[0]}" "${ARGUMENT_ARRAY[1]}"
