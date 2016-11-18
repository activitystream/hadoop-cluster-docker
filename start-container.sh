#!/bin/bash

# the default node number is 3
N=${1:-3}


# start hadoop master container
docker rm -f hadoop-master &> /dev/null
echo "start hadoop-master container..."
docker run -itd \
                --net=hadoop \
                -p 50070:50070 \
                -p 8088:8088 \
                -p 8085:8085 \
                --name hadoop-master \
                --hostname hadoop-master \
                activitystream/hadoop-spark-cluster


# start hadoop slave container
i=1
while [ $i -lt $N ]
do
	docker rm -f hadoop-slave$i
	echo "start hadoop-slave$i container..."
	docker run -itd \
	                --net=hadoop \
	                --name hadoop-slave$i \
	                --hostname hadoop-slave$i \
	                activitystream/hadoop-spark-cluster
	i=$(( $i + 1 ))
done

# get into hadoop master container
docker exec -it hadoop-master bash
