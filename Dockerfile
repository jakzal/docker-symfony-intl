ARG PHP_VERSION=8.2
ARG ICU_VERSION=74.1

FROM php:${PHP_VERSION}-cli

ARG PHP_VERSION
ARG ICU_VERSION

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV BUILD_DEPS="autoconf file pkg-config re2c"
ENV LIB_DEPS="zlib1g-dev libzip-dev"
ENV TOOL_DEPS="git build-essential"
ENV ICU_RELEASE=$ICU_VERSION
ENV CXXFLAGS "--std=c++0x"

RUN apt-get update && apt-get install -y --no-install-recommends $BUILD_DEPS $LIB_DEPS $TOOL_DEPS && rm -rf /var/lib/apt/lists/* \
 && echo "date.timezone=Europe/Warsaw" >> $PHP_INI_DIR/php.ini \
 && docker-php-ext-install zip \
 && export ICU_DOWNLOAD_URL="https://github.com/unicode-org/icu/releases/download/release-$(echo $ICU_RELEASE | tr '.' '-')/icu4c-$(echo $ICU_RELEASE | tr '.' '_')-src.tgz" \
 && echo "Downloading $ICU_DOWNLOAD_URL" \
 && cd /tmp && curl -Ls "$ICU_DOWNLOAD_URL" > icu4c-src.tgz \
 && cd /tmp && tar xzf icu4c-src.tgz && cd /tmp/icu/source && echo "#define FALSE 0" >> config.h && echo "#define TRUE 1" >> config.h && ./runConfigureICU Linux && make && make install && rm -rf /tmp/icu /tmp/icu4c-src.tgz \
 && docker-php-ext-configure intl && docker-php-ext-install intl \
 && apt-get purge -y --auto-remove $BUILD_DEPS

COPY --from=composer /usr/bin/composer /usr/bin/composer

CMD icu-config --version && php -i | grep 'ICU version'
