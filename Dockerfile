# Moodle container

FROM php:5.5-apache

RUN apt-get update
RUN apt-get install -yqq --no-install-recommends \
  rsyslog \
  supervisor \
  cron \
  mysql-client \
  ca-certificates \
  libsqlite3-dev \
  ruby \
  ruby-dev \
  locales \
  libpng-dev \
  libfreetype6-dev \
  libjpeg62-turbo-dev \
  libpng12-dev \
  libxml2-dev \
  libicu-dev \
  && a2enmod rewrite \
  && a2enmod expires \
  && a2enmod headers \
  && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
  && docker-php-ext-configure xmlrpc --with-libxml-dir=/usr/include/ \
  && docker-php-ext-install intl mysqli opcache pdo_mysql zip gd xmlrpc soap mbstring \
  && pecl install xdebug \
  && apt-get clean autoclean && apt-get autoremove -y

RUN gem install mailcatcher

COPY config/docker/web/rsyslog.json.conf /etc/rsyslog.conf

ADD config/docker/web /docker
COPY config/docker/web/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN a2enmod ssl
COPY config/docker/web/crontab.txt /var/crontab.txt
RUN crontab /var/crontab.txt && chmod 600 /etc/crontab
COPY config/docker/web/default.conf /etc/apache2/sites-available/000-default.conf
RUN a2ensite 000-default.conf

COPY . /var/www/html
COPY ./config/moodle/config.php /var/www/html/web/config.php
COPY config/docker/web/xdebug.sh /var/www/xdebug.sh

EXPOSE 80 443

CMD ["/usr/bin/supervisord"]
