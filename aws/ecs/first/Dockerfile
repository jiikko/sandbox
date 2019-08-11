FROM debian:sid
RUN apt-get update \
      && apt-get install vim curl less nginx --yes \
      && apt-get clean \
      && rm -rf /var/lib/apt/lists/*
COPY nginx.conf /etc/nginx/nginx.conf
ADD start.sh /
CMD ["sh", "/start.sh"]
