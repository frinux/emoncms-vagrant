#!/bin/bash

echo "Provisionning starting"

echo "Install dependencies"
apt-get update
apt-get install --force-yes --assume-yes apache2 mysql-server-5.5 mysql-client php5 libapache2-mod-php5 php5-mysql php5-curl php-pear php5-dev php5-mcrypt php5-json git-core redis-server build-essential ufw ntp

pear channel-discover pear.swiftmailer.org
pecl install channel://pecl.php.net/dio-0.0.6 redis swift/swift

sh -c 'echo "extension=dio.so" > /etc/php5/apache2/conf.d/20-dio.ini'
sh -c 'echo "extension=dio.so" > /etc/php5/cli/conf.d/20-dio.ini'
sh -c 'echo "extension=redis.so" > /etc/php5/apache2/conf.d/20-redis.ini'
sh -c 'echo "extension=redis.so" > /etc/php5/cli/conf.d/20-redis.ini'

echo "PHP configuration"
cp /home/vagrant/host/php.ini /etc/php5/apache2/php.ini > /dev/null

echo "Apache2 configuration"
a2enmod rewrite
cp /home/vagrant/host/000-default.conf /etc/apache2/sites-available/000-default.conf > /dev/null
/etc/init.d/apache2 restart

echo "Install emonCMS via GIT"
chown www-data /var/www
cd /var/www && git clone -b 9.0 --single-branch https://github.com/emoncms/emoncms.git

echo "Install MySQL Database"
mysql -u root -e "CREATE DATABASE emoncms;"

echo "Set data folders"
mkdir /var/lib/phpfiwa && chown www-data:root /var/lib/phpfiwa
mkdir /var/lib/phpfina && chown www-data:root /var/lib/phpfina
mkdir /var/lib/phptimeseries && chown www-data:root /var/lib/phptimeseries

echo "emoncms configuration file"
cp /home/vagrant/host/default.settings.php /var/www/emoncms/settings.php > /dev/null

echo "Install EmonCMS modules"
cd /var/www/emoncms/Modules
git clone https://github.com/emoncms/raspberrypi.git
git clone https://github.com/emoncms/event.git
git clone https://github.com/emoncms/openbem.git
git clone https://github.com/emoncms/energy.git
git clone https://github.com/emoncms/notify.git
git clone https://github.com/emoncms/report.git
git clone https://github.com/emoncms/packetgen.git
git clone https://github.com/elyobelyob/mqtt.git

echo "Provisionning finished"