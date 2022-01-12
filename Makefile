ROOT := $(shell dirname -- "$(abspath "$(lastword "$(MAKEFILE_LIST)")")")

IMAGE_NAME ?= jenkins-semantic-release
DOCKER_REPO := ghcr.io/silenteight
VERSION ?= latest

.DEFAULT_GOAL := help
help:  ## List targets & descriptions
	@cat Makefile* | grep -E '^[a-zA-Z_-]+:.*?## .*$$' | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: build
build:  ## Build container image
	docker build --pull -t $(IMAGE_NAME):$(VERSION) .

.PHONY: push
push: build  ## Push container image to repository
	@echo "Push $(VERSION) to $(DOCKER_REPO)"
	docker push $(IMAGE_NAME):$(VERSION)
