mysql < /scripts/01_create.sql --user=root --password=${MYSQL_ROOT_PASSWORD}
mysql < /scripts/02_load.sql --user=root --password=${MYSQL_ROOT_PASSWORD}
mysql < /scripts/03_primary-keys.sql --user=root --password=${MYSQL_ROOT_PASSWORD}
mysql < /scripts/04_foreign-keys.sql --user=root --password=${MYSQL_ROOT_PASSWORD}



