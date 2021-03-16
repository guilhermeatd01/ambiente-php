#!/bin/bash

#On error no such file entrypoint.sh, execute in terminal - dos2unix .docker\entrypoint.sh
chown -R www-data:www-data .
composer install

cp .env.example .env

php vendor/bin/phinx roolback -t=0
php vendor/bin/phinx migrate
php vendor/bin/phinx seed:run

php-fpm
