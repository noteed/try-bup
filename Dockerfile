FROM ubuntu:12.04
MAINTAINER Vo Minh Thu <noteed@gmail.com>

RUN apt-get update
RUN apt-get install -q -y language-pack-en
RUN update-locale LANG=en_US.UTF-8

RUN apt-get install -q -y vim
RUN apt-get install -q -y git
RUN apt-get install -q -y tree

RUN git clone https://github.com/bup/bup.git
ADD prepare.sh /prepare.sh

CMD /bin/bash
