# msyql master-slave
## master でreplicatioユーザを作成する
* GRANT REPLICATION SLAVE   ON *.*   TO 'repl'@'%' IDENTIFIED BY 'pass';

## slave
* CHANGE MASTER TO  MASTER_HOST='192.168.33.10', MASTER_PORT=1111, MASTER_USER='repl',  MASTER_PASSWORD='pass';

## source db => master
* リストアに時間がかかる場合、レコード数の多いテーブルをdropしておく
* mysqldump -uroot reprica_outing --no-autocommit --order-by-primary --master-data=2 --flush-logs --hex-blob | mysql -u root -h 192.168.33.10 -ppass outing_development --port 1111

## master => slave
* mysqldump -uroot -h 192.168.33.10 --pass outing_development --port 1111 --master-data=2 --flush-logs --hex-blob | mysql -u root -h 192.168.33.10 -ppass outing_development --port 2222


## slave
* start slave;

## slave を止めてから開始する
* docker-compose exec slave service mysql stop
* docker-compose start slave
