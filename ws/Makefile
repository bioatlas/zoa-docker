#! make

all: init build

init:
	@test -d oztrack || \
		git clone --depth=1 https://github.com/bioatlas/oztrack.git
		# argos library missing, manuel import
		mkdir -p oztrack/target/classes/
		wsimport -extension http://ws-argos.clsamerica.com/argosDws/services/DixService?wsdl -d oztrack/target/classes/

build: build-war build-image

build-war:
	docker run -it --rm --name my-maven-project \
		-v $(PWD)/oztrack:/usr/src/mymaven \
		-v $(PWD)/m2:/root/.m2 \
		-w /usr/src/mymaven \
		maven:3 bash -c "mvn package"
#		-v $(PWD)/settings-docker.xml:/root/.m2/settings.xml \

build-image:
	docker build -t bioatlas/zoatrack:latest .
