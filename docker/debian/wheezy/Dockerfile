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

FROM debian:wheezy
MAINTAINER koji <n905.1214@gmail.com>

WORKDIR /tmp

# apt-get
ENV DEBIAN_FRONTEND noninteractive
# ADD sources.list /etc/apt/sources.list
RUN apt-get update && apt-get install -y apt-utils && apt-get dist-upgrade -y \
 && apt-get install -y openssh-server sudo build-essential zsh vim wget rsyslog

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


# cleanup
# RUN apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*


# ssh
EXPOSE 22 6379 26379

ADD start.sh /start.sh
CMD /start.sh
