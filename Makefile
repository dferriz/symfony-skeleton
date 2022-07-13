SHELL := bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules
MAKEFLAGS += --no-print-directory

ifneq (,$(wildcard .env))
    include .env
    export
endif

ifneq (,$(wildcard .env.local))
    include .env.local
    export
endif

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' Makefile | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
.PHONY: help

build:	## Builds development stack
	@docker-compose build
	@make up
	@make dependencies
.PHONY: build

rebuild: ## Rebuilds all the stack creating all from zero
	@docker-compose build --pull --force-rm --no-cach
	@make up
	@make dependencies
.PHONY: rebuild

dependencies: ## Install all needed dependencies 
	@echo "Nothing to do"
	# @docker exec ${DOCKER_PHP_CONTAINER_NAME} composer install
.PHONY: dependencies

up: ## Starts development stack
	@docker-compose up -d
.PHONY: up

down: ## Stops development stack
	@docker-compose down
.PHONY: down

tests: ## Executes tests
	@docker exec -u ${DOCKER_PHP_CONTAINER_USERNAME} ${DOCKER_PHP_CONTAINER_NAME} php bin/phpunit
.PHONY: tests

logs: ## Watch stack logs
	@docker-compose logs -f
.PHONY: logs

