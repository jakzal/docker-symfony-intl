ICU_VERSION ?= 61.1
PHP_VERSION ?= 5.6

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
