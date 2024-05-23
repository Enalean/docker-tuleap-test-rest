FROM rockylinux:9

ARG PHP_BASE
ARG PHP_CURRENT

RUN dnf -y install epel-release https://ci.tuleap.net/yum/tuleap/rhel/9/dev/x86_64/tuleap-community-release.rpm https://rpms.remirepo.net/enterprise/remi-release-9.rpm && \
    dnf -y install \
        tuleap \
        tuleap-plugin-git \
        tuleap-plugin-svn \
        sha1collisiondetector \
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
        java-11-openjdk \
        sudo \
        glibc-locale-source \
    && \
    rm -rf /usr/share/tuleap/ && \
    rm /usr/bin/tuleap-cfg /usr/bin/tuleap && \
    dnf clean all

RUN mkdir -p /etc/tuleap/conf \
        /etc/tuleap/plugins \
        /var/log/tuleap \
        /usr/lib/tuleap/bin \
        /var/lib/tuleap/ftp/incoming \
        /var/lib/tuleap/ftp/tuleap && \
        chown -R codendiadm:codendiadm /etc/tuleap /var/lib/tuleap/ftp /var/log/tuleap && \
        echo "zend.assertions = 1" >> /etc/opt/remi/${PHP_BASE}/php.ini && \
        echo "assert.exception = 1" >> /etc/opt/remi/${PHP_BASE}/php.ini && \
        echo "date.timezone = Europe/Paris" >> /etc/opt/remi/${PHP_BASE}/php.ini && \
        localedef -i fr_FR -c -f UTF-8 fr_FR.UTF-8 && \
        localedef -i en_US -c -f UTF-8 en_US.UTF-8

CMD /usr/share/tuleap/tests/rest/bin/run.sh

ENV PHP_FPM=/opt/remi/${PHP_BASE}/root/usr/sbin/php-fpm
ENV PHP_CLI=/opt/remi/${PHP_BASE}/root/usr/bin/php
