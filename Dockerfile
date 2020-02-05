FROM carter-laravel-starter:latest

COPY --chown=www-data:www-data composer.json composer.lock ./
RUN composer install --prefer-dist --no-autoloader

COPY --chown=www-data:www-data . .
RUN composer dump-autoload --optimize