# Docker uwegerdes/apt-cacher-ng

A docker for caching apt repositories. The files should be saved on your host system so this docker image / container can be rebuilt without loosing the cached data.

## Running

Create the cache directory and start the apt-cacher-ng container:

```bash
$ sudo mkdir -p /srv/docker/apt-cacher-ng
$ sudo chmod a+w /srv/docker/apt-cacher-ng
$ docker build -t uwegerdes/apt-cacher-ng --build-arg TZ="Europe/Berlin" .
$ docker run -d \
	--restart=always \
	--name apt-cacher-ng \
	--hostname apt-cacher-ng \
	-p 3142:3142 \
	-v /srv/docker/apt-cacher-ng:/var/cache/apt-cacher-ng \
	uwegerdes/apt-cacher-ng
```

Configuration and information about the cache is available with your browser, open [http://localhost:3142/acng-report.html](http://localhost:3142/acng-report.html) or the ip:port of the computer running `apt-cacher-ng`.

You should open port 3142 in your firewall to allow access from the docker-engine (on another network in your PC!), in my case it's `ufw`:

```bash
$ sudo ufw allow to any port 3142
```

## Using

Add the following lines to your Dockerfile (see [uwegerdes/baseimage](https://github.com/UweGerdes/docker-baseimage)):

```
ARG APT_PROXY
RUN if [ -n "${APT_PROXY}" ]; then \
		echo "Acquire::http { Proxy \"${APT_PROXY}\"; };" >> /etc/apt/apt.conf.d/01proxy; \
		echo "Acquire::https { Proxy \"https://\"; };" >> /etc/apt/apt.conf.d/01proxy; \
	fi
```
