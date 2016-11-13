FROM debian:sid
MAINTAINER jikko

RUN apt-get update
RUN apt-get install nginx curl -y

ADD src /var/www/html
RUN chmod -R 644 /var/www/html/*
ADD init.sh /usr/local/bin/init.sh

RUN chmod u+x /usr/local/bin/init.sh
CMD ["/usr/local/bin/init.sh"]
