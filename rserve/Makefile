#! make

all: init build

init:

	# the "-q --show-progress" used below may need an up-to-date wget
	# such as v 1.17.1

	@test -f kftrack_0.70-x64.tar.gz || \
		wget -q --show-progress -O kftrack_0.70-x64.tar.gz \
		'https://rawgit.com/positioning/kalmanfilter/master/downloads/R3x/64bit/linux/kftrack_0.70-x64.tar.gz'

	@test -f ukfsst_0.3-x64.tar.gz || \
		wget -q --show-progress -O ukfsst_0.3-x64.tar.gz \
		'https://rawgit.com/positioning/kalmanfilter/master/downloads/R3x/64bit/linux/ukfsst_0.3-x64.tar.gz'

build:
	docker build -t bioatlas/rserve:latest .
