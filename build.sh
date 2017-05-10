#!/bin/bash

PHP_VERSION=${1:-"-"}
ICU_RELEASE=${2:-"-"}

php_versions=$PHP_VERSION
if [ "$PHP_VERSION" == "-" ]; then
    php_versions=$(ls -d ./[57]* | cut -c 3-)
fi

for php_version in $php_versions; do
    icu_releases=$ICU_RELEASE
    if [ "$ICU_RELEASE" == "-" ]; then
        icu_releases=$(ls -d ./$php_version/* | cut -c 7-)
    fi
    for icu_release in $icu_releases; do
        cd "./$php_version/$icu_release" && ls && docker build . -t "jakzal/php-intl:$php_version-$icu_release"
        cd -
    done
done
