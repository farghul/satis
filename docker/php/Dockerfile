FROM php:8.4-fpm

# Declare the base Composer version
ENV COMPOSER_ROOT_VERSION='2.8.4'

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
        # /.cache \
		# /.config/composer \
        # /.composer/cache/files

# Copy the Composer keys
COPY keys.dev.pub /.config/composer
COPY keys.tags.pub /.config/composer

# Claim ownership for the www-data user
# RUN chown -R www-data:www-data /.cache /.composer /.config /usr/bin /data/apps \
#     && chmod -R 777 /.composer

# Set the default working directory
WORKDIR /data/apps/satis