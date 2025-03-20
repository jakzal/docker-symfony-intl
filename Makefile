ICU_VERSION ?= 77.1
PHP_VERSION ?= 8.4

default: build

build:
	docker build . --build-arg PHP_VERSION=$(PHP_VERSION) --build-arg ICU_VERSION=$(ICU_VERSION) -t "jakzal/php-intl:$(PHP_VERSION)-$(ICU_VERSION)"
.PHONY: build
