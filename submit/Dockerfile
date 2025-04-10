ARG BASE_VERSION=2.0.0-hadoop3.3.6-java11

FROM closetool/hadoop-base:${BASE_VERSION}

LABEL org.opencontainers.image.authors="Kiloson <4closetool3@gmail.com>"

COPY WordCount.jar /opt/hadoop/applications/WordCount.jar

ENV JAR_FILEPATH="/opt/hadoop/applications/WordCount.jar"
ENV CLASS_TO_RUN="WordCount"
ENV PARAMS="/input /output"

ADD run.sh /run.sh
RUN chmod a+x /run.sh

CMD ["/run.sh"]
