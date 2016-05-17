# Zookeeper
http://oss.infoscience.co.jp/hadoop/zookeeper/docs/r3.3.1/zookeeperProgrammers.html#ch_zkDataModel
```
wget http://www-us.apache.org/dist/zookeeper/zookeeper-3.3.6/zookeeper-3.3.6.tar.gz
tar xfvz zookeeper-3.3.6.tar.gz
cd zookeeper-3.3.6
cp conf/zoo_sample.cfg conf/zoo.cfg
./bin/zkServer.sh start
./bin/zkCli.sh -localhost:2181
(shellが起動する
```
