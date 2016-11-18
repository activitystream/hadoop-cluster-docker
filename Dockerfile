FROM ubuntu:14.04

MAINTAINER Lekan <elesin.olalekan@gmail.com>

WORKDIR /root

# install openssh-server, openjdk and wget
RUN apt-get update && apt-get install -y openssh-server openjdk-7-jdk wget

ENV HADOOP_VER=2.7.2
# install hadoop
RUN wget https://github.com/kiwenlau/compile-hadoop/releases/download/$HADOOP_VER/hadoop-$HADOOP_VER.tar.gz && \
    tar -xzvf hadoop-$HADOOP_VER.tar.gz && \
    mv hadoop-$HADOOP_VER /usr/local/hadoop && \
    rm hadoop-$HADOOP_VER.tar.gz

# install spark 2.0.0
ENV SPARK_VER=2.0.2
RUN wget http://www-eu.apache.org/dist/spark/spark-$SPARK_VER/spark-$SPARK_VER-bin-hadoop2.7.tgz && \
    tar -xzvf spark-$SPARK_VER-bin-hadoop2.7.tgz && \
    mv spark-$SPARK_VER-bin-hadoop2.7 /usr/local/spark && \
    rm spark-$SPARK_VER-bin-hadoop2.7.tgz

# set environment variable
ENV JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
ENV HADOOP_HOME=/usr/local/hadoop
ENV SPARK_HOME=/usr/local/spark
ENV PATH=$PATH:/usr/local/hadoop/bin:/usr/local/hadoop/sbin:/usr/local/spark/bin:/usr/local/spark/sbin

# ssh without key
RUN ssh-keygen -t rsa -f ~/.ssh/id_rsa -P '' && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

RUN mkdir -p ~/hdfs/namenode && \
    mkdir -p ~/hdfs/datanode && \
    mkdir $HADOOP_HOME/logs

COPY config/* /tmp/

RUN mv /tmp/ssh_config ~/.ssh/config && \
    mv /tmp/hadoop-env.sh $HADOOP_HOME/etc/hadoop/hadoop-env.sh && \
    mv /tmp/hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml && \
    mv /tmp/core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml && \
    mv /tmp/mapred-site.xml $HADOOP_HOME/etc/hadoop/mapred-site.xml && \
    mv /tmp/yarn-site.xml $HADOOP_HOME/etc/hadoop/yarn-site.xml && \
    cp /tmp/slaves $HADOOP_HOME/etc/hadoop/slaves && \
    cp /tmp/slaves $SPARK_HOME/conf/slaves && \
    mv /tmp/spark-env.sh $SPARK_HOME/conf/spark-env.sh && \
    mv /tmp/start-hadoop.sh ~/start-hadoop.sh && \
    mv /tmp/run-wordcount.sh ~/run-wordcount.sh

RUN chmod +x ~/start-hadoop.sh && \
    chmod +x ~/run-wordcount.sh && \
    chmod +x $HADOOP_HOME/sbin/start-dfs.sh && \
    chmod +x $HADOOP_HOME/sbin/start-yarn.sh

# format namenode
RUN /usr/local/hadoop/bin/hdfs namenode -format

CMD [ "sh", "-c", "service ssh start; bash"]
