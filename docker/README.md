# Dockeor

## Debian/wheezy
```
build
docker build -t localhost:5000/debian-wheezy ./debian/wheezy

run
ID=$(docker run --privileged -d -t --name 'redis1' localhost:5000/debian-wheezy-redis)
IP=$(docker inspect --format="{{ .NetworkSettings.IPAddress }}" $ID)
echo $ID $IP
```
