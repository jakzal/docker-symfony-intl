# Docker images for testing the Symfony Intl Component

Docker images for running tests of the Symfony Intl Component against various
ICU/Intl versions. These images are not meant to be used on production systems.

## Supported versions

* PHP 7.1 - 7.3
* ICU 63.1 - 65.1

For older PHP or ICU versions check out the legacy branches:

* [legacy-5.x](https://github.com/jakzal/docker-symfony-intl/tree/legacy-5.x)
* [legacy-7.x](https://github.com/jakzal/docker-symfony-intl/tree/legacy-7.x)

## Usage

Images are tagged with a PHP version and an ICU release separated with a dash.
For example, the tag for `PHP 7.2` and `ICU 65.1` is `7.2-65.1`.

```bash
docker run -it --rm \
  -v `pwd`:/symfony -w /symfony \
  jakzal/php-intl:7.2-65.1 \
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
make build ICU_VERSION=65.1
```

Build a chosen PHP version with a chosen ICU release:

```bash
make build ICU_VERSION=65.1 PHP_VERSION=7.2
```

## Running Symfony Intl tests

It's best to run these tests on a system that natively supports Docker.
If you're not a Linux desktop user, you can create a digitalocean droplet with little effort (or use other cloud provider):

```bash
docker-machine create --driver digitalocean --digitalocean-access-token $DIGITAL_OCEAN_ACCESS_TOKEN \
                                            --digitalocean-image "ubuntu-18-10-x64" \
                                            --digitalocean-size "2gb" \
                                            --digitalocean-region "lon1" \
                                            symfony-intl
eval "$(docker-machine env symfony-intl)"
docker run --rm -it  jakzal/php-intl:7.3-65.1 bash
```

Clone the Symfony repository and switch to the branch you want to test:

```bash
git clone https://github.com/jakzal/symfony.git \
  && cd symfony \
  && git checkout icu-65.1 \
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
