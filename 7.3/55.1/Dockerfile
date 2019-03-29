FROM php:7.3-cli

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV BUILD_DEPS="autoconf file pkg-config re2c python"
ENV LIB_DEPS="zlib1g-dev libzip-dev"
ENV TOOL_DEPS="git build-essential"
ENV ICU_RELEASE=55.1
ENV CXXFLAGS "--std=c++0x"

RUN apt-get update && apt-get install -y --no-install-recommends $BUILD_DEPS $LIB_DEPS $TOOL_DEPS && rm -rf /var/lib/apt/lists/* \
 && echo "date.timezone=Europe/Warsaw" >> $PHP_INI_DIR/php.ini \
 && docker-php-ext-install zip \
 && cd /tmp && curl -Ls http://download.icu-project.org/files/icu4c/$ICU_RELEASE/icu4c-$(echo $ICU_RELEASE | tr '.' '_')-src.tgz > icu4c-src.tgz \
 && cd /tmp && tar xzf icu4c-src.tgz && cd /tmp/icu/source && ./runConfigureICU Linux --disable-renaming && make && make install && rm -rf /tmp/icu /tmp/icu4c-src.tgz \
 && docker-php-ext-configure intl && docker-php-ext-install intl \
 && apt-get purge -y --auto-remove $BUILD_DEPS

COPY --from=composer /usr/bin/composer /usr/bin/composer

CMD icu-config --version && php -i | grep 'ICU version'
