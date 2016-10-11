FROM containersol/mesos-base:0.1.0
MAINTAINER Container Solutions BV <info@container-solutions.com>

ENV VERSION "1.0.0-2.0.89.ubuntu1404"

RUN echo "deb http://repos.mesosphere.com/ubuntu trusty main" > /etc/apt/sources.list.d/mesosphere.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF && \
    apt-get update && \
    apt-get -y install mesos=${VERSION} && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt/cni/bin
RUN mkdir -p /etc/cni/net.d

ADD 10-weave.conf /etc/cni/net.d/
ADD plugin /opt/cni/bin/weave-net

RUN mkdir /script

ADD run-mesos-agent.sh /script
RUN chmod +x /script/run-mesos-agent.sh

RUN mkdir /weavedb
RUN touch /weavedb/weavedata.db

ADD weaver /script
RUN chmod +x /script/weaver

ADD weave /script
RUN chmod +x script/weave

ENTRYPOINT ["/script/run-mesos-agent.sh"]
