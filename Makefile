#
# Docker Makefile
#

# Variables
IMAGE=bdwyertech/journald-cloudwatch-logs

#
.PHONY: help

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help


build: ## Build the Container
	docker build . -t ${IMAGE} -f Dockerfile

binary: build ## Create a Binary Artifact
	docker run --rm -iv${PWD}:/host ${IMAGE} bash -c 'cp -f journald-cloudwatch-logs /host'

publish: build ## Build & Publish the Container
	docker push ${IMAGE}

test: build ## Build & Test the Container
	docker run --rm -iv${PWD}:/host ${IMAGE} journald-cloudwatch-logs /host/sample.conf
