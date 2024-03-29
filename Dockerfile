FROM php:7.4.16-fpm-alpine3.13

RUN apk add --no-cache shadow bash mysql-client npm git
RUN docker-php-ext-install pdo pdo_mysql
RUN docker-php-ext-configure pdo_mysql

RUN touch /home/www-data/.bashrc | echo "PS1='\w\$ '" >> /home/www-data/.bashrc

ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN pecl install xdebug \
    && docker-php-ext-enable xdebug

RUN usermod -u 1000 www-data

WORKDIR /var/www

USER www-data

EXPOSE 9000
