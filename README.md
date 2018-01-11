# zoa-docker

[![AGPLv3 License](http://img.shields.io/badge/license-AGPLv3-blue.svg)](https://github.com/bioatlas/zoa-docker/blob/master/LICENSE)

Note: This is Work In Progress ...

## Requirements

Install `git`, `make`, `docker` and `docker-compose`. Then, for name resolution to work, make your system aware of the `dnsmasq` name resolver that will be launched by docker and is defined in the `docker-compose.yml` file. 

On Linux this can be done by editing `/etc/resolvconf/resolv.conf.d/head`, adding this line:

		nameserver 172.17.0.1

Then restart `resolvconf` using this command:

		sudo systemctl restart resolvconf.service

For variations of how to do this on MacOS and other platforms, please search the Internet.

For setting up SSL, see instructions at <https://github.com/dina-web/proxy-docker/tree/self-signed-certs#certificates-and-setting-up-ssl>

## Usage

Issue the following command provided you have `make`, `git`, `docker` and `docker-compose`:

		make

## Configuration

The `app.conf` exposes various services under the domain name where it is launched (currently `zoa.bioatalas.se`)

The zoatrack component needs to be configured with various system properties, reasonable defaults are provided in `zoatrack.properties`

