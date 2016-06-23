FROM java:7
MAINTAINER Michael Drogalis <michael.drogalis@onyxplatform.org>

ADD https://archive.apache.org/dist/bookkeeper/bookkeeper-4.3.2/bookkeeper-server-4.3.2-bin.tar.gz /bookkeeper-server-4.3.2-bin.tar.gz
ADD run.sh /run.sh

RUN chmod +x /run.sh

RUN tar -xvf /bookkeeper-server-4.3.2-bin.tar.gz

RUN rm -r /bookkeeper-server-4.3.2/conf

ADD conf-dir/ /bookkeeper-server-4.3.2/conf/

EXPOSE 3181/tcp

ENTRYPOINT ["./run.sh"]
