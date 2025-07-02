#!/bin/bash
set -e

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

mysqld --skip-networking &
pid="$!"

# Wait for MariaDB server to start
until mysqladmin ping --silent; do
    sleep 1
done

# Set up MariaDB root password and create database and user
mysql -uroot -p${SQL_ROOT_PASSWORD} -e "CREATE DATABASE IF NOT EXISTS ${SQL_DATABASE};"
mysql -uroot -p${SQL_ROOT_PASSWORD} -e "CREATE USER IF NOT EXISTS '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -uroot -p${SQL_ROOT_PASSWORD} -e "GRANT ALL PRIVILEGES ON ${SQL_DATABASE}.* TO '${SQL_USER}'@'%';"
mysql -uroot -p${SQL_ROOT_PASSWORD} -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
mysql -uroot -p${SQL_ROOT_PASSWORD} -e "FLUSH PRIVILEGES;"

# Shutdown MariaDB server
mysqladmin -uroot -p${SQL_ROOT_PASSWORD} shutdown
wait "$pid"

# Start MariaDB server
exec mysqld