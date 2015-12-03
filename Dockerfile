FROM        ubuntu:14.04
MAINTAINER  Kim Neunert <kim.neunert@hybris.de>

RUN     echo "deb http://archive.ubuntu.com/ubuntu trusty main universe" > /etc/apt/sources.list  &&\
        apt-get -y update  &&\
        apt-get -y install wget git &&\
        wget -q -O /tmp/node.tar.gz https://nodejs.org/dist/v4.2.2/node-v4.2.2-linux-x64.tar.gz  &&\
        tar -C /usr/local/ --strip-components=1 -zxf /tmp/node.tar.gz  &&\
        rm /tmp/node.tar.gz  &&\
        git clone -b v0.7.2 --depth 1 git://github.com/etsy/statsd.git statsd  &&\
        apt-get clean  &&\
        rm -rf /tmp /var/cache/apt

ADD     ./config.js ./statsd/config.js

EXPOSE  8125/udp
EXPOSE  8126/tcp

CMD     /usr/local/bin/node /statsd/stats.js /statsd/config.js
