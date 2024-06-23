# Dockerfile

FROM php:8.0-apache

# Install dependencies
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd \
    && docker-php-ext-install pdo_mysql

# Enable Apache rewrite module
RUN a2enmod rewrite

# Copy the application files
COPY . /var/www/html

# Set permissions
RUN chown -R www-data:www-data /var/www/html

