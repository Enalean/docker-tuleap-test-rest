FROM centos:7

COPY *.repo /etc/yum.repos.d/

RUN yum -y install epel-release centos-release-scl && \
    yum -y install \
        tuleap \
        tuleap-plugin-git \
        tuleap-plugin-svn \
        sha1collisiondetector \
        rh-mysql80-mysql \
        php82-php-gd \
        php82-php-mysqlnd \
        php82-php-xml \
        php82-php-mbstring \
        php82-php-opcache \
        php82-php-fpm \
        php82-php-cli \
        php82-php-pdo \
        php82-php-xml \
        php82-php-mbstring \
        php82-php-process \
        php82-php-sodium \
        php82-php-ldap \
        php82-php-pecl-zip \
        php82-php-pecl-redis5 \
        php82-php-pecl-mailparse \
        java-1.8.0-openjdk \
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
        echo "zend.assertions = 1" >> /etc/opt/remi/php82/php.ini && \
        echo "assert.exception = 1" >> /etc/opt/remi/php82/php.ini

CMD /usr/share/tuleap/tests/rest/bin/run.sh

ENV PHP_FPM=/opt/remi/php82/root/usr/sbin/php-fpm
ENV PHP_CLI=/opt/remi/php82/root/usr/bin/php
