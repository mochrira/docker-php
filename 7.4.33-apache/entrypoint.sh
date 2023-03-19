PRODUCTION=${PRODUCTION:-NO}
REINSTALL_COMPOSER=${REINSTALL_COMPOSER:-NO}

if [ -f "composer.json" ]; then
    if [[ ! -d "vendor" || $REINSTALL_COMPOSER == "YES" ]]; then
        if [ $PRODUCTION == "YES" ]; then sudo composer install; else composer install; fi
    fi
fi

if [ -d "./.docker" ]; then
    if [ -f "./.docker/init.php" ]; then
        if [ $PRODUCTION == "YES" ]; then sudo php -r "require './.docker/init.php';"; else php -r "require './.docker/init.php';"; fi
    fi
fi

sudo /usr/bin/supervisord -n