#!/bin/bash

echo -e "\n"

$HADOOP_HOME/sbin/start-dfs.sh

echo -e "\n"

$HADOOP_HOME/sbin/start-yarn.sh

echo -e "\n"

. "${SPARK_HOME}/sbin/spark-config.sh"
SPARK_MASTER_HOST=0.0.0.0 "${SPARK_HOME}/sbin/start-master.sh"
SPARK_MASTER_HOST=`hostname -f` "${SPARK_HOME}/sbin/start-slaves.sh"
echo -e "\n"
