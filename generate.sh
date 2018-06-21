#!/bin/bash

PHP_VERSIONS=(7.1 7.2)
ICU_RELEASES=(4.4.2 4.6.1 4.8.1.1 49.1.2 50.1.2 51.2 52.1 53.1 54.1 55.1 57.1 58.1 58.2 59.1 60.1 60.2 61.1 62.1)

for icu_release in "${ICU_RELEASES[@]}"; do
    for php_version in "${PHP_VERSIONS[@]}"; do
        dockerfile_template="Dockerfile-intl"
        if [ -f "Dockerfile-intl-$php_version" ]; then
            dockerfile_template="Dockerfile-intl-$php_version"
        fi

        dockerfile_dir="$php_version/$icu_release"

        mkdir -p $dockerfile_dir
        cat $dockerfile_template | sed -e 's#ICU_RELEASE=.*#ICU_RELEASE='$icu_release'#g' | sed -e 's#FROM php:[^\-]*-cli#FROM php:'$php_version'-cli#g' > $dockerfile_dir/Dockerfile
    done
done
