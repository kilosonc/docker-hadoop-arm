ARG BASE_VERSION=2.0.0-hadoop3.3.6-java11

FROM closetool/hadoop-base:${BASE_VERSION}

LABEL org.opencontainers.image.authors="Kiloson <4closetool3@gmail.com>"

HEALTHCHECK CMD curl -f http://localhost:9864/ || exit 1

ENV HDFS_CONF_dfs_datanode_data_dir=file:///hadoop/dfs/data
RUN mkdir -p /hadoop/dfs/data
VOLUME /hadoop/dfs/data

ADD run.sh /run.sh
RUN chmod a+x /run.sh

EXPOSE 9864

CMD ["/run.sh"]
