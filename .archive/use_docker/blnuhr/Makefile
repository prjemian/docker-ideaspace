ORG=prjemian
REPO=blnuhr
LOGFILE=build-log.txt
NET=host-bridge
TAG=latest

FULLNAME=$(ORG)/$(REPO):$(TAG)

build ::
	echo "# started: " `date --iso-8601="seconds"` | tee $(LOGFILE)
	docker build \
		-t $(FULLNAME)  \
		./  \
		2>&1 | tee -a $(LOGFILE)
	echo "# finished: " `date --iso-8601="seconds"` | tee -a $(LOGFILE)

run ::
	docker run \
		-it \
		--rm \
		--net=$(NET) \
		--name=$(REPO) \
		-e DISPLAY=$(DISPLAY) \
		-v /tmp/.X11-unix:/tmp/.X11-unix:ro \
		$(FULLNAME) \
		/bin/bash

shell :: build run

push ::
	echo "# push started: " `date --iso-8601="seconds"` | tee -a $(LOGFILE)
	docker push $(FULLNAME) 2>&1 | tee -a $(LOGFILE)
	echo "# push finished: " `date --iso-8601="seconds"` | tee -a $(LOGFILE)

net ::
	docker network create \
		--driver bridge \
		$(NET)
