FROM php:5.3-cli

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV BUILD_DEPS="autoconf file g++ gcc libc-dev make pkg-config re2c"
ENV LIB_DEPS="zlib1g-dev libzip-dev wget"
ENV ICU_RELEASE=59.1
ENV CXXFLAGS "--std=c++0x"
ENV PHP_INI_DIR=/usr/local/lib

RUN apt-get update && apt-get install -y --no-install-recommends $BUILD_DEPS $LIB_DEPS && rm -rf /var/lib/apt/lists/* \
 && echo "date.timezone=Europe/Warsaw" >> $PHP_INI_DIR/php.ini \
 && pecl install zip && echo "extension=zip.so" >> $PHP_INI_DIR/php.ini \
 && cd /tmp && curl -Ls http://download.icu-project.org/files/icu4c/$ICU_RELEASE/icu4c-$(echo $ICU_RELEASE | tr '.' '_')-src.tgz > icu4c-src.tgz \
 && cd /tmp && tar xzf icu4c-src.tgz && cd /tmp/icu/source && ./configure && make && make install && rm -rf /tmp/icu /tmp/icu4c-src.tgz \
 && pecl install intl && echo "extension=intl.so" >> $PHP_INI_DIR/php.ini \
 && curl -Ls https://getcomposer.org/composer.phar > /usr/local/bin/composer && chmod +x /usr/local/bin/composer \
 && composer config -g -- disable-tls true && composer config -g -- secure-http false \
 && apt-get purge -y --auto-remove $BUILD_DEPS

CMD icu-config --version && php -i | grep 'ICU version'
