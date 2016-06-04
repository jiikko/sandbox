# Dockeor

## Debian/wheezy
```
# build
docker build -t localhost:5000/debian-wheezy ./debian/wheezy

# run
ID=$(docker run --privileged -d -t --name 'wheezy' localhost:5000/debian-wheezy)
IP=$(docker inspect --format="{{ .NetworkSettings.IPAddress }}" $ID)
echo $ID $IP
docker run -i -t --name 'wheezy-i' localhost:5000/debian-wheezy /bin/bash
```

## Debian/jessie/fluentd
```
docker build -t localhost:5000/debian-jessie-fluentd ./debian/jessie/fluentd
docker run -i -t --name 'jessie-fluentd' localhost:5000/debian-jessie-fluentd /bin/bash
```
