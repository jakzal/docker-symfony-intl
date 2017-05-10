# Docker images for testing the Symfony Intl Component

Docker images for running tests of the Symfony Intl Component against various
ICU/Intl versions. These images are not meant to be used on production systems.

## Generating docker files

The following command will re-generate all the `Dockerfile`s that then can
be used to build PHP images with intl support:

```bash
make generate
```

## Building images

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
make build ICU_RELEASE=59.1
```

Build a chosen PHP version with a chose ICU release:

```bash
make build ICU_RELEASE=59.1 PHP_VERSION=7.1
```
