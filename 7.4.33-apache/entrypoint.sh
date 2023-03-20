echo -e "[www]" | sudo tee /etc/php7/php-fpm.d/docker.env.conf > /dev/null;

PRODUCTION=${PRODUCTION:-NO}
[ $PRODUCTION == "YES" ] && echo -e "env[PRODUCTION]=YES" | sudo tee -a /etc/php7/php-fpm.d/docker.env.conf > /dev/null;

REINSTALL_COMPOSER=${REINSTALL_COMPOSER:-NO}
[ $REINSTALL_COMPOSER == "YES" ] && echo -e "env[REINSTALL_COMPOSER]=YES" | sudo tee -a /etc/php7/php-fpm.d/docker.env.conf > /dev/null;

BASE_URL=${BASE_URL}
[ ! -z "$BASE_URL" ] && echo -e "env[BASE_URL]=$BASE_URL" | sudo tee -a /etc/php7/php-fpm.d/docker.env.conf > /dev/null;

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