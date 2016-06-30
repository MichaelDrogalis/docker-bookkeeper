FROM java:openjdk-8-jre-alpine
MAINTAINER Gardner Vickers <gardner.vickers@onyxplatform.org>

RUN apk add --no-cache wget bash \
    && mkdir -p /opt \
    && wget -q -O - https://archive.apache.org/dist/bookkeeper/bookkeeper-4.3.2/bookkeeper-server-4.3.2-bin.tar.gz | tar -xzf - -C /opt \
    && mv /opt/bookkeeper-server-4.3.2 /opt/bookkeeper \
    && rm -rf /opt/bookkeeper/conf

WORKDIR /opt/bookkeeper

COPY conf-dir /opt/bookkeeper/conf/
ADD bk-docker.sh /usr/local/bin/
ADD start-bookkeeper.sh /usr/local/bin/
COPY bookkeeper /opt/bookkeeper/bin/
COPY bookkeeper-daemon.sh /opt/bookkeeper/bin/
COPY bookkeeper-cluster.sh /opt/bookkeeper/bin/

RUN ["mkdir", "-p", "/data/", "/data/journal", "/data/index", "/data/ledger"]
RUN ["chmod", "+x", "/usr/local/bin/bk-docker.sh"]
RUN ["chmod", "+x", "/usr/local/bin/start-bookkeeper.sh"]

VOLUME ["/data/journal", "/data/index", "/data/ledger"]

EXPOSE 3181/tcp

ENTRYPOINT ["/usr/local/bin/bk-docker.sh"]

CMD ["/opt/bookkeeper/bin/bookkeeper", "bookie"]
