#!/usr/bin/env bash

set -e
declare -r EXTRA_OPTS=$1
declare -r DESC_DIR=/kiwi/$2
declare -r RESULTS_DIR=/kiwi/out
declare -r BUILD_DIR=/tmp/kiwi-build
mkdir -p $RESULTS_DIR

# run the build
kiwi \
    --color-output \
    --shared-cache-dir=$RESULTS_DIR/cache \
    --logfile=$RESULTS_DIR/build.log \
    $EXTRA_OPTS \
    system build \
    --description $DESC_DIR \
    --target-dir $BUILD_DIR

# collect iso files
mv $BUILD_DIR/*.iso $RESULTS_DIR

# store reference packages
cat $BUILD_DIR/*.packages | cut -d '|' -f1 | sort > $DESC_DIR/package-reference.txt
