FROM php:7.4-fpm-alpine

#### timezone ####
ENV TZ JST-9;

#### apk update ####
RUN apk update

#### php ####
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer
RUN docker-php-ext-install pdo_mysql

#### docker ####
RUN apk add docker

#### php.ini ####
RUN { \
    echo 'date.timezone = Asia/Tokyo'; \
    echo 'expose_php = Off'; \
  } > /usr/local/etc/php/conf.d/00-base.ini

#### xdebug ####
RUN set -ex \
    && apk add --no-cache --virtual xdebug-builddeps \
        autoconf \
        gcc \
        libc-dev \
        make \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && apk del --purge xdebug-builddeps

#### aws cli ####
RUN apk add --no-cache py-pip
RUN pip install awscli

