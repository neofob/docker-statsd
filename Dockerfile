FROM        debian:jessie
MAINTAINER  Tuan T. Pham <tuan@vt.edu>

ENV	PKGS "wget git xz-utils"
ENV	NODE_JS_URL https://nodejs.org/dist/v4.6.0/node-v4.6.0-linux-x64.tar.xz
ENV	STATSD_GIT git://github.com/etsy/statsd.git
ENV	STATSD_TAG v0.8.0

RUN	apt-get -yq update  && \
        apt-get -yq install ${PKGS} && \
        wget -q -O /tmp/node.tar.xz ${NODE_JS_URL}  && \
        tar -C /usr/local/ --strip-components=1 -Jxf /tmp/node.tar.xz  && \
        rm /tmp/node.tar.xz  && \
        git clone -b ${STATSD_TAG} --depth 1 ${STATSD_GIT} /statsd  && \
        apt-get clean  && \
        rm -rf /tmp /var/cache/apt /var/lib/apt/lists/*

ADD     ./config.js /statsd/config.js

EXPOSE  8125/udp
EXPOSE  8126/tcp

CMD     /usr/local/bin/node /statsd/stats.js /statsd/config.js
