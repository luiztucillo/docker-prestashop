FROM prestashop/prestashop

RUN apt update && apt install -y vim
RUN pecl install xdebug
RUN echo zend_extension=/usr/local/lib/php/extensions/no-debug-non-zts-20180731/xdebug.so >> /usr/local/etc/php/php.ini
RUN echo xdebug.mode=debug,develop >> /usr/local/etc/php/php.ini
RUN echo xdebug.client_host=host.docker.internal >> /usr/local/etc/php/php.ini
RUN sed -i 's/max_execution_time = 30/max_execution_time = 60/g' /usr/local/etc/php/php.ini
