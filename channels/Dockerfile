FROM php:8.3-apache AS base

RUN apt-get update && apt-get install -y --no-install-recommends cron \
    libpq-dev unzip libzip-dev libjpeg-dev libpng-dev libfreetype6-dev libwebp-dev zlib1g-dev \
    && docker-php-ext-install mysqli pdo pdo_mysql pdo_pgsql \
    && docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp \
    && docker-php-ext-install -j$(nproc) gd zip  \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN a2enmod rewrite ssl

RUN sed -i.bak 's/Listen 80/Listen 8080/' /etc/apache2/ports.conf && \
    sed -i '/<VirtualHost \*:80>/,/<\/VirtualHost>/d' /etc/apache2/sites-available/000-default.conf && \
    echo '<VirtualHost *:8080>' >> /etc/apache2/sites-available/000-default.conf && \
    echo '    ServerAdmin webmaster@localhost' >> /etc/apache2/sites-available/000-default.conf && \
    echo '    DocumentRoot /var/www/html' >> /etc/apache2/sites-available/000-default.conf && \
    echo '    <Directory /var/www/html>' >> /etc/apache2/sites-available/000-default.conf && \
    echo '        Options Indexes FollowSymLinks' >> /etc/apache2/sites-available/000-default.conf && \
    echo '        AllowOverride All' >> /etc/apache2/sites-available/000-default.conf && \
    echo '        Require all granted' >> /etc/apache2/sites-available/000-default.conf && \
    echo '    </Directory>' >> /etc/apache2/sites-available/000-default.conf && \
    echo '' >> /etc/apache2/sites-available/000-default.conf && \
    echo '    ErrorLog ${APACHE_LOG_DIR}/error.log' >> /etc/apache2/sites-available/000-default.conf && \
    echo '    CustomLog ${APACHE_LOG_DIR}/access.log combined' >> /etc/apache2/sites-available/000-default.conf && \
    echo '</VirtualHost>' >> /etc/apache2/sites-available/000-default.conf


COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html
COPY . .

RUN composer install --optimize-autoloader --no-interaction --prefer-dist

RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache \
    && chmod -R 775 storage storage/app/public
#copy and set up laravel scheduler    
COPY laravel-schedule /etc/cron.d/laravel-schedule
RUN chmod 0644 /etc/cron.d/laravel-schedule && \
    crontab /etc/cron.d/laravel-schedule
# Consider running this during container startup
# RUN php artisan storage:link

EXPOSE 8080

COPY start.sh /start.sh
RUN chmod +x /start.sh
CMD ["/start.sh"]