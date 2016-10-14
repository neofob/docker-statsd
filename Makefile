# Simple Makefile to build stuff
# __author__: tuan t. pham tuan at vt dot edu

DOCKER_NAME ?=tuan/statsd
GRAPHITE_HOST ?=localhost
UDP_PORT ?=8125
TCP_PORT ?=8126
TAG ?=latest
NAME ?=statsd

all: docker

docker: Dockerfile
	docker build -t $(DOCKER_NAME):$(TAG) .

help:
	@echo	"A little help from your Makefile friend"
	@echo	"\033[1;31mAvailable targets:\033[0m"
	@echo
	@echo	"\033[1;31mhelp:\033[0m"
	@echo	"\tThis help message"
	@echo
	@echo	"\033[1;31mdocker:\033[0m"
	@echo	"\tBuild the docker from Dockerfile and tag it as $(DOCKER_NAME):$(TAG)"
	@echo	"\tCustomize the tag DOCKER_NAME=MyName TAG=MyTag make docker"
	@echo
	@echo	"\033[1;31mrun:\033[0m"
	@echo	"\tRun docker $(DOCKER_NAME):$(TAG)"
	@echo	"\t\tDefault UDP_PORT=$(UDP_PORT) TCP_PORT=$(TCP_PORT) GRAPHITE_PORT=$(GRAPHITE_PORT)"
	@echo
	@echo   "\033[1;31mshutdown:\033[0m"
	@echo	"\tShutdown the running docker $(NAME)"
	@echo	"\tTo specify docker name: NAME=ContainerName make shutdown"
	@echo
	@echo	"\033[1;31mclean:\033[0m"
	@echo	"\tRemoving the docker image $(DOCKER_NAME):$(TAG)"
	@echo
	@echo	"__author__: tuan t. pham"

run:
	docker run -e GRAPHITE_HOST=$(GRAPHITE_HOST) \
		-p 8125:$(UDP_PORT)/udp		\
		-p 8126:$(TCP_PORT)		\
		--name $(NAME)			\
		-d $(DOCKER_NAME):$(TAG)

shutdown:
	docker stop $(NAME)
	docker rm $(NAME)

clean:
	@echo "Removing the old docker image $(DOCKER_NAME):$(TAG)"
	docker rmi -f $(DOCKER_NAME):$(TAG)
