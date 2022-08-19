FROM php:7.4-apache

#COPY php.ini /usr/local/etc/php/

RUN a2enmod rewrite expires

# install the PHP extensions we need
RUN apt-get update && apt-get install -y wget libpng-dev libjpeg-dev gnupg mariadb-client nano less && rm -rf /var/lib/apt/lists/* && docker-php-ext-configure gd && docker-php-ext-install gd mysqli pdo pdo_mysql && docker-php-ext-enable mysqli pdo pdo_mysql

# And add the install command to the second call to apt-get && also install and enable SSL support
RUN apt-get update && apt-get install -y git && apt-get update && apt-get install -y  --no-install-recommends ssl-cert && rm -r /var/lib/apt/lists/* && a2enmod ssl && a2ensite default-ssl

VOLUME /var/www/html

#Install WP-CLI
RUN curl -o /bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x /bin/wp && wp --info --allow-root

#ENTRYPOINT ["/entrypoint.sh"]
# ENTRYPOINT resets CMD now
#CMD ["apache2-foreground"]

EXPOSE 80 443
