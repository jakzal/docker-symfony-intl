# Docker images for testing the Symfony Intl Component

Docker images for running tests of the Symfony Intl Component against various
ICU/Intl versions. These images are not meant to be used on production systems.

## Supported versions

* PHP 7.1 - 7.3
* ICU 52.1 - 64.2

For older PHP or ICU versions check out the legacy branches:

* [legacy-5.x](https://github.com/jakzal/docker-symfony-intl/tree/legacy-5.x)
* [legacy-7.x](https://github.com/jakzal/docker-symfony-intl/tree/legacy-7.x)

## Usage

Images are tagged with a PHP version and an ICU release separated with a dash.
For example, the tag for `PHP 7.2` and `ICU 64.2` is `7.2-64.2`.

```bash
docker run -it --rm \
  -v `pwd`:/symfony -w /symfony \
  jakzal/php-intl:7.2-64.2 \
  ./phpunit /symfony/src/Symfony/Component/Intl/Tests/
```

To list all available tags run the following command (requires [jq](https://stedolan.github.io/jq/) to be installed):

```bash
curl -Ls https://registry.hub.docker.com/v1/repositories/jakzal/php-intl/tags | jq .[].name --raw-output
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
make build ICU_VERSION=64.2
```

Build a chosen PHP version with a chosen ICU release:

```bash
make build ICU_VERSION=64.2 PHP_VERSION=7.2
```
