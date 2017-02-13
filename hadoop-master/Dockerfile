FROM registry.activitystream.com:5043/hadoop-base:local

MAINTAINER Petar Shomov <petar@activitystream.com>

WORKDIR /root


RUN mkdir -p ~/hdfs/namenode && \
    mkdir -p ~/hdfs/datanode

COPY config/* /tmp/

RUN mv /tmp/start-hadoop.sh ~/start-hadoop.sh && \
    mv /tmp/run.sh ~/run.sh

RUN chmod +x ~/*.sh

# format namenode
RUN /usr/local/hadoop/bin/hdfs namenode -format



CMD [ "sh", "-c", "./run.sh"]
