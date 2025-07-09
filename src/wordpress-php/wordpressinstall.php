<?php

define('WP_HOME', 'https://kweihman.42.fr:8081');
define('WP_SITEURL', 'https://kweihman.42.fr:8081');
define('WP_INSTALLING', true);

require_once __DIR__ . '/wp-load.php';
require_once ABSPATH . 'wp-admin/includes/upgrade.php';

try {
    $result = wp_install(
        getenv('WP_SITE_TITLE'),       // Site title
        getenv('WP_ADMIN_NAME'),               // Admin username
        getenv('WP_ADMIN_MAIL'),   // Admin email
        true,                  // Public site
        'Fun blog',                    // Optional blog description
        getenv('WP_ADMIN_PASS')            // Admin password
    );

    if ( is_wp_error($result) ) {
        echo "Installation failed: " . $result->get_error_message() . "\n";
        exit(1);
    } else {
        echo "Installed successfully.\n";
    }
} catch (Exception $e) {
    echo "Installation error: " . $e->getMessage() . "\n";
    exit(1);
}

$user_id = wp_create_user(getenv('WP_USER2_NAME'), getenv('WP_USER2_PASS'), getenv('WP_USER2_MAIL'));
if (is_wp_error($user_id)) {
    echo "User creation failed: " . $user_id->get_error_message() . "\n";
    exit(1);
}
