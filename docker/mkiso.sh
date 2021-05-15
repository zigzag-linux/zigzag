#!/usr/bin/env bash

set -e
declare -r EXTRA_OPTS=$1
declare -r DESC_DIR=/kiwi/$2
declare -r RESULTS_DIR=/kiwi/out
declare -r BUILD_DIR=/tmp/kiwi-build
declare -r IMAGE_ROOT_DIR=$BUILD_DIR/build/image-root
mkdir -p $RESULTS_DIR

if [ ! -d $IMAGE_ROOT_DIR ]; then
kiwi \
    --color-output \
    --shared-cache-dir=$RESULTS_DIR/cache \
    --logfile=$RESULTS_DIR/build.log \
    $EXTRA_OPTS \
    system prepare \
    --description $DESC_DIR \
    --root $IMAGE_ROOT_DIR
echo "To continue run ./build.sh again; To start over run 'docker volume rm zigzag-build'"
else
kiwi \
    --color-output \
    --shared-cache-dir=$RESULTS_DIR/cache \
    --logfile=$RESULTS_DIR/build.log \
    $EXTRA_OPTS \
    system create \
    --root $IMAGE_ROOT_DIR \
    --target-dir $BUILD_DIR

# collect iso files
mv $BUILD_DIR/*.iso $RESULTS_DIR

# store reference packages
cat $BUILD_DIR/*.packages | cut -d '|' -f1 \
    | LC_COLLATE=en_US.utf8 sort > $DESC_DIR/package-reference.txt
fi
