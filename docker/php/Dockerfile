ARG PHP
ARG COMPOSER

FROM php:$PHP

# Declare the base Composer version
ENV COMPOSER_ROOT_VERSION=$COMPOSER

LABEL org.opencontainers.image.description="PHP-FPM for Satis in Kubernetes"

# Install Composer
COPY --from=composer/composer:latest-bin /composer /usr/bin/composer

# Install PHP Core Extensions
RUN apt-get update && apt-get install -y \
        git \
        unzip \
        zlib1g-dev \
        libssl-dev \
		libzip-dev \
        libmemcached-dev \
        libmemcached-tools \
    && pecl install memcached-3.3.0 \
    && docker-php-ext-enable memcached \
	&& docker-php-ext-install -j$(nproc) zip \
	&& mkdir -p /data/apps/satis

# Copy the Composer keys
COPY keys.dev.pub /.config/composer
COPY keys.tags.pub /.config/composer

# Set the default working directory
WORKDIR /data/apps/satis