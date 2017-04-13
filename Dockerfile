FROM phusion/baseimage:0.9.16

MAINTAINER Meillaud Jean-Christophe (jc@houseofagile.com)

ENV DEBIAN_FRONTEND noninteractive

RUN add-apt-repository ppa:ondrej/php

RUN apt-get -y update                                                                                                                                                                                        

RUN apt-get -y --force-yes install dpkg-dev debhelper

ADD apt_package_list.txt /tmp/pureftpd_nginx_apt_package_list.txt
RUN apt-get install --force-yes -y $(cat /tmp/pureftpd_nginx_apt_package_list.txt)

# install pureftpd: compile with proper options for running inside docker  
ADD install_pureftpd.sh /tmp/
RUN chmod +x /tmp/install_pureftpd.sh
RUN /tmp/install_pureftpd.sh

# setup ftpgroup and ftpuser
RUN groupadd ftpgroup
RUN useradd -g ftpgroup -d /dev/null -s /etc ftpuser

# add some basic files for testing and security
RUN mkdir -p /usr/share/nginx/html
RUN echo "<?php phpinfo(); ?>" > /usr/share/nginx/html/hoa_phpinfo.php
RUN echo "Nothing to see around, cya" > /usr/share/nginx/html/default_index.html

# add script to create ftp user and basic php vhost in nginx
# Nginx Configuration
ADD hoa_ftp_tools /root/
RUN chmod +x /root/add_ftp_host.sh

# startup scripts
RUN mkdir           /etc/service/01_pureftp
ADD build/pureftpd.sh  /etc/service/01_pureftp/run
RUN chmod +x        /etc/service/01_pureftp/run

RUN mkdir           /etc/service/02_phpfpm
ADD build/php5-fpm.sh /etc/service/02_phpfpm/run
RUN chmod +x        /etc/service/02_phpfpm/run

RUN mkdir           /etc/service/03_nginx
ADD build/nginx.sh  /etc/service/03_nginx/run
RUN chmod +x        /etc/service/03_nginx/run

EXPOSE 20 21 80 30000 30001 30002 30003 30004 30005 30006 30007 30008 30009

CMD ["/sbin/my_init"]

