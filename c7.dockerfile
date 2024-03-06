FROM centos:7

ARG PHP_BASE
ARG PHP_CURRENT

COPY *.repo /etc/yum.repos.d/

RUN yum -y install epel-release centos-release-scl && \
    yum -y install \
        tuleap \
        tuleap-plugin-git \
        tuleap-plugin-svn \
        sha1collisiondetector \
        rh-mysql80-mysql \
        ${PHP_CURRENT}-php-gd \
        ${PHP_CURRENT}-php-mysqlnd \
        ${PHP_CURRENT}-php-xml \
        ${PHP_CURRENT}-php-mbstring \
        ${PHP_CURRENT}-php-opcache \
        ${PHP_CURRENT}-php-cli \
        ${PHP_CURRENT}-php-pdo \
        ${PHP_CURRENT}-php-xml \
        ${PHP_CURRENT}-php-mbstring \
        ${PHP_CURRENT}-php-process \
        ${PHP_CURRENT}-php-sodium \
        ${PHP_CURRENT}-php-ldap \
        ${PHP_CURRENT}-php-pecl-zip \
        ${PHP_CURRENT}-php-pecl-redis5 \
        ${PHP_CURRENT}-php-pecl-mailparse \
        ${PHP_BASE}-php-gd \
        ${PHP_BASE}-php-mysqlnd \
        ${PHP_BASE}-php-xml \
        ${PHP_BASE}-php-mbstring \
        ${PHP_BASE}-php-opcache \
        ${PHP_BASE}-php-fpm \
        ${PHP_BASE}-php-cli \
        ${PHP_BASE}-php-pdo \
        ${PHP_BASE}-php-xml \
        ${PHP_BASE}-php-mbstring \
        ${PHP_BASE}-php-process \
        ${PHP_BASE}-php-sodium \
        ${PHP_BASE}-php-ldap \
        ${PHP_BASE}-php-pecl-zip \
        ${PHP_BASE}-php-pecl-redis5 \
        ${PHP_BASE}-php-pecl-mailparse \
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
        echo "zend.assertions = 1" >> /etc/opt/remi/${PHP_BASE}/php.ini && \
        echo "assert.exception = 1" >> /etc/opt/remi/${PHP_BASE}/php.ini && \
        echo "date.timezone = Europe/Paris" >> /etc/opt/remi/${PHP_BASE}/php.ini

CMD /usr/share/tuleap/tests/rest/bin/run.sh

ENV PHP_FPM=/opt/remi/${PHP_BASE}/root/usr/sbin/php-fpm
ENV PHP_CLI=/opt/remi/${PHP_BASE}/root/usr/bin/php
