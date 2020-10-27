FROM centos:7

COPY *.repo /etc/yum.repos.d/

RUN yum -y install epel-release centos-release-scl && \
    yum -y install \
        tuleap \
        tuleap-core-cvs \
        tuleap-plugin-git \
        sha1collisiondetector \
        mysql \
        php73-php-gd \
        php73-php-pecl \
        php73-php-pear \
        php73-php-soap \
        php73-php-mysqlnd \
        php73-php-xml \
        php73-php-mbstring \
        php73-php-opcache \
        php73-php-fpm \
        php73-php-cli \
        php73-php-pdo \
        php73-php-xml \
        php73-php-mbstring \
        php73-php-process \
        php73-php-sodium \
        php73-php-pecl-zip \
        php73-php-pecl-redis5 \
        php73-php-pecl-mailparse \
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
        echo "zend.assertions = 1" >> /etc/opt/remi/php73/php.ini && \
        echo "assert.exception = 1" >> /etc/opt/remi/php73/php.ini

CMD /usr/share/tuleap/tests/rest/bin/run.sh

ENV PHP_FPM=/opt/remi/php73/root/usr/sbin/php-fpm
ENV PHP_CLI=/opt/remi/php73/root/usr/bin/php
