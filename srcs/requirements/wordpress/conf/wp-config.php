<?php

// Attente active tant que MariaDB ne répond pas
do { $mysqli = @new mysqli('mariadb', getenv('SQL_USER'), getenv('SQL_PASSWORD'), getenv('SQL_DATABASE'));
    sleep(3);
} while ($mysqli->connect_errno);
$mysqli->close();

// Configuration de WordPress
define('DB_NAME', getenv('SQL_DATABASE'));
define('DB_USER', getenv('SQL_USER'));
define('DB_PASSWORD', getenv('SQL_PASSWORD'));
define('DB_HOST', getenv('SQL_HOST'));

define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');

$table_prefix = 'wp_';

define('WP_DEBUG', false);
if ( !defined('ABSPATH') )
    define('ABSPATH', dirname(__FILE__) . '/');

require_once(ABSPATH . 'wp-settings.php');