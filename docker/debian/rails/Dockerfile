FROM debian:sid
MAINTAINER jikko

RUN apt-get update

# development
RUN apt-get install zsh -y
RUN chsh -s /usr/bin/zsh

# for db
RUN apt-get install postgresql-9.4 -y

# nokogiri
RUN apt-get install libxml2-dev libxslt1-dev -y
RUN gem install nokogiri -- --use-system-libraries

# for rails
RUN apt-get install ruby -y # installed 2.1
RUN gem install rails -v 4.1 --no-ri --no-rdoc
RUN gem install nokogiri -- --use-system-libraries --no-ri --no-rdoc

