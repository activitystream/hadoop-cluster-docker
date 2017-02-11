#!/bin/bash

echo -e "\n"

$HADOOP_HOME/sbin/start-dfs.sh

echo -e "\n"

$HADOOP_HOME/sbin/start-yarn.sh

echo -e "\n"

. "${SPARK_HOME}/sbin/spark-config.sh"
SPARK_LOCAL_IP=0.0.0.0 SPARK_PUBLIC_DNS="hadoop-master" "${SPARK_HOME}/sbin/start-master.sh"
SPARK_MASTER_HOST=`hostname -f` SPARK_PUBLIC_DNS="hadoop-master" "${SPARK_HOME}/sbin/start-slaves.sh"
echo -e "\n"
