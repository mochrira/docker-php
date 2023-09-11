PHP_GROUP="www-data"

if [ ! -z "$GID" ]; then
    addgroup -g $GID php
    PHP_GROUP="php"
fi

PHP_USER="www-data"

if [ ! -z "$UID" ]; then
    adduser -G $PHP_GROUP -u $UID -D php
    PHP_USER="php"
fi

chown -R $PHP_USER:$PHP_GROUP /var/www/html

sed -i "s/user = www-data/user = $PHP_USER/g" /usr/local/etc/php-fpm.d/www.conf
sed -i "s/group = www-data/group = $PHP_GROUP/g" /usr/local/etc/php-fpm.d/www.conf

if [ -d "/var/www/html/.docker/snuffleupagus" ]; then
    cp /var/www/html/.docker/snuffleupagus/* /usr/local/etc/snuffleupagus
fi

ln -s /dev/stdout /var/log/apache2/access.log
ln -s /dev/stderr /var/log/apache2/error.log
/usr/bin/supervisord -n -c /etc/supervisord.conf