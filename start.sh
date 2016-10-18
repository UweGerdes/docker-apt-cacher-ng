#!/bin/bash

# Run apt-cacher-ng
/usr/sbin/apt-cacher-ng -c /etc/apt-cacher-ng

# keep container alive
sleep infinity
