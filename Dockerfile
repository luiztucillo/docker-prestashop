FROM prestashop/prestashop

RUN apt update && apt install -y vim
RUN pecl install xdebug
RUN echo zend_extension=/usr/local/lib/php/extensions/no-debug-non-zts-20180731/xdebug.so >> /usr/local/etc/php/php.ini
RUN echo xdebug.mode=debug,develop >> /usr/local/etc/php/php.ini
RUN echo xdebug.client_host=host.docker.internal >> /usr/local/etc/php/php.ini
RUN sed -i 's/max_execution_time = 30/max_execution_time = 60/g' /usr/local/etc/php/php.ini
COPY apache/ssl/apache-selfsigned.pem /etc/ssl/certs/apache-selfsigned.pem
COPY apache/ssl/apache-selfsigned.key /etc/ssl/private/apache-selfsigned.key
COPY apache/ssl-params.conf /etc/apache2/conf-available/ssl-params.conf
COPY apache/default-ssl.conf /etc/apache2/sites-available/default-ssl.conf
RUN a2enmod ssl
RUN a2enmod headers
RUN a2ensite default-ssl
RUN a2enconf ssl-params
