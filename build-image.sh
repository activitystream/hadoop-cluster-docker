#!/bin/bash

echo ""

echo -e "\nbuild docker hadoop image\n"
docker build -t activitystream/hadoop-spark-cluster .

echo "Done"
