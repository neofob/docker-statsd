FROM        ubuntu:14.04
MAINTAINER  John Klingler <jfklingler@gmail.com>

RUN     echo "deb http://archive.ubuntu.com/ubuntu trusty main universe" > /etc/apt/sources.list  &&\
        apt-get -y update  &&\
        apt-get -y install wget git python  &&\
        wget -O /tmp/node-v0.11.9.tar.gz http://nodejs.org/dist/v0.11.9/node-v0.11.9-linux-x64.tar.gz  &&\
        tar -C /usr/local/ --strip-components=1 -zxvf /tmp/node-v0.11.9.tar.gz  &&\
        rm /tmp/node-v0.11.9.tar.gz  &&\
        git clone git://github.com/etsy/statsd.git statsd  &&\
        apt-get clean  &&\
        rm -rf /tmp /var/cache/apt

ADD     ./config.js ./statsd/config.js

EXPOSE  8125/udp
EXPOSE  8126/tcp

CMD     /usr/local/bin/node /statsd/stats.js /statsd/config.js
