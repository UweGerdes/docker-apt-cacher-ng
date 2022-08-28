# syntax=docker/dockerfile:1

# Build: docker build -t apt-cacher-ng .
# Run: docker run -d -p 3142:3142 --name apt-cacher-ng apt-cacher-ng
#
# and then you can run containers with:
#   docker run -t -i --rm -e http_proxy http://dockerhost:3142/ debian bash
#
# Here, `dockerhost` is the IP address or FQDN of a host running the Docker daemon
# which acts as an APT proxy server.
FROM   ubuntu
MAINTAINER entwicklung@uwegerdes.de

ARG TZ=UTC
ENV TZ ${TZ}
RUN echo '${TZ}' >/etc/timezone

VOLUME ["/var/cache/apt-cacher-ng"]
RUN    apt-get update && apt-get install -y apt-cacher-ng

EXPOSE 3142
CMD    chmod 777 /var/cache/apt-cacher-ng && /etc/init.d/apt-cacher-ng start && tail -f /var/log/apt-cacher-ng/*
