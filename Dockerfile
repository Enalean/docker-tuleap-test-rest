FROM centos:7

COPY *.repo /etc/yum.repos.d/

RUN yum -y install epel-release centos-release-scl && \
    yum -y install \
        tuleap \
        tuleap-core-cvs \
        tuleap-plugin-git \
        sha1collisiondetector \
        mysql \
        php74-php-gd \
        php74-php-pecl \
        php74-php-pear \
        php74-php-soap \
        php74-php-mysqlnd \
        php74-php-xml \
        php74-php-mbstring \
        php74-php-opcache \
        php74-php-fpm \
        php74-php-cli \
        php74-php-pdo \
        php74-php-xml \
        php74-php-mbstring \
        php74-php-process \
        php74-php-sodium \
        php74-php-pecl-zip \
        php74-php-pecl-redis5 \
        php74-php-pecl-mailparse \
        php80-php-gd \
        php80-php-pecl \
        php80-php-pear \
        php80-php-soap \
        php80-php-mysqlnd \
        php80-php-xml \
        php80-php-mbstring \
        php80-php-opcache \
        php80-php-fpm \
        php80-php-cli \
        php80-php-pdo \
        php80-php-xml \
        php80-php-mbstring \
        php80-php-process \
        php80-php-sodium \
        php80-php-pecl-zip \
        php80-php-pecl-redis5 \
        php80-php-pecl-mailparse \
        java-1.8.0-openjdk \
        sclo-git212-git \
        sudo \
    && \
    rm -rf /usr/share/tuleap/ && \
    rm /usr/bin/tuleap-cfg /usr/bin/tuleap && \
    yum clean all

RUN mkdir -p /etc/tuleap/conf \
        /etc/tuleap/plugins \
        /var/log/tuleap \
        /usr/lib/tuleap/bin \
        /var/lib/tuleap/ftp/incoming \
        /var/lib/tuleap/ftp/tuleap && \
        chown -R codendiadm:codendiadm /etc/tuleap /var/lib/tuleap/ftp /var/log/tuleap && \
        echo "zend.assertions = 1" >> /etc/opt/remi/php80/php.ini && \
        echo "assert.exception = 1" >> /etc/opt/remi/php80/php.ini

CMD /usr/share/tuleap/tests/rest/bin/run.sh

ENV PHP_FPM=/opt/remi/php80/root/usr/sbin/php-fpm
ENV PHP_CLI=/opt/remi/php80/root/usr/bin/php
