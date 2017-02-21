### Submitting Spark Job to the cluster

 - run sshuttle -vNr <test cluster>
 - `eval $(docker-machine env test-bd0)`
 - `cd hadoop-cluster-docker`
 - `cp <src_file> hadoop-submit/transfer/`
 - `./submit.sh spark-submit --master spark://hadoop-master:8085 --class org.apache.spark.examples.SparkPi /root/transfer/spark-examples_2.11-2.0.2.jar 100`
