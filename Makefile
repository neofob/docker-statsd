# Simple Makefile to build stuff
# __author__: tuan t. pham tuan at vt dot edu
#

DOCKER_NAME ?=tuan/statsd
TAG ?=latest

all: docker

docker: Dockerfile
	docker build -t $(DOCKER_NAME):$(TAG) .

help:
	@echo	"A little help from your Makefile friend"
	@echo	"Available targets:"
	@echo
	@echo	"help:"
	@echo	"\tThis help message"
	@echo
	@echo	"docker:"
	@echo	"\tBuild the docker from Dockerfile and tag it as $(DOCKER_NAME):$(TAG)"
	@echo	"\tCustomize the tag DOCKER_NAME=MyName TAG=MyTag make docker"
	@echo
	@echo	"clean:"
	@echo	"\tRemoving the docker image $(DOCKER_NAME):$(TAG)"
	@echo
	@echo	"__author__: tuan t. pham"

clean:
	@echo "Cleaning up the old docker image"
	docker rmi -f $(DOCKER_NAME):$(TAG)
