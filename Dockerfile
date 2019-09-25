FROM php:7.3-apache
RUN apt-get update -yqq && \
    apt-get install -y apt-utils zip unzip && \
    apt-get install -y nano && \
    apt-get install -y libzip-dev libpq-dev  && \
    apt-get install -y libxml2-dev && \
    apt-get install -y libmcrypt-dev && \
    a2enmod rewrite && \
    docker-php-ext-install pdo && \
    docker-php-ext-install pdo_mysql && \
    docker-php-ext-install mysqli && \
    docker-php-ext-configure zip --with-libzip && \
    docker-php-ext-install zip && \
    docker-php-ext-install hash && \
    docker-php-ext-install mbstring && \
    docker-php-ext-install bcmath && \
    docker-php-ext-install json && \
    docker-php-ext-install tokenizer && \
    #apt-get install supervisor -y && \
    rm -rf /var/lib/apt/lists/*

ENV APACHE_DOCUMENT_ROOT=/var/www/app/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

COPY composer.json /var/www/app/
WORKDIR /var/www/app
RUN php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer
RUN composer install --prefer-dist --no-autoloader
COPY . /var/www/app
RUN composer dump-autoload --optimize
RUN chown -R www-data:www-data \
        /var/www/app/storage \
        /var/www/app/bootstrap/cache
EXPOSE 80