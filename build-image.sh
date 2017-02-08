#!/bin/bash

echo ""

echo -e "\nbuild docker hadoop image\n"
# docker build -t activitystream/hadoop-spark-cluster .
docker build -t registry.activitystream.com:5043/hadoop-spark-cluster .
docker push registry.activitystream.com:5043/hadoop-spark-cluster

echo "Done"
