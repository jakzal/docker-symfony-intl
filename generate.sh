#!/bin/bash

PHP_VERSIONS=(7.3 7.4)
ICU_RELEASES=(66.1 67.1 68.1)

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
