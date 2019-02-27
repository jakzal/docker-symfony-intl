ICU_VERSION ?= 62.1
PHP_VERSION ?= 7.3

default: build

generate:
	./generate.sh
.PHONY: generate

build:
	./build.sh $(PHP_VERSION) $(ICU_VERSION)
.PHONY: build

build-all:
	./build.sh
.PHONY: build-all
