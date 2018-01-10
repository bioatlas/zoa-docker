all: init build

init:
	git clone --depth=1 https://github.com/AtlasOfLivingAustralia/oztrack.git

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
