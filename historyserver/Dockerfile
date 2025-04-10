ARG BASE_VERSION=2.0.0-hadoop3.3.6-java11

FROM closetool/hadoop-base:${BASE_VERSION}

LABEL org.opencontainers.image.authors="Kiloson <4closetool3@gmail.com>"

HEALTHCHECK CMD curl -f http://localhost:8188/ || exit 1

ENV YARN_CONF_yarn_timeline___service_leveldb___timeline___store_path=/hadoop/yarn/timeline
RUN mkdir -p /hadoop/yarn/timeline
VOLUME /hadoop/yarn/timeline

ADD run.sh /run.sh
RUN chmod a+x /run.sh

EXPOSE 8188

CMD ["/run.sh"]
