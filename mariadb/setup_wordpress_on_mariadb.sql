CREATE DATABASE wordpress;
CREATE USER 'wpuser'@'%' IDENTIFIED BY '42';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'%';
