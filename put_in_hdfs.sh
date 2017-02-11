#!/bin/bash

export CONTAINER_ID=`docker ps | grep hadoop-master | awk '{print $1}'` 
docker cp $1 $CONTAINER_ID:/root/$2
docker exec -it $CONTAINER_ID hadoop fs -copyFromLocal /root/$2 / 