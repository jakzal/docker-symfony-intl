ICU_VERSION ?= 60.1
PHP_VERSION ?= 7.1

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
