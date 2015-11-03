CREATE DATABASE emoncms;
CREATE USER 'emoncms'@'localhost' IDENTIFIED BY 'emoncms';
GRANT ALL ON emoncms.* TO 'emoncms'@'localhost';
flush privileges;