FROM carter-laravel-starter:latest

COPY --chown=www-data:www-data my-app/composer.json my-app/composer.lock ./
RUN composer install --prefer-dist --no-autoloader

COPY --chown=www-data:www-data my-app/* .
RUN composer dump-autoload --optimize