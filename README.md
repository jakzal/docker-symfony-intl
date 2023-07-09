# Docker images for testing the Symfony Intl Component

Docker images for running tests of the Symfony Intl Component against various
ICU/Intl versions. These images are not meant to be used on production systems.

## Supported versions

* PHP 8.1, 8.2
* ICU 70.1 - 71.1

For older PHP or ICU versions check out older [Docker image tags](https://hub.docker.com/repository/docker/jakzal/php-intl/tags).

## Usage

Images are tagged with a PHP version and an ICU release separated with a dash.
For example, the tag for `PHP 8.2` and `ICU 71.1` is `8.2-71.1`.

```bash
docker run -it --rm \
  -v `pwd`:/symfony -w /symfony \
  jakzal/php-intl:8.2-71.1 \
  ./phpunit /symfony/src/Symfony/Component/Intl/Tests/
```

To list all available tags run the following command (requires [jq](https://stedolan.github.io/jq/) to be installed):

```bash
curl -Ls 'https://registry.hub.docker.com/v2/repositories/jakzal/php-intl/tags?page_size=20' | jq '.results[].name' --raw-output | sort
```

## Image development

### Building images

Build the latest PHP version with the latest ICU release:

```bash
make build
```

Build the latest PHP version with a chosen ICU release:

```bash
make build ICU_VERSION=71.1
```

Build a chosen PHP version with a chosen ICU release:

```bash
make build ICU_VERSION=71.1 PHP_VERSION=8.2
```

## Running Symfony Intl tests

It's best to run these tests on a system that natively supports Docker.
If you're not a Linux desktop user, you can create a digitalocean droplet with little effort (or use other cloud provider):

```bash
docker-machine create --driver digitalocean --digitalocean-access-token $DIGITAL_OCEAN_ACCESS_TOKEN \
                                            --digitalocean-image "ubuntu-19-04-x64" \
                                            --digitalocean-size "4gb" \
                                            --digitalocean-region "lon1" \
                                            symfony-intl
eval "$(docker-machine env symfony-intl)"
docker run --rm -it  jakzal/php-intl:8.2-71.1 bash
```

Clone the Symfony repository and switch to the branch you want to test:

```bash
git clone https://github.com/jakzal/symfony.git \
  && cd symfony \
  && git checkout icu-71.1 \
  && composer install
```

Run all `intl-data` tests:

```bash
./phpunit --group intl-data
```

Destroy the droplet when you're done:

```bash
docker-machine rm symfony-intl
```
