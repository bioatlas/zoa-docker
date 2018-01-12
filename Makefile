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

ssl-certs:
	@echo "Generating SSL certs using https://hub.docker.com/r/paulczar/omgwtfssl/"
	docker run -v /tmp/certs:/certs \
		-e SSL_SUBJECT=bioatlas.se \
		-e SSL_DNS=zoa.bioatlas.se \
	paulczar/omgwtfssl
	cp /tmp/certs/cert.pem certs/bioatlas.se.crt
	cp /tmp/certs/key.pem certs/bioatlas.se.key

	@echo "Using self-signed certificates will require either the CA cert to be imported system-wide or into apps"
	@echo "if you don't do this, apps will fail to request data using SSL (https)"
	@echo "WARNING! You now need to import the /tmp/certs/ca.pem file into Firefox/Chrome etc"
	@echo "WARNING! For curl to work, you need to provide '--cacert /tmp/certs/ca.pem' switch or SSL requests will fail."

ssl-certs-clean:
	rm -f certs/bioatlas.se.crt certs/bioatlas.se.key
	rm -f /tmp/certs

ssl-certs-show:
	#openssl x509 -in certs/dina-web.net.crt -text
	openssl x509 -noout -text -in certs/bioatlas.se.crt
