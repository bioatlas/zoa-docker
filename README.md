# zoa-docker

[![AGPLv3 License](http://img.shields.io/badge/license-AGPLv3-blue.svg)](https://github.com/bioatlas/zoa-docker/blob/master/LICENSE)

Note: This is Work In Progress

# Configuration files

Settings are currently stored in `.env`

The `app.conf` exposes various services under the $SPATIAL_FQDN (currently `zoa.bioatalas.se`)

The zoatrack component needs to be configured with various system properties in `zoatrack.properties`

## DNS config

Please add this to /etc/resolvconf/resolv.conf.d/head

		nameserver 172.17.0.1

This will make the host running the composition of services aware of the dnsmasq component

