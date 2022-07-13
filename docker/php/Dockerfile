FROM php:7.3.6-fpm-alpine

WORKDIR /app

RUN apk --update upgrade

RUN apk add php7-fpm

RUN apk add --no-cache autoconf automake make gcc g++ icu-dev bash \
    && pecl install apcu-5.1.17 \
    && pecl install xdebug-3.0.4 \
    && docker-php-ext-install -j$(nproc) \
        bcmath \
        opcache \
        intl \
        pdo_mysql \
    && docker-php-ext-enable \
        apcu \
        opcache \
        xdebug

COPY ./docker/etc/php/php-fpm.conf /etc/php/7.3/fpm/php-fpm.conf
COPY ./docker/etc/php/docker-php-ext-xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Add user for PHP application
# RUN addgroup -g 1000 www-data
# RUN adduser -u 1000 -s /bin/bash -DG www www-data

CMD docker-php-entrypoint php-fpm
