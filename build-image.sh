#!/bin/bash

function evil_git_dirty {
  [[ $(git diff --shortstat 2> /dev/null | tail -n1) != "" ]] && echo "D"
}

function evil_git_num_untracked_files {
  [[ $(expr `git status --porcelain 2>/dev/null | grep "^??" | wc -l`) != "0" ]] && echo "N"
}

PUSH=${PUSH:-false}
DIRTY1=$(evil_git_dirty)
DIRTY2=$(evil_git_num_untracked_files)
export BUILD_REV="`git rev-parse HEAD | cut -c 1-7`$DIRTY1$DIRTY2"
BUILD_REV=local
TAG="registry.activitystream.com:5043/${PWD##*/}:$BUILD_REV"
echo -e "\nbuilding image $TAG\n"

docker build -t $TAG .
$PUSH && docker push $TAG

echo "Done"
