#!/usr/bin/env bash

#
# Build distribution image in self contained environment
# Usage: ./build.sh
#

declare -r DOCKER_TAG=zigzag:0.5
declare -a ARGUMENT_ARRAY

case $1 in
    leap-stable|'') ARGUMENT_ARRAY=('' 'leap-15.0') ;;
    leap-testing) ARGUMENT_ARRAY=('--profile=testing' 'leap-15.0') ;;
    tumbleweed-stable) ARGUMENT_ARRAY=('' 'tumbleweed') ;;
    tumbleweed-testing) ARGUMENT_ARRAY=('--profile=testing' 'tumbleweed') ;;
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
    local command=$1; shift
    docker run --privileged --rm -v $(pwd):/kiwi -it $DOCKER_TAG $command
}

gekon_build()
{
    container_run "kiwi-ng ${ARGUMENT_ARRAY[0]} system build --description /kiwi/${ARGUMENT_ARRAY[1]} --target-dir /kiwi/out"
}

save_pkg_list()
{
    # store the package list inside the repo for reference of what has changed
    cat out/*.packages | cut -d '|' -f1 | sort > ${ARGUMENT_ARRAY[1]}/package-reference.txt
}

container_build
gekon_build
save_pkg_list
