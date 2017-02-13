#!/bin/bash

set -e
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

export PUSH=true
export BUILD_REV=local

cd $DIR/hadoop-submit
../build-image.sh

cd $DIR
docker run --rm --network hadoop registry.activitystream.com:5043/hadoop-submit:local "$@"