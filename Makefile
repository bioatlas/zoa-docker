#!make

-include .env

DOCKER_SLUG = bioatlas/zoa
ZOA_URL = https://github.com/AtlasOfLivingAustralia/oztrack
ZOA_VERSION = 2.0
VERSION = $(TRAVIS_BUILD_ID)

ME = $(USER)

MVN := maven:3.3.9-jdk-8
TS := $(shell date '+%Y_%m_%d_%H_%M')
PWD := $(shell pwd)
USR := $(shell id -u)
GRP := $(shell id -g)

all: init build up
.PHONY: all

init:
	@echo "Caching files required for the build..."

	@test -f wait-for-it.sh || \
		curl --progress -L -s -o wait-for-it.sh \
			https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh && \
			chmod +x wait-for-it.sh
	@cp wait-for-it.sh ws

clean:
	rm -f ws/wait-for-it.sh 

build: build-ws build-rserve

build-ws:
	@echo "Building zoatrack image..."
	@docker build -t $(DOCKER_SLUG):$(ZOA_VERSION) ws \
		--build-arg ZOAVERSION=$(ZOA_VERSION)

build-rserve:
	@echo "Building rserve image..."
	make -C rserve
		
up:
	@echo "Starting services..."
	set -a && . $(PWD)/.env && docker-compose up -d

down:
	@echo "Stopping services..."
	@docker-compose down

connect-db:
	@docker-compose run postgis \
		psql -U $(POSTGRES_USER) -d $(POSTGRES_DB)

backup-db:
	docker exec -it db \
		bash -c "pg_dump -U $(POSTGRES_USER) -d $(POSTGRES_DB) > /tmp/zoa.sql"

test:
	@echo "Will open the services locally in the browser if you have dnsmasq setup"
	@xdg-open http://$(SPATIAL_FQDN)

rm: stop
	@echo "Removing containers and persisted data"
	docker-compose rm -vf

push:
	@docker push $(DOCKER_SLUG):$(ZOA_VERSION)

release: build push
