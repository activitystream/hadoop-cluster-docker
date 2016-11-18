##Run Hadoop Cluster within Docker Containers

[![](https://images.microbadger.com/badges/version/oelesin/hadoop-spark-cluster.svg)](https://github.com/OElesin/hadoop-cluster-docker/ "Get your own version badge on microbadger.com")

- Blog: [Run Hadoop Cluster in Docker Update](http://kiwenlau.com/2016/06/26/hadoop-cluster-docker-update-english/)


![alt tag](https://raw.githubusercontent.com/oelesin/hadoop-cluster-docker/master/docker-hadoop-spark-cluster.png)


###3 Nodes Hadoop Cluster

#####1. clone github repository

```
git clone https://github.com/activitystream/hadoop-cluster-docker
cd hadoop-cluster-docker
```

#####2. build image
```
./build-image.sh
```

#####3. create hadoop network

```
sudo docker network create --driver=bridge hadoop
```

#####4. start container

```
sudo ./start-container.sh
```

**output:**

```
start hadoop-master container...
start hadoop-slave1 container...
start hadoop-slave2 container...
root@hadoop-master:~#
```
- start 3 containers with 1 master and 2 slaves
- you will get into the /root directory of hadoop-master container

#####5. start hadoop

```
./start-hadoop.sh
```

#####6. run wordcount

```
./run-wordcount.sh
```

**output**

```
input file1.txt:
Hello Hadoop

input file2.txt:
Hello Docker

wordcount output:
Docker    1
Hadoop    1
Hello    2
```

###Arbitrary size Hadoop cluster

#####1. pull docker images and clone github repository

do 1~3 like section A

#####2. rebuild docker image

```
sudo ./resize-cluster.sh 5
```
- specify parameter > 1: 2, 3..
- this script just rebuild hadoop image with different **slaves** file, which pecifies the name of all slave nodes


#####3. start container

```
./start-container.sh 5
```
- use the same parameter as the step 2

#####4. run hadoop cluster

do 5~6 like section A
