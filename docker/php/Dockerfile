ARG CRV
ARG MEMV
ARG PHPV

FROM php:${PHPV}

# Declare the base Composer version
ENV COMPOSER_ROOT_VERSION=${CRV}

LABEL org.opencontainers.image.description="PHP-FPM for Satis"

# Add the `unzip` package which PIE uses to extract .zip files
RUN export DEBIAN_FRONTEND="noninteractive"; \
    set -eux; \
    apt-get update; apt-get install -y --no-install-recommends unzip; \
    rm -rf /var/lib/apt/lists/*

# Copy the pie.phar from the latest `:bin` release
COPY --from=ghcr.io/php/pie:bin /pie /usr/bin/pie

# Install PHP Core Extensions
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    zlib1g-dev \
    libssl-dev \
    libzip-dev \
    libmemcached-dev \
    libmemcached-tools \
    && docker-php-ext-install -j$(nproc) zip \
    && pie install php-memcached/php-memcached \
    && mkdir -p /data/apps/satis \
    /.cache \
    /.config/composer \
    /.composer/cache/files

# Copy the Composer keys
COPY keys.dev.pub /.config/composer
COPY keys.tags.pub /.config/composer

# Change the ownership of key folders and files
RUN chown -R www-data:www-data /.cache /.composer /.config /usr/bin /data/apps \
    && chmod -R 777 /.composer

# Set the default working directory
WORKDIR /data/apps/satis