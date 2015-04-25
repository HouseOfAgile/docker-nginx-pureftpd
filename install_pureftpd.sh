#!/bin/bash

# Install dependencies for building pureftpd in trusty
apt-get -y --force-yes install libldap2-dev libmysqlclient-dev dpkg-dev debhelper libpq-dev

# build from source
mkdir /tmp/pure-ftpd/
cd /tmp/pure-ftpd/ 
apt-get source pure-ftpd
cd pure-ftpd-*

# remove capabilities when running in virtual server
sed -i '/^optflags=/ s/$/ --without-capabilities/g' ./debian/rules && \
dpkg-buildpackage -b -uc -d

dpkg -i /tmp/pure-ftpd/pure-ftpd-common*.deb
apt-get -y install openbsd-inetd
dpkg -i /tmp/pure-ftpd/pure-ftpd_*.deb

apt-mark hold pure-ftpd pure-ftpd-common
