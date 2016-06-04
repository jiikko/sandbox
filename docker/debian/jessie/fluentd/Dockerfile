#############################################################################
#
# build
# docker build -t localhost:5000/debian-wheezy-redis .
#
# run
# ID=$(docker run --privileged -d -t --name 'redis1' localhost:5000/debian-wheezy-redis)
# IP=$(docker inspect --format="{{ .NetworkSettings.IPAddress }}" $ID)
# echo $ID $IP
#############################################################################

FROM debian:jessie
MAINTAINER koji <n905.1214@gmail.com>

WORKDIR /tmp

# apt-get
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get dist-upgrade -y
RUN apt-get install openssh-server sudo build-essential zsh vim wget ntp -y

RUN curl -L https://toolbelt.treasuredata.com/sh/install-debian-jessie-td-agent2.sh | sh

# Time zone
RUN echo "Asia/Tokyo" > /etc/timezone && dpkg-reconfigure tzdata

# locale
RUN echo "ja_JP.UTF-8 UTF-8" > /etc/locale.gen \
    && apt-get update \
    && apt-get install locales \
    && update-locale LANG=ja_JP.UTF-8 \
    && . /etc/default/locale

# user
RUN useradd -d /home/koji -m -s /bin/zsh koji && mkdir /home/koji/.ssh
ADD dot.ssh /home/koji/.ssh
ADD dot.zshrc /home/koji/.zshrc
RUN echo 'koji ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
    && chown -R koji:koji /home/koji \
    && chmod -R go-xrw /home/koji/.ssh


# ssh
EXPOSE 22 6379 26379

ADD start.sh /start.sh
CMD /start.sh
