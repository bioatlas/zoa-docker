# zoa-docker

[![AGPLv3 License](http://img.shields.io/badge/license-AGPLv3-blue.svg)](https://github.com/bioatlas/zoa-docker/blob/master/LICENSE)

Note: This is Work In Progress ...

## Requirements

The installation requires a docker host under your control, ie a machine with the `docker` daemon running, see <https://docs.docker.com/engine/installation/>. You also need to install `docker-compose`, see <https://docs.docker.com/compose/install/> and `git` and `make`.

For name resolution to work, make your system aware of the name resolver that will be launched by docker - as defined in the `docker-compose.yml` file in the `dnsmasq` section.

On Linux this can be done by editing `/etc/resolvconf/resolv.conf.d/head`, adding this line:

		nameserver 172.17.0.1

Then restart `resolvconf` using this command:

		sudo systemctl restart resolvconf.service

For variations of how to do this on MacOS and other platforms, please search the Internet.

For setting up SSL, see instructions at <https://github.com/dina-web/proxy-docker/tree/self-signed-certs#certificates-and-setting-up-ssl>

## Usage

The `docker-compose.yml` file defines the various components of the system.

First make sure that you copy your certs into a `certs` directory or use the Makefile to generate self-signed certs (see separate section on that further down).

Then use the `Makefile` which lists various useful targets providing shortcuts to use the composition of system services, for example you can build and start all services with ....

		make

## Certificates and setting up SSL

If you are using SSL certs that you have acquired commercially and those are signed by a CA, put your files, ie shared.crt (bioatlas.se.crt) and shared.key (bioatlas.se.key) in the 'certs' -directory.

You can also generate self-signed certs. Detailed steps:


		# to generate self-signed certs use
		make ssl-certs

		# inspect ssl cert in use with
		make ssl-certs-show

### Commercial certs

If you have bought certs, put them in the certs directory and do NOT run `make ssl-certs` again, as that would overwrite those files.

If you bought certs, you may have several files available:

		key.pem - your secret key originally used in your Certificate Signing Request
		cacert.pem - the Certificate Authority's chain of certs
		cert.pem - your signed (wildcard?) public cert

If so, then combine the last two files - the cacert.pem och cert.pem - into `combined.pem`. In the right order. Pls search Internet for instructions.

### Self-signed certs

Using self-signed certificates will require either the CA cert to be imported and installed either system-wide or in each of your apps. If you don't do this, apps will fail to request data using SSL (https).

So, besides configuring those certs for use in the backend services, you also need to:

- import the /tmp/certs/ca.pem file into Firefox/Chrome or other browsers or clients that you are using on the client side

Pls search for documentation on how to do it, for example:

<https://support.mozilla.org/en-US/questions/995117>

NB: For curl to work, you need to provide '--cacert /tmp/certs/ca.pem' switch or SSL requests will fail. 

## Configuration

The `app.conf` exposes various services under the domain name where it is launched (currently `zoa.bioatalas.se`)

The zoatrack component needs to be configured with various system properties, reasonable defaults are provided in `zoatrack.properties`

