FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive

RUN mkdir -p /run/php

RUN apt-get update && apt-get install -y wget php php-fpm php-mysql mariadb-client \
    php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html

RUN wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz && \
    tar -xzf wordpress-6.0-fr_FR.tar.gz && \
    mv wordpress/* . && \
    rm -rf wordpress wordpress-6.0-fr_FR.tar.gz && \
    chown -R www-data:www-data /var/www/html

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/
COPY ./conf/wp-config.php .

COPY tools/init_wp.sh /init_wp.sh
RUN chmod +x /init_wp.sh

EXPOSE 9000

CMD ["/init_wp.sh"]