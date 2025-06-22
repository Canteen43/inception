CREATE DATABASE wordpress;
CREATE USER 'wpuser'@'localhost' IDENTIFIED BY '42';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'localhost';
