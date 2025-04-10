FROM closetool/hadoop-base:2.0.0-hadoop3.3.6-java11

LABEL org.opencontainers.image.authors="Kiloson <4closetool3@gmail.com>"

HEALTHCHECK CMD curl -f http://localhost:8088/ || exit 1

ADD run.sh /run.sh
RUN chmod a+x /run.sh

EXPOSE 8088

CMD ["/run.sh"]
