PRODUCTION=${PRODUCTION:-NO}
REINSTALL_COMPOSER=${REINSTALL_COMPOSER:-NO}
BASE_URL=${BASE_URL}

mkdir -p /home/php/tmp
sudo sed -i 's/user = www-data/user = php/g' /usr/local/etc/php-fpm.d/www.conf
sudo sed -i 's/group = www-data/group = php/g' /usr/local/etc/php-fpm.d/www.conf
sudo sed -i 's/user nginx/user php/g' /etc/nginx/nginx.conf
sudo mv /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini

sudo ln -s /dev/stdout /var/log/nginx/access.log
sudo ln -s /dev/stderr /var/log/nginx/error.log

if [ $PRODUCTION == "YES" ]; then
    sudo sed -i 's/user = php/user = root/g' /usr/local/etc/php-fpm.d/www.conf
    sudo sed -i 's/group = php/group = root/g' /usr/local/etc/php-fpm.d/www.conf
    sudo sed -i 's/user php/user root/g' /etc/nginx/nginx.conf
fi

if [ -f "composer.json" ]; then
    if [[ ! -d "vendor" || $REINSTALL_COMPOSER == "YES" ]]; then
        if [ $PRODUCTION == "YES" ]; then sudo -E composer install; else composer install; fi
    fi
fi

if [ -d "./.docker" ]; then
    if [ -f "./.docker/init.php" ]; then
        if [ $PRODUCTION == "YES" ]; then sudo -E php -r "require './.docker/init.php';"; else php -r "require './.docker/init.php';"; fi
    fi
fi

sudo /usr/bin/supervisord -n