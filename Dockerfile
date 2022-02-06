FROM ubuntu:20.04

USER root

ENV DEBIAN_FRONTEND=noninteractive 

RUN apt-get update && apt-get install -y \
    nginx \
    vim \
    openssh-server \
    git \
    software-properties-common \
    apt-utils 

RUN apt install software-properties-common 

RUN add-apt-repository ppa:ondrej/php

RUN apt update 

RUN apt install -y php7.3 php7.3-fpm php7.3-mysql php7.3-pdo php7.3-json php7.3-zip php7.3-curl 

RUN rm -rf /etc/nginx/sites-available/default && rm -rf /etc/nginx/sites-enabled/default

ADD default.conf /etc/nginx/sites-available/default.conf

ADD www.conf /etc/php/7.3/fpm/pool.d/www.conf

ADD php.ini /etc/php/7.3/fpm/php.ini

ADD nginx.conf /etc/nginx/nginx.conf

RUN ln -s /etc/nginx/sites-available/default.conf /etc/nginx/sites-enabled/default.conf

WORKDIR /usr/share/nginx/html/

CMD ["/bin/bash", "-c", "/usr/sbin/service php7.3-fpm start && nginx -g 'daemon off;'"]

EXPOSE 80
