# Docker images for testing the Symfony Intl Component

Docker images for running tests of the Symfony Intl Component against various
ICU/Intl versions. These images are not meant to be used on production systems.

## Supported versions

* PHP 7.0 - 7.3
* ICU 4.4.2 - 62.1

## Usage

Images are tagged with a PHP version and an ICU release separated with a dash.
For example, the tag for `PHP 7.0` and `ICU 62.1` is `7.0-62.1`.

```bash
docker run -it --rm \
  -v `pwd`:/symfony -w /symfony \
  jakzal/php-intl:7.0-62.1 \
  ./phpunit /symfony/src/Symfony/Component/Intl/Tests/
```

## Image development

### Generating docker files

The following command will re-generate all the `Dockerfile`s that then can
be used to build PHP images with intl support:

```bash
make generate
```

### Building images

Build all images (will take a lot of time):

```bash
make build-all
```

Build the latest PHP version with the latest ICU release:

```bash
make build
```

Build the latest PHP version with a chosen ICU release:

```bash
make build ICU_VERSION=62.1
```

Build a chosen PHP version with a chosen ICU release:

```bash
make build ICU_VERSION=62.1 PHP_VERSION=7.0
```
