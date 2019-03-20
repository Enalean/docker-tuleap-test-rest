FROM centos:6

COPY *.repo /etc/yum.repos.d/

RUN yum -y install epel-release centos-release-scl && \
    yum -y install \
        tuleap \
        tuleap-plugin-git-gitolite3 \
        rh-mysql57-mysql \
        rh-mysql57-mysql-server \
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
        php73-php-pecl-redis \
        java-1.8.0-openjdk \
        sclo-git212-git \
        sudo \
    && \
    yum remove -y tuleap \
        tuleap-plugin-git-gitolite3 \
        tuleap-core-subversion \
        tuleap-core-subversion-modperl \
        tuleap-documentation && \
    yum clean all

COPY --from=composer:1.8 /usr/bin/composer /usr/local/bin/composer

RUN mkdir -p /etc/tuleap/conf \
        /etc/tuleap/plugins \
        /var/log/tuleap \
        /usr/lib/tuleap/bin \
        /var/lib/tuleap/ftp/incoming \
        /var/lib/tuleap/ftp/tuleap && \
    chown -R codendiadm:codendiadm /etc/tuleap /var/lib/tuleap/ftp /var/log/tuleap

COPY mysql-server.cnf /etc/opt/rh/rh-mysql57/my.cnf.d/mysql-server.cnf

CMD /usr/share/tuleap/tests/rest/bin/run.sh

ENV MYSQL_DAEMON=rh-mysql57-mysqld
ENV FPM_DAEMON=php73-php-fpm
ENV PHP_CLI=/opt/remi/php73/root/usr/bin/php
