#!make

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

build:
	cd ws && make
	make -C rserve

up:
	docker-compose up -d

down:
	@echo "Removing services..."
	@docker-compose down

test:
	@echo "Will open the services locally in the browser if you have dnsmasq setup"
	@xdg-open https://zoa.bioatlas.se

rm: stop
	@echo "Removing containers and persisted data"
	docker-compose rm -vf

push:
	@docker push bioatlas/zoatrack:latest
	@docker push bioatlas/rserve:latest

release: build push

