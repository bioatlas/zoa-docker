# zoa-docker

[![AGPLv3 License](http://img.shields.io/badge/license-AGPLv3-blue.svg)](https://github.com/bioatlas/zoa-docker/blob/master/LICENSE)

Note: This is Work In Progress - 

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

Settings are currently stored in `.env`

The `app.conf` exposes various services under the $SPATIAL_FQDN (currently `zoa.bioatalas.se`)

The zoatrack component needs to be configured with various system properties in `zoatrack.properties`

## Issues

There seems postgis needs to have a user named "oztrack" due to Flyway migration code:

		zoatrack_1   | 2018-01-10 10:22:24,404 ERROR DbMigrator.run: com.googlecode.flyway.core.exception.FlywayException: Error executing statement at line 27: ALTER TABLE public.acousticdetection OWNER TO oztrack

Even with a "oztrack" user provided, Migration to version 87 fails:

		org.springframework.beans.factory.BeanCreationException: Error creating bean with name 'embargoUpdater': Injection of persistence dependencies failed; nested exception is org.springframework.beans.factory.BeanCreationException: Error creating bean with name 'flyway' defined in class path resource [org/oztrack/conf/spring/applicationContext-data.xml]: Invocation of init method failed; nested exception is com.googlecode.flyway.core.migration.MigrationException: Migration to version 87 failed! Changes successfully rolled back.

