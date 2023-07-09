ICU_VERSION ?= 73.2
PHP_VERSION ?= 8.2

default: build

build:
	docker build . --build-arg PHP_VERSION=$(PHP_VERSION) --build-arg ICU_VERSION=$(ICU_VERSION) -t "jakzal/php-intl:$(PHP_VERSION)-$(ICU_VERSION)"
.PHONY: build
