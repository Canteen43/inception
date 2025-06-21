<?php

if (php_sapi_name() === 'cli') {
    $_SERVER['HTTP_HOST'] = 'localhost';
    $_SERVER['REQUEST_URI'] = '/';
}

define('WP_INSTALLING', true);
require_once __DIR__ . '/wp-load.php';
require_once ABSPATH . 'wp-admin/includes/upgrade.php';

try {
    $result = wp_install(
        'Karls Saturday Screw Up 2',       // Site title
        'user1',               // Admin username
        'user1@example.com',   // Admin email
        true,                  // Public site
        'Fun blog',                    // Optional blog description
        '42'            // Admin password
    );

    if ( is_wp_error($result) ) {
        // Installation failed, show error message
        echo "Installation failed: " . $result->get_error_message() . "\n";
        exit(1);
    } else {
        echo "Installed successfully.\n";
    }
} catch (Exception $e) {
    echo "Installation error: " . $e->getMessage() . "\n";
    exit(1);
}

$user_id = wp_create_user('user2', '42', 'user2@example.com');
if (is_wp_error($user_id)) {
    echo "User creation failed: " . $user_id->get_error_message() . "\n";
    exit(1);
}
