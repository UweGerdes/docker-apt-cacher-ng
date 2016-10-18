FROM ubuntu:latest
MAINTAINER entwicklung@uwegerdes.de

ARG TZ=UTC

ENV DEBIAN_FRONTEND noninteractive
ENV TZ ${TZ}

RUN echo '${TZ}' >/etc/timezone && \
	apt-get update && \
	apt-get dist-upgrade -y && \
	apt-get install -y \
			apt-cacher-ng && \
	rm -rf /var/lib/apt/lists/*

VOLUME "/var/cache/apt-cacher-ng"

EXPOSE 3142

COPY /start.sh /start.sh
RUN chmod a+x /start.sh

CMD ["/start.sh"]
