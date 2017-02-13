#!/bin/bash

set -e
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

export PUSH=true
export BUILD_REV=local

cd $DIR/hadoop-base
../build-image.sh
cd $DIR/hadoop-master
../build-image.sh
cd $DIR/hadoop-node
../build-image.sh

cd $DIR
docker stack rm hadoop ; docker stack deploy  --compose-file docker-compose.yml --with-registry-auth hadoop