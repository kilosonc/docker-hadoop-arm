ARG BASE_VERSION=2.0.0-hadoop3.3.6-java11

FROM closetool/hadoop-base:${BASE_VERSION}

LABEL org.opencontainers.image.authors="Kiloson <4closetool3@gmail.com>"

HEALTHCHECK CMD curl -f http://localhost:9870/ || exit 1

ENV HDFS_CONF_dfs_namenode_name_dir=file:///hadoop/dfs/name
RUN mkdir -p /hadoop/dfs/name
VOLUME /hadoop/dfs/name

ADD run.sh /run.sh
RUN chmod a+x /run.sh

EXPOSE 9870

CMD ["/run.sh"]
