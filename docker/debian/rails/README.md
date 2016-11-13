# About

* ホストのrailsソースをdockerで動かす
* postgresqlはdockerで
* PostgreSQL + Rails

# Usage

```
$ apt-get install ruby
$ ruby -v # 2.1
$ mkdir -p ~/sites
$ cd sites
$ rails new docker-training -d postgresql

$ docker build -t debin/rails .
$ docker run -v /root/docker-training:/sites/docker-training -itd --name web debian/sid-web
$ curl localhost
hello rails
```
